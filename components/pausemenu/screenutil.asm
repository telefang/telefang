SECTION " Pause Menu Screen Utils", ROMX[$5A06], BANK[4]
PauseMenu_ClearScreenTiles::
    push bc
    ld c, $10
    
.loop1
    xor a
    call YetAnotherWFB
    ld [hli], a
    dec c
    jr nz, .loop1
    
    pop bc
    dec b
    jr nz, PauseMenu_ClearScreenTiles
    
    ret