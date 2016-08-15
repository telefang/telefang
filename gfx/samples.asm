INCLUDE "components/sound/samples.inc"

SECTION "Sound Samples Table", ROM0[$3951]
Sound_SampleMetatable::
    dw Sound_SampleMetatable_gfx_title_voice_sample_pcm
    
Sound_SampleMetatable_gfx_title_voice_sample_pcm:
    db 1     ;Number of fragments.
    dsample Sound_gfx_title_voice_sample_pcm, $789F, 6, 6

SECTION "gfx/title/voice_sample.pcm", ROMX[$4000], BANK[$7C]
Sound_gfx_title_voice_sample_pcm:
    INCBIN "gfx/title/voice_sample.pcm"
Sound_gfx_title_voice_sample_pcm_END