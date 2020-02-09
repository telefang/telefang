SECTION "Lab/Fusion Label Old Gfx", ROMX[$5208], BANK[$38]
FusionLabLabelOldGfx::
	REPT $100
	nop
	ENDR

SECTION "Lab/Fusion Label Gfx", ROMX[$7E40], BANK[$38]
FusionLabelGfx::
	INCBIN "build/components/fusionlabevo/label_fusion_evo.2bpp"

LabLabelGfx::
	INCBIN "build/components/fusionlabevo/label_lab_evo.2bpp"
