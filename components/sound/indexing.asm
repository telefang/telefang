SECTION "Sound Indexing Memory", WRAM0[$CFF8]
W_Sound_MusicSet:: ds 1

SECTION "Sound Indexing", ROM0[$15F5]
Sound_IndexMusicSetBySong::
    cp $10
    jr nz, .midBank
    
.lowBank
    push af
    xor a
    jp .selectSet
    
.midBank
    cp $20
    jr nc, .highBank
    
    sub $F
    push af
    ld a, 1
    jp .selectSet
    
.highBank
    cp $30
    jr nc, .highestBank
    
    sub $1F
    push af
    ld a, 2
    jp .selectSet
    
.highestBank
    sub $2F
    push af
    ld a, 3
    
.selectSet
    ld [W_Sound_MusicSet], a
    pop af
    ret