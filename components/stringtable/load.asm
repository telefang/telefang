INCLUDE "components/stringtable/load.inc"

SECTION "String Table WRAM Locs", WRAMX[$D435], BANK[$1]
W_StringTable_ROMTblIndex:: ds 1

SECTION "String Table WRAM Locs 2", WRAMX[$D440], BANK[$1]
W_StringTable_StagingLoc:: ds 8

SECTION "String Table WRAM Locs 3", WRAMX[$D68D], BANK[$1]
W_StringTable_StagingLocDbl:: ds 8

SECTION "String Table Load Functions", ROM0[$3A01]
; HL = Base address of table.
; Table index is stored in W_StringTable_ROMTblIndex.
; Bank is assumed to already be selected by a Table Bank function
; (see table_banks.asm)
; Loaded string contents will be present in W_StringTable_StagingLocDbl
; NOTE: Patched with the LimitBreak function; will load TWICE as much data as
; the name would suggest.
StringTable_LoadFromROMTbl8::
    ld d, 0
    ld a, [W_StringTable_ROMTblIndex]
    ld e, a
    sla e
    rl d
    sla e
    rl d
    call PatchUtils_LimitBreak
    nop
    add hl, de
    ld bc, M_StringTable_Load8AreaSize
    ld de, W_StringTable_StagingLocDbl
    jp memcpy

StringTable_LoadFromROMTbl4::
    ld d, 0
    ld a, [W_StringTable_ROMTblIndex]
    ld e, a
    sla e
    rl d
    call PatchUtils_LimitBreak
    nop
    add hl, de
    ld bc, M_StringTable_Load4AreaSize
    ld de, W_StringTable_StagingLocDbl
    jp memcpy

SECTION "String Table Load Functions 2", ROM0[$3C8B]
StringTable_LoadBattlePhrase::
    ld a, [W_StringTable_ROMTblIndex]
    cp 0
    jr z, .noTblIndex
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    call PatchUtils_LimitBreak
    nop
    add hl, de
    
.noTblIndex
    ld bc, $1F
    ld de, $D658
    call memcpy
    ld a, $E0
    ld [$D4CF], a
    ret
