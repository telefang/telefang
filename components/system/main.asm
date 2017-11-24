INCLUDE "registers.inc"
INCLUDE "components/lcdc/vblank_irq.inc"

;The main gameloop is stored here.
;It's a giant nested state machine with a few common functions as well.

;These are dummy labels for functions not yet imported into the disassembly.
;We should do those soon.
SerIOActivityCheck EQU $0234
SoftResetCheck EQU $02D0
InitializeSGB EQU $4000 ;Bank 3, flat address 0xC000
SGBDetect EQU $41AF ;Bank 3, flat address 0xC1AF
ClearDMGPaletteShadow EQU $1043
InitializeSoundEngine EQU $0439
ClearTilemap0 EQU $0807

;WRAM locations we haven't properly labeled yet
W_SGBDetectSuccess EQU $C40A

;This stores the bootrom argument to determine what GB model we're on.
SECTION "System WRAM", WRAM0[$C3E8]
W_GameboyType:: ds 1

SECTION "System Gameloop WRAM", WRAM0[$C3C0]
W_FrameCounter:: ds 1
W_FrameCompleted:: ds 1

;Much of this corresponds with code that hasn't been imported into this
;project yet, so we're using EQUates for everything that's still missing
SECTION "EntryPoint", ROM0[$0150]
Main::
	ld [W_GameboyType], a
	di
	call LCDC_DisableLCD
	xor a
	ld [REG_IF], a
	ld [REG_IE], a ;Turn off all the interrupts
	ld sp, $DFFF
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 3
	ld [REG_MBC3_ROMBANK], a
	ld a, 0
	ld [REG_MBC3_ROMBANK], a ; WTF, setting ROMBANK twice?
	ld a, 0
	ld [REG_MBC3_SRAMBANK], a
	call ClearTilemap0
	call ClearTilePatternTables
	call ClearShadowOAM
	xor a
	ld [REG_VBK], a
	ld [REG_SVBK], a
	ld [REG_RP], a
	ld hl, $FE00
	ld c, 0
.clearOAMLoop
	ld [hli], a
	dec c
	jr nz, .clearOAMLoop	; WTF, let's clear longer than the actual length of OAM
	ld hl, $FF80
	ld c, $7F
.clearHRAMLoop
	ld [hli], a
	dec c
	jr nz, .clearHRAMLoop
	ld a, [W_GameboyType]
	push af
	call ClearWRAMVariables
	pop af
	ld [W_GameboyType], a ;Seems completely unnecessary, but it actually isn't
	call InstallODMADriver
	call InitializeSoundEngine
	ld a, 1
	ld [$C430], a
	call ClearDMGPaletteShadow
	ld a, $83
	ld [W_ShadowREG_LCDC], a
	ld [REG_LCDC], a ;Enable LCD display, OBJ, and BG layers.
	ei
	call SerIO_ResetConnection
	ld a, $40
	ld [REG_STAT], a
	xor a
	ld [REG_IF], a
	ld a, $B
	ld [REG_IE], a ;Only accept VBlank, LCD, and SIO interrupts
	xor a
	ld [W_SerIO_ConnectionState], a
	ld a, 1
	ld [W_CGBPaletteStagedBGP], a
	ld [W_CGBPaletteStagedOBP], a
	xor a
	call CGBLoadBackgroundPalette
	call CGBLoadObjectPalette
	ld a, 3
	rst $10
	xor a
	ld [W_SGBDetectSuccess], a
	call SGBDetect
	jp nc, .noSGBDetected
	ld a, 1
	ld [W_SGBDetectSuccess], a
	call InitializeSGB ;Bank 3, 0x4000
.noSGBDetected
	xor a
	ld [W_SystemState], a
	ld [W_SystemSubState], a
	ld a, 3
	rst $10
.gameLoop
	ld a, [W_FrameCounter]
	inc a
	ld [W_FrameCounter], a
	call SoftResetCheck
	ld a, [W_SerIO_ConnectionState]
	or a
	jr z, .dontProcessSerialIO
	call SerIO_RecvBufferPull
	call SerIO_SendBufferPush
	call SerIO_SendConnectPacket
.dontProcessSerialIO
	call SerIOActivityCheck
	call CGBCommitPalettes
	call CGBCommitScheduledPalette
	call JPInput_SampleJoypad
	call GameStateMachine
	call LoadSpritesForDMA
	ld a, 1
	ld [W_FrameCompleted], a
.waitForNextFrame
	ld a, [H_VBlankCompleted]
	and a
	jr z, .waitForNextFrame ; WTF: Not using the HALT opcode?
	xor a
	ld [H_VBlankCompleted], a
	ld [W_FrameCompleted], a
	jp .gameLoop
;Main never returns.