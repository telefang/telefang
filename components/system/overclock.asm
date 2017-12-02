INCLUDE "telefang.inc"

SECTION "CGB Overclock", ROMX[$6562], BANK[$B]
;Set the current CGB clock speed.
;B = 1 for high speed, 0 for normal
System_CGBToggleClockspeed::
    ret
    
    ;The following code has been dummied out by the original developers due to
    ;an incompatibility between RTC cartridges and double-speed operation. Real
    ;hardware doesn't support both features - at least, not the cartridges that
    ;Nintendo ultimately manufactured. Resolving this problem would have
    ;required new MBC hardware with tighter access timings, something Nintendo
    ;evidently did not want to support.
    
    ld a, [W_GameboyType]
    cp M_BIOS_CPU_CGB
    ret nz
    
    push hl
    ld hl, REG_KEY1
    ld a, b
    or a
    jr nz, .gotoFastMode
    
.gotoSlowMode
    di
    bit 7, [hl]
    jr z, .alreadySlow
    
.gottaGoSlow
    set 0, [hl]
    stop
    
.alreadySlow
    ei
    pop hl
    ret
    
.gotoFastMode
    di
    bit 7, [hl]
    jr nz, .alreadyFast
    
.gottaGoFast
    set 0, [hl]
    stop
    
.alreadyFast
    ei
    pop hl
    ret