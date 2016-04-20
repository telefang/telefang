GLOBAL Main
GLOBAL __start

SECTION "RomHeader", ROM0[$0100]
__start: nop
    jp Main
__nintendo: db  $CE, $ED, $66, $66, $CC,  $D,   0,  $B,   3, $73,   0
    db  $83,   0,  $C,   0,  $D,   0,   8, $11, $1F, $88, $89
    db    0,  $E, $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99, $BB
    db  $BB, $67, $63, $6E,  $E, $EC, $CC, $DD, $DC, $99, $9F
    db  $BB, $B9, $33, $3E
__gamename: db "TELEFANG PW"
__gamecode: db "BXTJ"
    db $80
    db $32
    db $4E
    db 0
    db $10
    db 6
    db 3
    db 0
    db $33
    db 0
    db $56
    db $F6
    db $8B