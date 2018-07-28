INCLUDE "telefang.inc"

SECTION "Sound Channel RW", ROMX[$4B25], BANK[$20]
Sound_WriteVoiceSweep::
    call Sound_SelectCurrentVoice
    ret nz
    push hl
    
    ld hl, Sound_VoiceSweepRegs
    jr Sound_WriteVoiceRegister
    
Sound_WriteVoiceLength::
    call Sound_SelectCurrentVoice
    ret nz
    push hl
    
    ld hl, Sound_VoiceLengthRegs
    jr Sound_WriteVoiceRegister
    
Sound_WriteVoiceVolume::
    call Sound_SelectCurrentVoice
    ret nz
    push hl
    
    ld a, [W_Sound_CurrentVoiceIndex]
    cp 2
    jr nz, .tone_channel_volume
    
    ;Write volume register for a wave channel.
    ;Since wave channels can only attenuate sounds by binary fractions, we map
    ;their volumes on a not-so-linear scale.
.wave_channel_volume
    ld a, [W_Sound_CurrentVoiceValue]
    swap a
    and $F
    ld hl, Sound_VoiceWaveVolumeScale
    add a, l
    ld l, a
    jr nc, .no_index_carry
    
.index_carry
    inc h
    
.no_index_carry
    ld a, [hl]
    ld [W_Sound_CurrentVoiceValue], a
    
    ld hl, Sound_VoiceVolumeRegs
    jr Sound_WriteVoiceRegister
    
    ;Write volume register for a tone channel.
    ;Masks lower bits to disable volume sweep.
.tone_channel_volume
    ld a, [W_Sound_CurrentVoiceValue]
    and $F0
    or 8
    ld [W_Sound_CurrentVoiceValue], a
    
    ld hl, Sound_VoiceVolumeRegs
    jr Sound_WriteVoiceRegister
    
Sound_WriteVoiceFreqLo::
    call Sound_SelectCurrentVoice
    ret nz
    push hl
    
    ld hl, Sound_VoiceFreqLoRegs
    jr Sound_WriteVoiceRegister
    
Sound_WriteVoiceFreqHi::
    call Sound_SelectCurrentVoice
    ret nz
    push hl
    
    ld hl, Sound_VoiceFreqHiRegs

Sound_WriteVoiceRegister::
    ld a, [W_Sound_CurrentVoiceIndex]
    add a, a
    add a, l
    ld l, a
    jr nc, .no_carry
    
.carry
    inc h
    
.no_carry
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [W_Sound_CurrentVoiceValue]
    ld [hl], a
    pop hl
    ret
    
Sound_SelectCurrentVoice::
    ld [W_Sound_CurrentVoiceValue], a
    
    ld a, [W_Sound_CurrentVoiceIndex]
    or a
    jr nz, .nonzero
    
.zero
    ld a, [$CEA0]
    or a
    ret
    
.nonzero
    xor a
    ret

Sound_WriteVoiceShadow::
    ld [W_Sound_CurrentVoiceValue], a
    
    ld a, [W_Sound_CurrentVoiceIndex]
    add a, $F0
    ld l, a
    ld h, $CF
    ld a, [W_Sound_CurrentVoiceValue]
    ld [hl], a
    ret
    
Sound_VoiceSweepRegs:: ;Some of these are placeholders and don't exist in HW
    dw REG_NR10,    $FF15, REG_NR30,    $FF1F, REG_NR10,    $FF1F
    
Sound_VoiceLengthRegs::
    dw REG_NR11, REG_NR21, REG_NR31, REG_NR41, REG_NR11, REG_NR41
    
Sound_VoiceVolumeRegs::
    dw REG_NR12, REG_NR22, REG_NR32, REG_NR42, REG_NR12, REG_NR42
    
Sound_VoiceFreqLoRegs::
    dw REG_NR13, REG_NR23, REG_NR33, REG_NR43, REG_NR13, REG_NR43
    
Sound_VoiceFreqHiRegs::
    dw REG_NR14, REG_NR24, REG_NR34, REG_NR44, REG_NR14, REG_NR44
    
Sound_VoiceWaveVolumeScale::
    db 0, $60, $40, $20, 0, 0, 0, 0