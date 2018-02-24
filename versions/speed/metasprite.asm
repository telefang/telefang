SECTION "MetaSprite metatable", ROM0[$94d]
MetaspriteBankMetatable::
    db BANK(MetaSprite_a)
    db BANK(MetaSprite_e)
    db BANK(MetaSprite_13)
    db BANK(MetaSprite_14)
    db BANK(MetaSprite_15)
    db BANK(MetaSprite_16)
    db BANK(MetaSprite_17)
    db BANK(MetaSprite_18)
    db BANK(MetaSprite_19)
MetaspriteAddressMetatable::
    dw MetaSprite_a
    dw MetaSprite_e
    dw MetaSprite_13
    dw MetaSprite_14
    dw MetaSprite_15
    dw MetaSprite_16
    dw MetaSprite_17
    dw MetaSprite_18
    dw MetaSprite_19

SECTION "MetaSprite_a", ROMX[$4000], BANK[$a]
MetaSprite_a::
    dw MetaSprite_a_4100
    dw MetaSprite_a_4100
    dw MetaSprite_a_4197
    dw MetaSprite_a_41bb
    dw MetaSprite_a_41df
    dw MetaSprite_a_4203
    dw MetaSprite_a_4227
    dw MetaSprite_a_424b
    dw MetaSprite_a_4260
    dw MetaSprite_a_4275
    dw MetaSprite_a_427b
    dw MetaSprite_a_4290
    dw MetaSprite_a_4296
    dw MetaSprite_a_429c
    dw MetaSprite_a_42a2
    dw MetaSprite_a_42a8
    dw MetaSprite_a_42bd
    dw MetaSprite_a_42dc
    dw MetaSprite_a_42e7
    dw MetaSprite_a_42f2
    dw MetaSprite_a_42fd
    dw MetaSprite_a_4308
    dw MetaSprite_a_430e
    dw MetaSprite_a_4314
    dw MetaSprite_a_431f
    dw MetaSprite_a_432a
    dw MetaSprite_a_4330
    dw MetaSprite_a_4336
    dw MetaSprite_a_435f
    dw MetaSprite_fungus_overhang
    dw MetaSprite_gymnos_overhang
    dw MetaSprite_a_43bc
    dw MetaSprite_a_43bc
    dw MetaSprite_a_43c7
    dw MetaSprite_a_43d2
    dw MetaSprite_a_43dd
    dw MetaSprite_a_43e8
    dw MetaSprite_a_43f3
    dw MetaSprite_a_43fe
    dw MetaSprite_a_4409
    dw MetaSprite_a_4414
    dw MetaSprite_a_441f
    dw MetaSprite_a_442a
    dw MetaSprite_a_4435
    dw MetaSprite_a_4440
    dw MetaSprite_a_444b
    dw MetaSprite_a_4456
    dw MetaSprite_a_4461
    dw MetaSprite_a_4471
    dw MetaSprite_a_4486
    dw MetaSprite_a_44a5
    dw MetaSprite_a_44c4
    dw MetaSprite_a_44d9
    dw MetaSprite_a_44ee
    dw MetaSprite_a_4503
    dw MetaSprite_a_4509
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_450f
    dw MetaSprite_a_45a6
    dw MetaSprite_a_4651
    dw MetaSprite_a_4666
    dw MetaSprite_a_468f
    dw MetaSprite_a_4758
    dw MetaSprite_a_4821
    dw MetaSprite_a_4859
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891
    dw MetaSprite_a_4891

SECTION "MetaSprite_a_4100", ROMX[$4100], BANK[$a]
MetaSprite_a_4100::
    INCBIN "gfx/unknown/metasprite_a/4100.sprite.bin"
MetaSprite_a_4100_END::
MetaSprite_a_4197::
    INCBIN "gfx/unknown/metasprite_a/4197.sprite.bin"
MetaSprite_a_4197_END::
MetaSprite_a_41bb::
    INCBIN "gfx/unknown/metasprite_a/41bb.sprite.bin"
MetaSprite_a_41bb_END::
MetaSprite_a_41df::
    INCBIN "gfx/unknown/metasprite_a/41df.sprite.bin"
MetaSprite_a_41df_END::
MetaSprite_a_4203::
    INCBIN "gfx/unknown/metasprite_a/4203.sprite.bin"
MetaSprite_a_4203_END::
MetaSprite_a_4227::
    INCBIN "gfx/unknown/metasprite_a/4227.sprite.bin"
MetaSprite_a_4227_END::
MetaSprite_a_424b::
    INCBIN "gfx/unknown/metasprite_a/424b.sprite.bin"
MetaSprite_a_424b_END::
MetaSprite_a_4260::
    INCBIN "gfx/unknown/metasprite_a/4260.sprite.bin"
MetaSprite_a_4260_END::
MetaSprite_a_4275::
    INCBIN "gfx/unknown/metasprite_a/4275.sprite.bin"
MetaSprite_a_4275_END::
MetaSprite_a_427b::
    INCBIN "gfx/unknown/metasprite_a/427b.sprite.bin"
MetaSprite_a_427b_END::
MetaSprite_a_4290::
    INCBIN "gfx/unknown/metasprite_a/4290.sprite.bin"
MetaSprite_a_4290_END::
MetaSprite_a_4296::
    INCBIN "gfx/unknown/metasprite_a/4296.sprite.bin"
MetaSprite_a_4296_END::
MetaSprite_a_429c::
    INCBIN "gfx/unknown/metasprite_a/429c.sprite.bin"
MetaSprite_a_429c_END::
MetaSprite_a_42a2::
    INCBIN "gfx/unknown/metasprite_a/42a2.sprite.bin"
MetaSprite_a_42a2_END::
MetaSprite_a_42a8::
    INCBIN "gfx/unknown/metasprite_a/42a8.sprite.bin"
MetaSprite_a_42a8_END::
MetaSprite_a_42bd::
    INCBIN "gfx/unknown/metasprite_a/42bd.sprite.bin"
MetaSprite_a_42bd_END::
MetaSprite_a_42dc::
    INCBIN "gfx/unknown/metasprite_a/42dc.sprite.bin"
MetaSprite_a_42dc_END::
MetaSprite_a_42e7::
    INCBIN "gfx/unknown/metasprite_a/42e7.sprite.bin"
MetaSprite_a_42e7_END::
MetaSprite_a_42f2::
    INCBIN "gfx/unknown/metasprite_a/42f2.sprite.bin"
MetaSprite_a_42f2_END::
MetaSprite_a_42fd::
    INCBIN "gfx/unknown/metasprite_a/42fd.sprite.bin"
MetaSprite_a_42fd_END::
MetaSprite_a_4308::
    INCBIN "gfx/unknown/metasprite_a/4308.sprite.bin"
MetaSprite_a_4308_END::
MetaSprite_a_430e::
    INCBIN "gfx/unknown/metasprite_a/430e.sprite.bin"
MetaSprite_a_430e_END::
MetaSprite_a_4314::
    INCBIN "gfx/unknown/metasprite_a/4314.sprite.bin"
MetaSprite_a_4314_END::
MetaSprite_a_431f::
    INCBIN "gfx/unknown/metasprite_a/431f.sprite.bin"
MetaSprite_a_431f_END::
MetaSprite_a_432a::
    INCBIN "gfx/unknown/metasprite_a/432a.sprite.bin"
MetaSprite_a_432a_END::
MetaSprite_a_4330::
    INCBIN "gfx/unknown/metasprite_a/4330.sprite.bin"
MetaSprite_a_4330_END::
MetaSprite_a_4336::
    INCBIN "gfx/unknown/metasprite_a/4336.sprite.bin"
MetaSprite_a_4336_END::
MetaSprite_a_435f::
    INCBIN "gfx/unknown/metasprite_a/435f.sprite.bin"
MetaSprite_a_435f_END::
MetaSprite_fungus_overhang::
    INCBIN "versions/speed/gfx/title/fungus_overhang.sprite.bin"
MetaSprite_fungus_overhang_END::
MetaSprite_gymnos_overhang::
    INCBIN "versions/speed/gfx/title/gymnos_overhang.sprite.bin"
MetaSprite_gymnos_overhang_END::
MetaSprite_a_43bc::
    INCBIN "gfx/unknown/metasprite_a/43bc.sprite.bin"
MetaSprite_a_43bc_END::
MetaSprite_a_43c7::
    INCBIN "gfx/unknown/metasprite_a/43c7.sprite.bin"
MetaSprite_a_43c7_END::
MetaSprite_a_43d2::
    INCBIN "gfx/unknown/metasprite_a/43d2.sprite.bin"
MetaSprite_a_43d2_END::
MetaSprite_a_43dd::
    INCBIN "gfx/unknown/metasprite_a/43dd.sprite.bin"
MetaSprite_a_43dd_END::
MetaSprite_a_43e8::
    INCBIN "gfx/unknown/metasprite_a/43e8.sprite.bin"
MetaSprite_a_43e8_END::
MetaSprite_a_43f3::
    INCBIN "gfx/unknown/metasprite_a/43f3.sprite.bin"
MetaSprite_a_43f3_END::
MetaSprite_a_43fe::
    INCBIN "gfx/unknown/metasprite_a/43fe.sprite.bin"
MetaSprite_a_43fe_END::
MetaSprite_a_4409::
    INCBIN "gfx/unknown/metasprite_a/4409.sprite.bin"
MetaSprite_a_4409_END::
MetaSprite_a_4414::
    INCBIN "gfx/unknown/metasprite_a/4414.sprite.bin"
MetaSprite_a_4414_END::
MetaSprite_a_441f::
    INCBIN "gfx/unknown/metasprite_a/441f.sprite.bin"
MetaSprite_a_441f_END::
MetaSprite_a_442a::
    INCBIN "gfx/unknown/metasprite_a/442a.sprite.bin"
MetaSprite_a_442a_END::
MetaSprite_a_4435::
    INCBIN "gfx/unknown/metasprite_a/4435.sprite.bin"
MetaSprite_a_4435_END::
MetaSprite_a_4440::
    INCBIN "gfx/unknown/metasprite_a/4440.sprite.bin"
MetaSprite_a_4440_END::
MetaSprite_a_444b::
    INCBIN "gfx/unknown/metasprite_a/444b.sprite.bin"
MetaSprite_a_444b_END::
MetaSprite_a_4456::
    INCBIN "gfx/unknown/metasprite_a/4456.sprite.bin"
MetaSprite_a_4456_END::
MetaSprite_a_4461::
    INCBIN "gfx/unknown/metasprite_a/4461.sprite.bin"
MetaSprite_a_4461_END::
MetaSprite_a_4471::
    INCBIN "gfx/unknown/metasprite_a/4471.sprite.bin"
MetaSprite_a_4471_END::
MetaSprite_a_4486::
    INCBIN "gfx/unknown/metasprite_a/4486.sprite.bin"
MetaSprite_a_4486_END::
MetaSprite_a_44a5::
    INCBIN "gfx/unknown/metasprite_a/44a5.sprite.bin"
MetaSprite_a_44a5_END::
MetaSprite_a_44c4::
    INCBIN "gfx/unknown/metasprite_a/44c4.sprite.bin"
MetaSprite_a_44c4_END::
MetaSprite_a_44d9::
    INCBIN "gfx/unknown/metasprite_a/44d9.sprite.bin"
MetaSprite_a_44d9_END::
MetaSprite_a_44ee::
    INCBIN "gfx/unknown/metasprite_a/44ee.sprite.bin"
MetaSprite_a_44ee_END::
MetaSprite_a_4503::
    INCBIN "gfx/unknown/metasprite_a/4503.sprite.bin"
MetaSprite_a_4503_END::
MetaSprite_a_4509::
    INCBIN "gfx/unknown/metasprite_a/4509.sprite.bin"
MetaSprite_a_4509_END::
MetaSprite_a_450f::
    INCBIN "gfx/unknown/metasprite_a/450f.sprite.bin"
MetaSprite_a_450f_END::
MetaSprite_a_45a6::
    INCBIN "gfx/unknown/metasprite_a/45a6.sprite.bin"
MetaSprite_a_45a6_END::
MetaSprite_a_4651::
    INCBIN "gfx/unknown/metasprite_a/4651.sprite.bin"
MetaSprite_a_4651_END::
MetaSprite_a_4666::
    INCBIN "gfx/unknown/metasprite_a/4666.sprite.bin"
MetaSprite_a_4666_END::
MetaSprite_a_468f::
    INCBIN "versions/speed/gfx/unknown/metasprite_a/468f.sprite.bin"
MetaSprite_a_468f_END::
MetaSprite_a_4758::
    INCBIN "versions/speed/gfx/unknown/metasprite_a/4758.sprite.bin"
MetaSprite_a_4758_END::
MetaSprite_a_4821::
    INCBIN "gfx/unknown/metasprite_a/4821.sprite.bin"
MetaSprite_a_4821_END::
MetaSprite_a_4859::
    INCBIN "gfx/unknown/metasprite_a/4859.sprite.bin"
MetaSprite_a_4859_END::
MetaSprite_a_4891::
MetaSprite_a_4891_END::

SECTION "MetaSprite_e", ROMX[$4120], BANK[$e]
MetaSprite_e::
    dw MetaSprite_e_4300
    dw MetaSprite_e_4315
    dw MetaSprite_e_432a
    dw MetaSprite_e_433f
    dw MetaSprite_e_4354
    dw MetaSprite_e_4369
    dw MetaSprite_e_437e
    dw MetaSprite_e_4393
    dw MetaSprite_e_43a8
    dw MetaSprite_e_43bd
    dw MetaSprite_e_43d2
    dw MetaSprite_e_43e7
    dw MetaSprite_e_43fc
    dw MetaSprite_e_4411
    dw MetaSprite_e_4426
    dw MetaSprite_e_443b
    dw MetaSprite_e_4450
    dw MetaSprite_e_4465
    dw MetaSprite_e_447a
    dw MetaSprite_e_448f
    dw MetaSprite_e_44a4
    dw MetaSprite_e_44a4
    dw MetaSprite_e_44a4
    dw MetaSprite_e_44aa
    dw MetaSprite_e_44bf
    dw MetaSprite_e_44d4
    dw MetaSprite_e_44e9
    dw MetaSprite_e_44fe
    dw MetaSprite_e_4513
    dw MetaSprite_e_4528
    dw MetaSprite_e_453d
    dw MetaSprite_e_4552
    dw MetaSprite_e_4567
    dw MetaSprite_e_457c
    dw MetaSprite_e_457c
    dw MetaSprite_e_457c
    dw MetaSprite_e_4582
    dw MetaSprite_e_4588
    dw MetaSprite_e_458e
    dw MetaSprite_e_45a3
    dw MetaSprite_e_45a9
    dw MetaSprite_e_45af
    dw MetaSprite_e_45b5
    dw MetaSprite_e_45bb
    dw MetaSprite_e_45c1
    dw MetaSprite_e_45c7
    dw MetaSprite_e_45cd
    dw MetaSprite_e_45d3
    dw MetaSprite_e_45e8
    dw MetaSprite_e_45f3
    dw MetaSprite_e_45fe
    dw MetaSprite_e_4613
    dw MetaSprite_e_461e
    dw MetaSprite_e_4629
    dw MetaSprite_e_462f
    dw MetaSprite_e_4635
    dw MetaSprite_e_463b
    dw MetaSprite_e_4669
    dw MetaSprite_e_4697
    dw MetaSprite_e_46c5
    dw MetaSprite_e_46f3
    dw MetaSprite_e_4721
    dw MetaSprite_e_474f
    dw MetaSprite_e_477d
    dw MetaSprite_e_47ab
    dw MetaSprite_e_47c0
    dw MetaSprite_e_47c6
    dw MetaSprite_e_47d1
    dw MetaSprite_e_47dc
    dw MetaSprite_e_4873
    dw MetaSprite_e_4879
    dw MetaSprite_e_487f
    dw MetaSprite_e_487f
    dw MetaSprite_e_487f
    dw MetaSprite_e_487f
    dw MetaSprite_e_487f
    dw MetaSprite_e_487f
    dw MetaSprite_e_4894
    dw MetaSprite_e_48a9
    dw MetaSprite_e_48be
    dw MetaSprite_e_48d3
    dw MetaSprite_e_48e8
    dw MetaSprite_e_48fd
    dw MetaSprite_e_4912
    dw MetaSprite_e_4927
    dw MetaSprite_e_493c
    dw MetaSprite_e_4951
    dw MetaSprite_e_4966
    dw MetaSprite_e_497b
    dw MetaSprite_e_4990
    dw MetaSprite_e_49a5
    dw MetaSprite_e_49ba
    dw MetaSprite_e_49cf
    dw MetaSprite_e_49cf
    dw MetaSprite_e_49cf
    dw MetaSprite_e_49cf
    dw MetaSprite_e_49cf
    dw MetaSprite_e_49e4
    dw MetaSprite_e_49f9
    dw MetaSprite_e_4a0e
    dw MetaSprite_e_4a23
    dw MetaSprite_e_4a38
    dw MetaSprite_e_4a4d
    dw MetaSprite_e_4a62
    dw MetaSprite_e_4a77
    dw MetaSprite_e_4a8c
    dw MetaSprite_e_4aa1
    dw MetaSprite_e_4ab6
    dw MetaSprite_e_4acb
    dw MetaSprite_e_4acb
    dw MetaSprite_e_4acb
    dw MetaSprite_e_4acb
    dw MetaSprite_e_4ae0
    dw MetaSprite_e_4aeb
    dw MetaSprite_e_4af1
    dw MetaSprite_e_4af7
    dw MetaSprite_e_4afd
    dw MetaSprite_e_4b12
    dw MetaSprite_e_4b27
    dw MetaSprite_e_4b3c
    dw MetaSprite_e_4b51
    dw MetaSprite_e_4b5c
    dw MetaSprite_e_4b71
    dw MetaSprite_e_4b86
    dw MetaSprite_e_4b9b
    dw MetaSprite_e_4b9b
    dw MetaSprite_e_4b9b
    dw MetaSprite_e_4b9b
    dw MetaSprite_e_4b9b
    dw MetaSprite_e_4ba1
    dw MetaSprite_e_4ba7
    dw MetaSprite_e_4bad
    dw MetaSprite_e_4bb3
    dw MetaSprite_e_4bb9
    dw MetaSprite_e_4bbf
    dw MetaSprite_e_4bc5
    dw MetaSprite_e_4bcb
    dw MetaSprite_e_4bd1
    dw MetaSprite_e_4bd7
    dw MetaSprite_e_4bdd
    dw MetaSprite_e_4be3
    dw MetaSprite_e_4be9
    dw MetaSprite_e_4bef
    dw MetaSprite_e_4bef
    dw MetaSprite_e_4bef
    dw MetaSprite_e_4c04
    dw MetaSprite_e_4c19
    dw MetaSprite_e_4c2e
    dw MetaSprite_e_4c43
    dw MetaSprite_e_4c4e
    dw MetaSprite_e_4c59
    dw MetaSprite_e_4c64
    dw MetaSprite_e_4c79
    dw MetaSprite_e_4c8e
    dw MetaSprite_e_4ca3
    dw MetaSprite_e_4cb8
    dw MetaSprite_e_4cc3
    dw MetaSprite_e_4cce
    dw MetaSprite_e_4cd9
    dw MetaSprite_e_4cd9
    dw MetaSprite_e_4cd9
    dw MetaSprite_e_4cdf
    dw MetaSprite_e_4ce5
    dw MetaSprite_e_4ceb
    dw MetaSprite_e_4cf1
    dw MetaSprite_e_4cf7
    dw MetaSprite_e_4cfd
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d03
    dw MetaSprite_e_4d09
    dw MetaSprite_e_4d0f
    dw MetaSprite_e_4d15
    dw MetaSprite_e_4d1b
    dw MetaSprite_e_4d21
    dw MetaSprite_e_4d27
    dw MetaSprite_e_4d2d
    dw MetaSprite_e_4d33
    dw MetaSprite_e_4d39
    dw MetaSprite_e_4d3f
    dw MetaSprite_e_4d45
    dw MetaSprite_e_4d4b
    dw MetaSprite_e_4d51
    dw MetaSprite_e_4d57
    dw MetaSprite_e_4d5d
    dw MetaSprite_e_4d63
    dw MetaSprite_e_4d69
    dw MetaSprite_e_4d6f
    dw MetaSprite_e_4d75
    dw MetaSprite_e_4d7b
    dw MetaSprite_e_4d81
    dw MetaSprite_e_4d87
    dw MetaSprite_e_4d8d
    dw MetaSprite_e_4d93
    dw MetaSprite_e_4d99
    dw MetaSprite_e_4d9f
    dw MetaSprite_e_4da5
    dw MetaSprite_e_4dab
    dw MetaSprite_e_4db1
    dw MetaSprite_e_4db7
    dw MetaSprite_e_4dbd
    dw MetaSprite_e_4dc3
    dw MetaSprite_e_4dc3
    dw MetaSprite_e_4dc3
    dw MetaSprite_e_4dc3
    dw MetaSprite_e_4dd8
    dw MetaSprite_e_4e15
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e52
    dw MetaSprite_e_4e67
    dw MetaSprite_e_4e7c
    dw MetaSprite_e_4e91
    dw MetaSprite_e_4ea6
    dw MetaSprite_e_4ebb
    dw MetaSprite_e_4ed0
    dw MetaSprite_e_4ee5
    dw MetaSprite_e_4efa
    dw MetaSprite_e_4f0f
    dw MetaSprite_e_4f24
    dw MetaSprite_e_4f39
    dw MetaSprite_e_4f4e
    dw MetaSprite_e_4f63
    dw MetaSprite_e_4f78
    dw MetaSprite_e_4f8d

SECTION "MetaSprite_e_4300", ROMX[$4300], BANK[$e]
MetaSprite_e_4300::
    INCBIN "gfx/unknown/metasprite_e/4300.sprite.bin"
MetaSprite_e_4300_END::
MetaSprite_e_4315::
    INCBIN "gfx/unknown/metasprite_e/4315.sprite.bin"
MetaSprite_e_4315_END::
MetaSprite_e_432a::
    INCBIN "gfx/unknown/metasprite_e/432a.sprite.bin"
MetaSprite_e_432a_END::
MetaSprite_e_433f::
    INCBIN "gfx/unknown/metasprite_e/433f.sprite.bin"
MetaSprite_e_433f_END::
MetaSprite_e_4354::
    INCBIN "gfx/unknown/metasprite_e/4354.sprite.bin"
MetaSprite_e_4354_END::
MetaSprite_e_4369::
    INCBIN "gfx/unknown/metasprite_e/4369.sprite.bin"
MetaSprite_e_4369_END::
MetaSprite_e_437e::
    INCBIN "gfx/unknown/metasprite_e/437e.sprite.bin"
MetaSprite_e_437e_END::
MetaSprite_e_4393::
    INCBIN "gfx/unknown/metasprite_e/4393.sprite.bin"
MetaSprite_e_4393_END::
MetaSprite_e_43a8::
    INCBIN "gfx/unknown/metasprite_e/43a8.sprite.bin"
MetaSprite_e_43a8_END::
MetaSprite_e_43bd::
    INCBIN "gfx/unknown/metasprite_e/43bd.sprite.bin"
MetaSprite_e_43bd_END::
MetaSprite_e_43d2::
    INCBIN "gfx/unknown/metasprite_e/43d2.sprite.bin"
MetaSprite_e_43d2_END::
MetaSprite_e_43e7::
    INCBIN "gfx/unknown/metasprite_e/43e7.sprite.bin"
MetaSprite_e_43e7_END::
MetaSprite_e_43fc::
    INCBIN "gfx/unknown/metasprite_e/43fc.sprite.bin"
MetaSprite_e_43fc_END::
MetaSprite_e_4411::
    INCBIN "gfx/unknown/metasprite_e/4411.sprite.bin"
MetaSprite_e_4411_END::
MetaSprite_e_4426::
    INCBIN "gfx/unknown/metasprite_e/4426.sprite.bin"
MetaSprite_e_4426_END::
MetaSprite_e_443b::
    INCBIN "gfx/unknown/metasprite_e/443b.sprite.bin"
MetaSprite_e_443b_END::
MetaSprite_e_4450::
    INCBIN "gfx/unknown/metasprite_e/4450.sprite.bin"
MetaSprite_e_4450_END::
MetaSprite_e_4465::
    INCBIN "gfx/unknown/metasprite_e/4465.sprite.bin"
MetaSprite_e_4465_END::
MetaSprite_e_447a::
    INCBIN "gfx/unknown/metasprite_e/447a.sprite.bin"
MetaSprite_e_447a_END::
MetaSprite_e_448f::
    INCBIN "gfx/unknown/metasprite_e/448f.sprite.bin"
MetaSprite_e_448f_END::
MetaSprite_e_44a4::
    INCBIN "gfx/unknown/metasprite_e/44a4.sprite.bin"
MetaSprite_e_44a4_END::
MetaSprite_e_44aa::
    INCBIN "gfx/unknown/metasprite_e/44aa.sprite.bin"
MetaSprite_e_44aa_END::
MetaSprite_e_44bf::
    INCBIN "gfx/unknown/metasprite_e/44bf.sprite.bin"
MetaSprite_e_44bf_END::
MetaSprite_e_44d4::
    INCBIN "gfx/unknown/metasprite_e/44d4.sprite.bin"
MetaSprite_e_44d4_END::
MetaSprite_e_44e9::
    INCBIN "gfx/unknown/metasprite_e/44e9.sprite.bin"
MetaSprite_e_44e9_END::
MetaSprite_e_44fe::
    INCBIN "gfx/unknown/metasprite_e/44fe.sprite.bin"
MetaSprite_e_44fe_END::
MetaSprite_e_4513::
    INCBIN "gfx/unknown/metasprite_e/4513.sprite.bin"
MetaSprite_e_4513_END::
MetaSprite_e_4528::
    INCBIN "gfx/unknown/metasprite_e/4528.sprite.bin"
MetaSprite_e_4528_END::
MetaSprite_e_453d::
    INCBIN "gfx/unknown/metasprite_e/453d.sprite.bin"
MetaSprite_e_453d_END::
MetaSprite_e_4552::
    INCBIN "gfx/unknown/metasprite_e/4552.sprite.bin"
MetaSprite_e_4552_END::
MetaSprite_e_4567::
    INCBIN "gfx/unknown/metasprite_e/4567.sprite.bin"
MetaSprite_e_4567_END::
MetaSprite_e_457c::
    INCBIN "gfx/unknown/metasprite_e/457c.sprite.bin"
MetaSprite_e_457c_END::
MetaSprite_e_4582::
    INCBIN "gfx/unknown/metasprite_e/4582.sprite.bin"
MetaSprite_e_4582_END::
MetaSprite_e_4588::
    INCBIN "gfx/unknown/metasprite_e/4588.sprite.bin"
MetaSprite_e_4588_END::
MetaSprite_e_458e::
    INCBIN "gfx/unknown/metasprite_e/458e.sprite.bin"
MetaSprite_e_458e_END::
MetaSprite_e_45a3::
    INCBIN "gfx/unknown/metasprite_e/45a3.sprite.bin"
MetaSprite_e_45a3_END::
MetaSprite_e_45a9::
    INCBIN "gfx/unknown/metasprite_e/45a9.sprite.bin"
MetaSprite_e_45a9_END::
MetaSprite_e_45af::
    INCBIN "gfx/unknown/metasprite_e/45af.sprite.bin"
MetaSprite_e_45af_END::
MetaSprite_e_45b5::
    INCBIN "gfx/unknown/metasprite_e/45b5.sprite.bin"
MetaSprite_e_45b5_END::
MetaSprite_e_45bb::
    INCBIN "gfx/unknown/metasprite_e/45bb.sprite.bin"
MetaSprite_e_45bb_END::
MetaSprite_e_45c1::
    INCBIN "gfx/unknown/metasprite_e/45c1.sprite.bin"
MetaSprite_e_45c1_END::
MetaSprite_e_45c7::
    INCBIN "gfx/unknown/metasprite_e/45c7.sprite.bin"
MetaSprite_e_45c7_END::
MetaSprite_e_45cd::
    INCBIN "gfx/unknown/metasprite_e/45cd.sprite.bin"
MetaSprite_e_45cd_END::
MetaSprite_e_45d3::
    INCBIN "gfx/unknown/metasprite_e/45d3.sprite.bin"
MetaSprite_e_45d3_END::
MetaSprite_e_45e8::
    INCBIN "gfx/unknown/metasprite_e/45e8.sprite.bin"
MetaSprite_e_45e8_END::
MetaSprite_e_45f3::
    INCBIN "gfx/unknown/metasprite_e/45f3.sprite.bin"
MetaSprite_e_45f3_END::
MetaSprite_e_45fe::
    INCBIN "gfx/unknown/metasprite_e/45fe.sprite.bin"
MetaSprite_e_45fe_END::
MetaSprite_e_4613::
    INCBIN "gfx/unknown/metasprite_e/4613.sprite.bin"
MetaSprite_e_4613_END::
MetaSprite_e_461e::
    INCBIN "gfx/unknown/metasprite_e/461e.sprite.bin"
MetaSprite_e_461e_END::
MetaSprite_e_4629::
    INCBIN "gfx/unknown/metasprite_e/4629.sprite.bin"
MetaSprite_e_4629_END::
MetaSprite_e_462f::
    INCBIN "gfx/unknown/metasprite_e/462f.sprite.bin"
MetaSprite_e_462f_END::
MetaSprite_e_4635::
    INCBIN "gfx/unknown/metasprite_e/4635.sprite.bin"
MetaSprite_e_4635_END::
MetaSprite_e_463b::
    INCBIN "gfx/unknown/metasprite_e/463b.sprite.bin"
MetaSprite_e_463b_END::
MetaSprite_e_4669::
    INCBIN "gfx/unknown/metasprite_e/4669.sprite.bin"
MetaSprite_e_4669_END::
MetaSprite_e_4697::
    INCBIN "gfx/unknown/metasprite_e/4697.sprite.bin"
MetaSprite_e_4697_END::
MetaSprite_e_46c5::
    INCBIN "gfx/unknown/metasprite_e/46c5.sprite.bin"
MetaSprite_e_46c5_END::
MetaSprite_e_46f3::
    INCBIN "gfx/unknown/metasprite_e/46f3.sprite.bin"
MetaSprite_e_46f3_END::
MetaSprite_e_4721::
    INCBIN "gfx/unknown/metasprite_e/4721.sprite.bin"
MetaSprite_e_4721_END::
MetaSprite_e_474f::
    INCBIN "gfx/unknown/metasprite_e/474f.sprite.bin"
MetaSprite_e_474f_END::
MetaSprite_e_477d::
    INCBIN "gfx/unknown/metasprite_e/477d.sprite.bin"
MetaSprite_e_477d_END::
MetaSprite_e_47ab::
    INCBIN "gfx/unknown/metasprite_e/47ab.sprite.bin"
MetaSprite_e_47ab_END::
MetaSprite_e_47c0::
    INCBIN "gfx/unknown/metasprite_e/47c0.sprite.bin"
MetaSprite_e_47c0_END::
MetaSprite_e_47c6::
    INCBIN "gfx/unknown/metasprite_e/47c6.sprite.bin"
MetaSprite_e_47c6_END::
MetaSprite_e_47d1::
    INCBIN "gfx/unknown/metasprite_e/47d1.sprite.bin"
MetaSprite_e_47d1_END::
MetaSprite_e_47dc::
    INCBIN "gfx/unknown/metasprite_e/47dc.sprite.bin"
MetaSprite_e_47dc_END::
MetaSprite_e_4873::
    INCBIN "gfx/unknown/metasprite_e/4873.sprite.bin"
MetaSprite_e_4873_END::
MetaSprite_e_4879::
    INCBIN "gfx/unknown/metasprite_e/4879.sprite.bin"
MetaSprite_e_4879_END::
MetaSprite_e_487f::
    INCBIN "gfx/unknown/metasprite_e/487f.sprite.bin"
MetaSprite_e_487f_END::
MetaSprite_e_4894::
    INCBIN "gfx/unknown/metasprite_e/4894.sprite.bin"
MetaSprite_e_4894_END::
MetaSprite_e_48a9::
    INCBIN "gfx/unknown/metasprite_e/48a9.sprite.bin"
MetaSprite_e_48a9_END::
MetaSprite_e_48be::
    INCBIN "gfx/unknown/metasprite_e/48be.sprite.bin"
MetaSprite_e_48be_END::
MetaSprite_e_48d3::
    INCBIN "gfx/unknown/metasprite_e/48d3.sprite.bin"
MetaSprite_e_48d3_END::
MetaSprite_e_48e8::
    INCBIN "gfx/unknown/metasprite_e/48e8.sprite.bin"
MetaSprite_e_48e8_END::
MetaSprite_e_48fd::
    INCBIN "gfx/unknown/metasprite_e/48fd.sprite.bin"
MetaSprite_e_48fd_END::
MetaSprite_e_4912::
    INCBIN "gfx/unknown/metasprite_e/4912.sprite.bin"
MetaSprite_e_4912_END::
MetaSprite_e_4927::
    INCBIN "gfx/unknown/metasprite_e/4927.sprite.bin"
MetaSprite_e_4927_END::
MetaSprite_e_493c::
    INCBIN "gfx/unknown/metasprite_e/493c.sprite.bin"
MetaSprite_e_493c_END::
MetaSprite_e_4951::
    INCBIN "gfx/unknown/metasprite_e/4951.sprite.bin"
MetaSprite_e_4951_END::
MetaSprite_e_4966::
    INCBIN "gfx/unknown/metasprite_e/4966.sprite.bin"
MetaSprite_e_4966_END::
MetaSprite_e_497b::
    INCBIN "gfx/unknown/metasprite_e/497b.sprite.bin"
MetaSprite_e_497b_END::
MetaSprite_e_4990::
    INCBIN "gfx/unknown/metasprite_e/4990.sprite.bin"
MetaSprite_e_4990_END::
MetaSprite_e_49a5::
    INCBIN "gfx/unknown/metasprite_e/49a5.sprite.bin"
MetaSprite_e_49a5_END::
MetaSprite_e_49ba::
    INCBIN "gfx/unknown/metasprite_e/49ba.sprite.bin"
MetaSprite_e_49ba_END::
MetaSprite_e_49cf::
    INCBIN "gfx/unknown/metasprite_e/49cf.sprite.bin"
MetaSprite_e_49cf_END::
MetaSprite_e_49e4::
    INCBIN "gfx/unknown/metasprite_e/49e4.sprite.bin"
MetaSprite_e_49e4_END::
MetaSprite_e_49f9::
    INCBIN "gfx/unknown/metasprite_e/49f9.sprite.bin"
MetaSprite_e_49f9_END::
MetaSprite_e_4a0e::
    INCBIN "gfx/unknown/metasprite_e/4a0e.sprite.bin"
MetaSprite_e_4a0e_END::
MetaSprite_e_4a23::
    INCBIN "gfx/unknown/metasprite_e/4a23.sprite.bin"
MetaSprite_e_4a23_END::
MetaSprite_e_4a38::
    INCBIN "gfx/unknown/metasprite_e/4a38.sprite.bin"
MetaSprite_e_4a38_END::
MetaSprite_e_4a4d::
    INCBIN "gfx/unknown/metasprite_e/4a4d.sprite.bin"
MetaSprite_e_4a4d_END::
MetaSprite_e_4a62::
    INCBIN "gfx/unknown/metasprite_e/4a62.sprite.bin"
MetaSprite_e_4a62_END::
MetaSprite_e_4a77::
    INCBIN "gfx/unknown/metasprite_e/4a77.sprite.bin"
MetaSprite_e_4a77_END::
MetaSprite_e_4a8c::
    INCBIN "gfx/unknown/metasprite_e/4a8c.sprite.bin"
MetaSprite_e_4a8c_END::
MetaSprite_e_4aa1::
    INCBIN "gfx/unknown/metasprite_e/4aa1.sprite.bin"
MetaSprite_e_4aa1_END::
MetaSprite_e_4ab6::
    INCBIN "gfx/unknown/metasprite_e/4ab6.sprite.bin"
MetaSprite_e_4ab6_END::
MetaSprite_e_4acb::
    INCBIN "gfx/unknown/metasprite_e/4acb.sprite.bin"
MetaSprite_e_4acb_END::
MetaSprite_e_4ae0::
    INCBIN "gfx/unknown/metasprite_e/4ae0.sprite.bin"
MetaSprite_e_4ae0_END::
MetaSprite_e_4aeb::
    INCBIN "gfx/unknown/metasprite_e/4aeb.sprite.bin"
MetaSprite_e_4aeb_END::
MetaSprite_e_4af1::
    INCBIN "gfx/unknown/metasprite_e/4af1.sprite.bin"
MetaSprite_e_4af1_END::
MetaSprite_e_4af7::
    INCBIN "gfx/unknown/metasprite_e/4af7.sprite.bin"
MetaSprite_e_4af7_END::
MetaSprite_e_4afd::
    INCBIN "gfx/unknown/metasprite_e/4afd.sprite.bin"
MetaSprite_e_4afd_END::
MetaSprite_e_4b12::
    INCBIN "gfx/unknown/metasprite_e/4b12.sprite.bin"
MetaSprite_e_4b12_END::
MetaSprite_e_4b27::
    INCBIN "gfx/unknown/metasprite_e/4b27.sprite.bin"
MetaSprite_e_4b27_END::
MetaSprite_e_4b3c::
    INCBIN "gfx/unknown/metasprite_e/4b3c.sprite.bin"
MetaSprite_e_4b3c_END::
MetaSprite_e_4b51::
    INCBIN "gfx/unknown/metasprite_e/4b51.sprite.bin"
MetaSprite_e_4b51_END::
MetaSprite_e_4b5c::
    INCBIN "gfx/unknown/metasprite_e/4b5c.sprite.bin"
MetaSprite_e_4b5c_END::
MetaSprite_e_4b71::
    INCBIN "gfx/unknown/metasprite_e/4b71.sprite.bin"
MetaSprite_e_4b71_END::
MetaSprite_e_4b86::
    INCBIN "gfx/unknown/metasprite_e/4b86.sprite.bin"
MetaSprite_e_4b86_END::
MetaSprite_e_4b9b::
    INCBIN "gfx/unknown/metasprite_e/4b9b.sprite.bin"
MetaSprite_e_4b9b_END::
MetaSprite_e_4ba1::
    INCBIN "gfx/unknown/metasprite_e/4ba1.sprite.bin"
MetaSprite_e_4ba1_END::
MetaSprite_e_4ba7::
    INCBIN "gfx/unknown/metasprite_e/4ba7.sprite.bin"
MetaSprite_e_4ba7_END::
MetaSprite_e_4bad::
    INCBIN "gfx/unknown/metasprite_e/4bad.sprite.bin"
MetaSprite_e_4bad_END::
MetaSprite_e_4bb3::
    INCBIN "gfx/unknown/metasprite_e/4bb3.sprite.bin"
MetaSprite_e_4bb3_END::
MetaSprite_e_4bb9::
    INCBIN "gfx/unknown/metasprite_e/4bb9.sprite.bin"
MetaSprite_e_4bb9_END::
MetaSprite_e_4bbf::
    INCBIN "gfx/unknown/metasprite_e/4bbf.sprite.bin"
MetaSprite_e_4bbf_END::
MetaSprite_e_4bc5::
    INCBIN "gfx/unknown/metasprite_e/4bc5.sprite.bin"
MetaSprite_e_4bc5_END::
MetaSprite_e_4bcb::
    INCBIN "gfx/unknown/metasprite_e/4bcb.sprite.bin"
MetaSprite_e_4bcb_END::
MetaSprite_e_4bd1::
    INCBIN "gfx/unknown/metasprite_e/4bd1.sprite.bin"
MetaSprite_e_4bd1_END::
MetaSprite_e_4bd7::
    INCBIN "gfx/unknown/metasprite_e/4bd7.sprite.bin"
MetaSprite_e_4bd7_END::
MetaSprite_e_4bdd::
    INCBIN "gfx/unknown/metasprite_e/4bdd.sprite.bin"
MetaSprite_e_4bdd_END::
MetaSprite_e_4be3::
    INCBIN "gfx/unknown/metasprite_e/4be3.sprite.bin"
MetaSprite_e_4be3_END::
MetaSprite_e_4be9::
    INCBIN "gfx/unknown/metasprite_e/4be9.sprite.bin"
MetaSprite_e_4be9_END::
MetaSprite_e_4bef::
    INCBIN "gfx/unknown/metasprite_e/4bef.sprite.bin"
MetaSprite_e_4bef_END::
MetaSprite_e_4c04::
    INCBIN "gfx/unknown/metasprite_e/4c04.sprite.bin"
MetaSprite_e_4c04_END::
MetaSprite_e_4c19::
    INCBIN "gfx/unknown/metasprite_e/4c19.sprite.bin"
MetaSprite_e_4c19_END::
MetaSprite_e_4c2e::
    INCBIN "gfx/unknown/metasprite_e/4c2e.sprite.bin"
MetaSprite_e_4c2e_END::
MetaSprite_e_4c43::
    INCBIN "gfx/unknown/metasprite_e/4c43.sprite.bin"
MetaSprite_e_4c43_END::
MetaSprite_e_4c4e::
    INCBIN "gfx/unknown/metasprite_e/4c4e.sprite.bin"
MetaSprite_e_4c4e_END::
MetaSprite_e_4c59::
    INCBIN "gfx/unknown/metasprite_e/4c59.sprite.bin"
MetaSprite_e_4c59_END::
MetaSprite_e_4c64::
    INCBIN "gfx/unknown/metasprite_e/4c64.sprite.bin"
MetaSprite_e_4c64_END::
MetaSprite_e_4c79::
    INCBIN "gfx/unknown/metasprite_e/4c79.sprite.bin"
MetaSprite_e_4c79_END::
MetaSprite_e_4c8e::
    INCBIN "gfx/unknown/metasprite_e/4c8e.sprite.bin"
MetaSprite_e_4c8e_END::
MetaSprite_e_4ca3::
    INCBIN "gfx/unknown/metasprite_e/4ca3.sprite.bin"
MetaSprite_e_4ca3_END::
MetaSprite_e_4cb8::
    INCBIN "gfx/unknown/metasprite_e/4cb8.sprite.bin"
MetaSprite_e_4cb8_END::
MetaSprite_e_4cc3::
    INCBIN "gfx/unknown/metasprite_e/4cc3.sprite.bin"
MetaSprite_e_4cc3_END::
MetaSprite_e_4cce::
    INCBIN "gfx/unknown/metasprite_e/4cce.sprite.bin"
MetaSprite_e_4cce_END::
MetaSprite_e_4cd9::
    INCBIN "gfx/unknown/metasprite_e/4cd9.sprite.bin"
MetaSprite_e_4cd9_END::
MetaSprite_e_4cdf::
    INCBIN "gfx/unknown/metasprite_e/4cdf.sprite.bin"
MetaSprite_e_4cdf_END::
MetaSprite_e_4ce5::
    INCBIN "gfx/unknown/metasprite_e/4ce5.sprite.bin"
MetaSprite_e_4ce5_END::
MetaSprite_e_4ceb::
    INCBIN "gfx/unknown/metasprite_e/4ceb.sprite.bin"
MetaSprite_e_4ceb_END::
MetaSprite_e_4cf1::
    INCBIN "gfx/unknown/metasprite_e/4cf1.sprite.bin"
MetaSprite_e_4cf1_END::
MetaSprite_e_4cf7::
    INCBIN "gfx/unknown/metasprite_e/4cf7.sprite.bin"
MetaSprite_e_4cf7_END::
MetaSprite_e_4cfd::
    INCBIN "gfx/unknown/metasprite_e/4cfd.sprite.bin"
MetaSprite_e_4cfd_END::
MetaSprite_e_4d03::
    INCBIN "gfx/unknown/metasprite_e/4d03.sprite.bin"
MetaSprite_e_4d03_END::
MetaSprite_e_4d09::
    INCBIN "gfx/unknown/metasprite_e/4d09.sprite.bin"
MetaSprite_e_4d09_END::
MetaSprite_e_4d0f::
    INCBIN "gfx/unknown/metasprite_e/4d0f.sprite.bin"
MetaSprite_e_4d0f_END::
MetaSprite_e_4d15::
    INCBIN "gfx/unknown/metasprite_e/4d15.sprite.bin"
MetaSprite_e_4d15_END::
MetaSprite_e_4d1b::
    INCBIN "gfx/unknown/metasprite_e/4d1b.sprite.bin"
MetaSprite_e_4d1b_END::
MetaSprite_e_4d21::
    INCBIN "gfx/unknown/metasprite_e/4d21.sprite.bin"
MetaSprite_e_4d21_END::
MetaSprite_e_4d27::
    INCBIN "gfx/unknown/metasprite_e/4d27.sprite.bin"
MetaSprite_e_4d27_END::
MetaSprite_e_4d2d::
    INCBIN "gfx/unknown/metasprite_e/4d2d.sprite.bin"
MetaSprite_e_4d2d_END::
MetaSprite_e_4d33::
    INCBIN "gfx/unknown/metasprite_e/4d33.sprite.bin"
MetaSprite_e_4d33_END::
MetaSprite_e_4d39::
    INCBIN "gfx/unknown/metasprite_e/4d39.sprite.bin"
MetaSprite_e_4d39_END::
MetaSprite_e_4d3f::
    INCBIN "gfx/unknown/metasprite_e/4d3f.sprite.bin"
MetaSprite_e_4d3f_END::
MetaSprite_e_4d45::
    INCBIN "gfx/unknown/metasprite_e/4d45.sprite.bin"
MetaSprite_e_4d45_END::
MetaSprite_e_4d4b::
    INCBIN "gfx/unknown/metasprite_e/4d4b.sprite.bin"
MetaSprite_e_4d4b_END::
MetaSprite_e_4d51::
    INCBIN "gfx/unknown/metasprite_e/4d51.sprite.bin"
MetaSprite_e_4d51_END::
MetaSprite_e_4d57::
    INCBIN "gfx/unknown/metasprite_e/4d57.sprite.bin"
MetaSprite_e_4d57_END::
MetaSprite_e_4d5d::
    INCBIN "gfx/unknown/metasprite_e/4d5d.sprite.bin"
MetaSprite_e_4d5d_END::
MetaSprite_e_4d63::
    INCBIN "gfx/unknown/metasprite_e/4d63.sprite.bin"
MetaSprite_e_4d63_END::
MetaSprite_e_4d69::
    INCBIN "gfx/unknown/metasprite_e/4d69.sprite.bin"
MetaSprite_e_4d69_END::
MetaSprite_e_4d6f::
    INCBIN "gfx/unknown/metasprite_e/4d6f.sprite.bin"
MetaSprite_e_4d6f_END::
MetaSprite_e_4d75::
    INCBIN "gfx/unknown/metasprite_e/4d75.sprite.bin"
MetaSprite_e_4d75_END::
MetaSprite_e_4d7b::
    INCBIN "gfx/unknown/metasprite_e/4d7b.sprite.bin"
MetaSprite_e_4d7b_END::
MetaSprite_e_4d81::
    INCBIN "gfx/unknown/metasprite_e/4d81.sprite.bin"
MetaSprite_e_4d81_END::
MetaSprite_e_4d87::
    INCBIN "gfx/unknown/metasprite_e/4d87.sprite.bin"
MetaSprite_e_4d87_END::
MetaSprite_e_4d8d::
    INCBIN "gfx/unknown/metasprite_e/4d8d.sprite.bin"
MetaSprite_e_4d8d_END::
MetaSprite_e_4d93::
    INCBIN "gfx/unknown/metasprite_e/4d93.sprite.bin"
MetaSprite_e_4d93_END::
MetaSprite_e_4d99::
    INCBIN "gfx/unknown/metasprite_e/4d99.sprite.bin"
MetaSprite_e_4d99_END::
MetaSprite_e_4d9f::
    INCBIN "gfx/unknown/metasprite_e/4d9f.sprite.bin"
MetaSprite_e_4d9f_END::
MetaSprite_e_4da5::
    INCBIN "gfx/unknown/metasprite_e/4da5.sprite.bin"
MetaSprite_e_4da5_END::
MetaSprite_e_4dab::
    INCBIN "gfx/unknown/metasprite_e/4dab.sprite.bin"
MetaSprite_e_4dab_END::
MetaSprite_e_4db1::
    INCBIN "gfx/unknown/metasprite_e/4db1.sprite.bin"
MetaSprite_e_4db1_END::
MetaSprite_e_4db7::
    INCBIN "gfx/unknown/metasprite_e/4db7.sprite.bin"
MetaSprite_e_4db7_END::
MetaSprite_e_4dbd::
    INCBIN "gfx/unknown/metasprite_e/4dbd.sprite.bin"
MetaSprite_e_4dbd_END::
MetaSprite_e_4dc3::
    INCBIN "gfx/unknown/metasprite_e/4dc3.sprite.bin"
MetaSprite_e_4dc3_END::
MetaSprite_e_4dd8::
    INCBIN "gfx/unknown/metasprite_e/4dd8.sprite.bin"
MetaSprite_e_4dd8_END::
MetaSprite_e_4e15::
    INCBIN "gfx/unknown/metasprite_e/4e15.sprite.bin"
MetaSprite_e_4e15_END::
MetaSprite_e_4e52::
    INCBIN "gfx/unknown/metasprite_e/4e52.sprite.bin"
MetaSprite_e_4e52_END::
MetaSprite_e_4e67::
    INCBIN "gfx/unknown/metasprite_e/4e67.sprite.bin"
MetaSprite_e_4e67_END::
MetaSprite_e_4e7c::
    INCBIN "gfx/unknown/metasprite_e/4e7c.sprite.bin"
MetaSprite_e_4e7c_END::
MetaSprite_e_4e91::
    INCBIN "gfx/unknown/metasprite_e/4e91.sprite.bin"
MetaSprite_e_4e91_END::
MetaSprite_e_4ea6::
    INCBIN "gfx/unknown/metasprite_e/4ea6.sprite.bin"
MetaSprite_e_4ea6_END::
MetaSprite_e_4ebb::
    INCBIN "gfx/unknown/metasprite_e/4ebb.sprite.bin"
MetaSprite_e_4ebb_END::
MetaSprite_e_4ed0::
    INCBIN "gfx/unknown/metasprite_e/4ed0.sprite.bin"
MetaSprite_e_4ed0_END::
MetaSprite_e_4ee5::
    INCBIN "gfx/unknown/metasprite_e/4ee5.sprite.bin"
MetaSprite_e_4ee5_END::
MetaSprite_e_4efa::
    INCBIN "gfx/unknown/metasprite_e/4efa.sprite.bin"
MetaSprite_e_4efa_END::
MetaSprite_e_4f0f::
    INCBIN "gfx/unknown/metasprite_e/4f0f.sprite.bin"
MetaSprite_e_4f0f_END::
MetaSprite_e_4f24::
    INCBIN "gfx/unknown/metasprite_e/4f24.sprite.bin"
MetaSprite_e_4f24_END::
MetaSprite_e_4f39::
    INCBIN "gfx/unknown/metasprite_e/4f39.sprite.bin"
MetaSprite_e_4f39_END::
MetaSprite_e_4f4e::
    INCBIN "gfx/unknown/metasprite_e/4f4e.sprite.bin"
MetaSprite_e_4f4e_END::
MetaSprite_e_4f63::
    INCBIN "gfx/unknown/metasprite_e/4f63.sprite.bin"
MetaSprite_e_4f63_END::
MetaSprite_e_4f78::
    INCBIN "gfx/unknown/metasprite_e/4f78.sprite.bin"
MetaSprite_e_4f78_END::
MetaSprite_e_4f8d::
MetaSprite_e_4f8d_END::

SECTION "MetaSprite_13", ROMX[$4000], BANK[$13]
MetaSprite_13::
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4200
    dw MetaSprite_13_4215
    dw MetaSprite_13_422a
    dw MetaSprite_13_4230
    dw MetaSprite_13_4245
    dw MetaSprite_13_4245
    dw MetaSprite_13_4245
    dw MetaSprite_13_4245
    dw MetaSprite_13_4245
    dw MetaSprite_13_425a
    dw MetaSprite_13_4279
    dw MetaSprite_13_428e
    dw MetaSprite_13_42a3
    dw MetaSprite_13_42c2
    dw MetaSprite_13_42d7
    dw MetaSprite_13_42ec
    dw MetaSprite_13_4301
    dw MetaSprite_13_4316
    dw MetaSprite_13_432b
    dw MetaSprite_13_4340
    dw MetaSprite_13_4355
    dw MetaSprite_13_436a
    dw MetaSprite_13_437f
    dw MetaSprite_13_4394
    dw MetaSprite_13_43a9
    dw MetaSprite_13_43be
    dw MetaSprite_13_43c9
    dw MetaSprite_13_43d4
    dw MetaSprite_13_43df
    dw MetaSprite_13_43ea
    dw MetaSprite_13_43f5
    dw MetaSprite_13_4400
    dw MetaSprite_13_440b
    dw MetaSprite_13_4416
    dw MetaSprite_13_4421
    dw MetaSprite_13_442c
    dw MetaSprite_13_4437
    dw MetaSprite_13_4442
    dw MetaSprite_13_444d
    dw MetaSprite_13_4458
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_4463
    dw MetaSprite_13_44b4
    dw MetaSprite_13_4505
    dw MetaSprite_13_4556
    dw MetaSprite_13_4566
    dw MetaSprite_13_4585
    dw MetaSprite_13_45b3
    dw MetaSprite_13_45c8
    dw MetaSprite_13_45d8
    dw MetaSprite_13_45f7
    dw MetaSprite_13_4625
    dw MetaSprite_13_4635
    dw MetaSprite_13_4686
    dw MetaSprite_13_46b4
    dw MetaSprite_13_46c9
    dw MetaSprite_13_46de
    dw MetaSprite_13_4707
    dw MetaSprite_13_4730
    dw MetaSprite_13_4759
    dw MetaSprite_13_4782
    dw MetaSprite_13_4788
    dw MetaSprite_13_478e
    dw MetaSprite_13_47a3
    dw MetaSprite_13_47b8
    dw MetaSprite_13_47cd
    dw MetaSprite_13_47e2
    dw MetaSprite_13_47f7
    dw MetaSprite_13_480c
    dw MetaSprite_13_4812
    dw MetaSprite_13_4818
    dw MetaSprite_13_481e
    dw MetaSprite_13_4824
    dw MetaSprite_13_4839
    dw MetaSprite_13_488a
    dw MetaSprite_13_489f
    dw MetaSprite_13_48b4
    dw MetaSprite_13_48bf
    dw MetaSprite_13_48d4
    dw MetaSprite_13_48e9
    dw MetaSprite_13_48fe
    dw MetaSprite_13_492c
    dw MetaSprite_13_4941
    dw MetaSprite_13_4956
    dw MetaSprite_13_4961
    dw MetaSprite_13_496c
    dw MetaSprite_13_4972
    dw MetaSprite_13_4978
    dw MetaSprite_13_497e
    dw MetaSprite_13_4993
    dw MetaSprite_13_499e
    dw MetaSprite_13_49a9
    dw MetaSprite_13_49a9
    dw MetaSprite_13_49be
    dw MetaSprite_13_49d3
    dw MetaSprite_13_49e8
    dw MetaSprite_13_49fd
    dw MetaSprite_13_4a12
    dw MetaSprite_13_4a27
    dw MetaSprite_13_4a3c
    dw MetaSprite_13_4a51
    dw MetaSprite_13_4a66
    dw MetaSprite_13_4a7b
    dw MetaSprite_13_4a90
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aa5
    dw MetaSprite_13_4aab
    dw MetaSprite_13_4ab1
    dw MetaSprite_13_4abc
    dw MetaSprite_13_4ac7
    dw MetaSprite_13_4af5
    dw MetaSprite_13_4afb
    dw MetaSprite_13_4b06
    dw MetaSprite_13_4b11
    dw MetaSprite_13_4b1c
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27
    dw MetaSprite_13_4b27

SECTION "MetaSprite_13_4200", ROMX[$4200], BANK[$13]
MetaSprite_13_4200::
    INCBIN "gfx/unknown/metasprite_13/4200.sprite.bin"
MetaSprite_13_4200_END::
MetaSprite_13_4215::
    INCBIN "gfx/unknown/metasprite_13/4215.sprite.bin"
MetaSprite_13_4215_END::
MetaSprite_13_422a::
    INCBIN "gfx/unknown/metasprite_13/422a.sprite.bin"
MetaSprite_13_422a_END::
MetaSprite_13_4230::
    INCBIN "gfx/unknown/metasprite_13/4230.sprite.bin"
MetaSprite_13_4230_END::
MetaSprite_13_4245::
    INCBIN "gfx/unknown/metasprite_13/4245.sprite.bin"
MetaSprite_13_4245_END::
MetaSprite_13_425a::
    INCBIN "gfx/unknown/metasprite_13/425a.sprite.bin"
MetaSprite_13_425a_END::
MetaSprite_13_4279::
    INCBIN "gfx/unknown/metasprite_13/4279.sprite.bin"
MetaSprite_13_4279_END::
MetaSprite_13_428e::
    INCBIN "gfx/unknown/metasprite_13/428e.sprite.bin"
MetaSprite_13_428e_END::
MetaSprite_13_42a3::
    INCBIN "gfx/unknown/metasprite_13/42a3.sprite.bin"
MetaSprite_13_42a3_END::
MetaSprite_13_42c2::
    INCBIN "gfx/unknown/metasprite_13/42c2.sprite.bin"
MetaSprite_13_42c2_END::
MetaSprite_13_42d7::
    INCBIN "gfx/unknown/metasprite_13/42d7.sprite.bin"
MetaSprite_13_42d7_END::
MetaSprite_13_42ec::
    INCBIN "gfx/unknown/metasprite_13/42ec.sprite.bin"
MetaSprite_13_42ec_END::
MetaSprite_13_4301::
    INCBIN "gfx/unknown/metasprite_13/4301.sprite.bin"
MetaSprite_13_4301_END::
MetaSprite_13_4316::
    INCBIN "gfx/unknown/metasprite_13/4316.sprite.bin"
MetaSprite_13_4316_END::
MetaSprite_13_432b::
    INCBIN "gfx/unknown/metasprite_13/432b.sprite.bin"
MetaSprite_13_432b_END::
MetaSprite_13_4340::
    INCBIN "gfx/unknown/metasprite_13/4340.sprite.bin"
MetaSprite_13_4340_END::
MetaSprite_13_4355::
    INCBIN "gfx/unknown/metasprite_13/4355.sprite.bin"
MetaSprite_13_4355_END::
MetaSprite_13_436a::
    INCBIN "gfx/unknown/metasprite_13/436a.sprite.bin"
MetaSprite_13_436a_END::
MetaSprite_13_437f::
    INCBIN "gfx/unknown/metasprite_13/437f.sprite.bin"
MetaSprite_13_437f_END::
MetaSprite_13_4394::
    INCBIN "gfx/unknown/metasprite_13/4394.sprite.bin"
MetaSprite_13_4394_END::
MetaSprite_13_43a9::
    INCBIN "gfx/unknown/metasprite_13/43a9.sprite.bin"
MetaSprite_13_43a9_END::
MetaSprite_13_43be::
    INCBIN "gfx/unknown/metasprite_13/43be.sprite.bin"
MetaSprite_13_43be_END::
MetaSprite_13_43c9::
    INCBIN "gfx/unknown/metasprite_13/43c9.sprite.bin"
MetaSprite_13_43c9_END::
MetaSprite_13_43d4::
    INCBIN "gfx/unknown/metasprite_13/43d4.sprite.bin"
MetaSprite_13_43d4_END::
MetaSprite_13_43df::
    INCBIN "gfx/unknown/metasprite_13/43df.sprite.bin"
MetaSprite_13_43df_END::
MetaSprite_13_43ea::
    INCBIN "gfx/unknown/metasprite_13/43ea.sprite.bin"
MetaSprite_13_43ea_END::
MetaSprite_13_43f5::
    INCBIN "gfx/unknown/metasprite_13/43f5.sprite.bin"
MetaSprite_13_43f5_END::
MetaSprite_13_4400::
    INCBIN "gfx/unknown/metasprite_13/4400.sprite.bin"
MetaSprite_13_4400_END::
MetaSprite_13_440b::
    INCBIN "gfx/unknown/metasprite_13/440b.sprite.bin"
MetaSprite_13_440b_END::
MetaSprite_13_4416::
    INCBIN "gfx/unknown/metasprite_13/4416.sprite.bin"
MetaSprite_13_4416_END::
MetaSprite_13_4421::
    INCBIN "gfx/unknown/metasprite_13/4421.sprite.bin"
MetaSprite_13_4421_END::
MetaSprite_13_442c::
    INCBIN "gfx/unknown/metasprite_13/442c.sprite.bin"
MetaSprite_13_442c_END::
MetaSprite_13_4437::
    INCBIN "gfx/unknown/metasprite_13/4437.sprite.bin"
MetaSprite_13_4437_END::
MetaSprite_13_4442::
    INCBIN "gfx/unknown/metasprite_13/4442.sprite.bin"
MetaSprite_13_4442_END::
MetaSprite_13_444d::
    INCBIN "gfx/unknown/metasprite_13/444d.sprite.bin"
MetaSprite_13_444d_END::
MetaSprite_13_4458::
    INCBIN "gfx/unknown/metasprite_13/4458.sprite.bin"
MetaSprite_13_4458_END::
MetaSprite_13_4463::
    INCBIN "gfx/unknown/metasprite_13/4463.sprite.bin"
MetaSprite_13_4463_END::
MetaSprite_13_44b4::
    INCBIN "gfx/unknown/metasprite_13/44b4.sprite.bin"
MetaSprite_13_44b4_END::
MetaSprite_13_4505::
    INCBIN "gfx/unknown/metasprite_13/4505.sprite.bin"
MetaSprite_13_4505_END::
MetaSprite_13_4556::
    INCBIN "gfx/unknown/metasprite_13/4556.sprite.bin"
MetaSprite_13_4556_END::
MetaSprite_13_4566::
    INCBIN "gfx/unknown/metasprite_13/4566.sprite.bin"
MetaSprite_13_4566_END::
MetaSprite_13_4585::
    INCBIN "gfx/unknown/metasprite_13/4585.sprite.bin"
MetaSprite_13_4585_END::
MetaSprite_13_45b3::
    INCBIN "gfx/unknown/metasprite_13/45b3.sprite.bin"
MetaSprite_13_45b3_END::
MetaSprite_13_45c8::
    INCBIN "gfx/unknown/metasprite_13/45c8.sprite.bin"
MetaSprite_13_45c8_END::
MetaSprite_13_45d8::
    INCBIN "gfx/unknown/metasprite_13/45d8.sprite.bin"
MetaSprite_13_45d8_END::
MetaSprite_13_45f7::
    INCBIN "gfx/unknown/metasprite_13/45f7.sprite.bin"
MetaSprite_13_45f7_END::
MetaSprite_13_4625::
    INCBIN "gfx/unknown/metasprite_13/4625.sprite.bin"
MetaSprite_13_4625_END::
MetaSprite_13_4635::
    INCBIN "gfx/unknown/metasprite_13/4635.sprite.bin"
MetaSprite_13_4635_END::
MetaSprite_13_4686::
    INCBIN "gfx/unknown/metasprite_13/4686.sprite.bin"
MetaSprite_13_4686_END::
MetaSprite_13_46b4::
    INCBIN "gfx/unknown/metasprite_13/46b4.sprite.bin"
MetaSprite_13_46b4_END::
MetaSprite_13_46c9::
    INCBIN "gfx/unknown/metasprite_13/46c9.sprite.bin"
MetaSprite_13_46c9_END::
MetaSprite_13_46de::
    INCBIN "gfx/unknown/metasprite_13/46de.sprite.bin"
MetaSprite_13_46de_END::
MetaSprite_13_4707::
    INCBIN "gfx/unknown/metasprite_13/4707.sprite.bin"
MetaSprite_13_4707_END::
MetaSprite_13_4730::
    INCBIN "gfx/unknown/metasprite_13/4730.sprite.bin"
MetaSprite_13_4730_END::
MetaSprite_13_4759::
    INCBIN "gfx/unknown/metasprite_13/4759.sprite.bin"
MetaSprite_13_4759_END::
MetaSprite_13_4782::
    INCBIN "gfx/unknown/metasprite_13/4782.sprite.bin"
MetaSprite_13_4782_END::
MetaSprite_13_4788::
    INCBIN "gfx/unknown/metasprite_13/4788.sprite.bin"
MetaSprite_13_4788_END::
MetaSprite_13_478e::
    INCBIN "gfx/unknown/metasprite_13/478e.sprite.bin"
MetaSprite_13_478e_END::
MetaSprite_13_47a3::
    INCBIN "gfx/unknown/metasprite_13/47a3.sprite.bin"
MetaSprite_13_47a3_END::
MetaSprite_13_47b8::
    INCBIN "gfx/unknown/metasprite_13/47b8.sprite.bin"
MetaSprite_13_47b8_END::
MetaSprite_13_47cd::
    INCBIN "gfx/unknown/metasprite_13/47cd.sprite.bin"
MetaSprite_13_47cd_END::
MetaSprite_13_47e2::
    INCBIN "gfx/unknown/metasprite_13/47e2.sprite.bin"
MetaSprite_13_47e2_END::
MetaSprite_13_47f7::
    INCBIN "gfx/unknown/metasprite_13/47f7.sprite.bin"
MetaSprite_13_47f7_END::
MetaSprite_13_480c::
    INCBIN "gfx/unknown/metasprite_13/480c.sprite.bin"
MetaSprite_13_480c_END::
MetaSprite_13_4812::
    INCBIN "gfx/unknown/metasprite_13/4812.sprite.bin"
MetaSprite_13_4812_END::
MetaSprite_13_4818::
    INCBIN "gfx/unknown/metasprite_13/4818.sprite.bin"
MetaSprite_13_4818_END::
MetaSprite_13_481e::
    INCBIN "gfx/unknown/metasprite_13/481e.sprite.bin"
MetaSprite_13_481e_END::
MetaSprite_13_4824::
    INCBIN "gfx/unknown/metasprite_13/4824.sprite.bin"
MetaSprite_13_4824_END::
MetaSprite_13_4839::
    INCBIN "gfx/unknown/metasprite_13/4839.sprite.bin"
MetaSprite_13_4839_END::
MetaSprite_13_488a::
    INCBIN "gfx/unknown/metasprite_13/488a.sprite.bin"
MetaSprite_13_488a_END::
MetaSprite_13_489f::
    INCBIN "gfx/unknown/metasprite_13/489f.sprite.bin"
MetaSprite_13_489f_END::
MetaSprite_13_48b4::
    INCBIN "gfx/unknown/metasprite_13/48b4.sprite.bin"
MetaSprite_13_48b4_END::
MetaSprite_13_48bf::
    INCBIN "gfx/unknown/metasprite_13/48bf.sprite.bin"
MetaSprite_13_48bf_END::
MetaSprite_13_48d4::
    INCBIN "gfx/unknown/metasprite_13/48d4.sprite.bin"
MetaSprite_13_48d4_END::
MetaSprite_13_48e9::
    INCBIN "gfx/unknown/metasprite_13/48e9.sprite.bin"
MetaSprite_13_48e9_END::
MetaSprite_13_48fe::
    INCBIN "gfx/unknown/metasprite_13/48fe.sprite.bin"
MetaSprite_13_48fe_END::
MetaSprite_13_492c::
    INCBIN "gfx/unknown/metasprite_13/492c.sprite.bin"
MetaSprite_13_492c_END::
MetaSprite_13_4941::
    INCBIN "gfx/unknown/metasprite_13/4941.sprite.bin"
MetaSprite_13_4941_END::
MetaSprite_13_4956::
    INCBIN "gfx/unknown/metasprite_13/4956.sprite.bin"
MetaSprite_13_4956_END::
MetaSprite_13_4961::
    INCBIN "gfx/unknown/metasprite_13/4961.sprite.bin"
MetaSprite_13_4961_END::
MetaSprite_13_496c::
    INCBIN "gfx/unknown/metasprite_13/496c.sprite.bin"
MetaSprite_13_496c_END::
MetaSprite_13_4972::
    INCBIN "gfx/unknown/metasprite_13/4972.sprite.bin"
MetaSprite_13_4972_END::
MetaSprite_13_4978::
    INCBIN "gfx/unknown/metasprite_13/4978.sprite.bin"
MetaSprite_13_4978_END::
MetaSprite_13_497e::
    INCBIN "gfx/unknown/metasprite_13/497e.sprite.bin"
MetaSprite_13_497e_END::
MetaSprite_13_4993::
    INCBIN "gfx/unknown/metasprite_13/4993.sprite.bin"
MetaSprite_13_4993_END::
MetaSprite_13_499e::
    INCBIN "gfx/unknown/metasprite_13/499e.sprite.bin"
MetaSprite_13_499e_END::
MetaSprite_13_49a9::
    INCBIN "gfx/unknown/metasprite_13/49a9.sprite.bin"
MetaSprite_13_49a9_END::
MetaSprite_13_49be::
    INCBIN "gfx/unknown/metasprite_13/49be.sprite.bin"
MetaSprite_13_49be_END::
MetaSprite_13_49d3::
    INCBIN "gfx/unknown/metasprite_13/49d3.sprite.bin"
MetaSprite_13_49d3_END::
MetaSprite_13_49e8::
    INCBIN "gfx/unknown/metasprite_13/49e8.sprite.bin"
MetaSprite_13_49e8_END::
MetaSprite_13_49fd::
    INCBIN "gfx/unknown/metasprite_13/49fd.sprite.bin"
MetaSprite_13_49fd_END::
MetaSprite_13_4a12::
    INCBIN "gfx/unknown/metasprite_13/4a12.sprite.bin"
MetaSprite_13_4a12_END::
MetaSprite_13_4a27::
    INCBIN "gfx/unknown/metasprite_13/4a27.sprite.bin"
MetaSprite_13_4a27_END::
MetaSprite_13_4a3c::
    INCBIN "gfx/unknown/metasprite_13/4a3c.sprite.bin"
MetaSprite_13_4a3c_END::
MetaSprite_13_4a51::
    INCBIN "gfx/unknown/metasprite_13/4a51.sprite.bin"
MetaSprite_13_4a51_END::
MetaSprite_13_4a66::
    INCBIN "gfx/unknown/metasprite_13/4a66.sprite.bin"
MetaSprite_13_4a66_END::
MetaSprite_13_4a7b::
    INCBIN "gfx/unknown/metasprite_13/4a7b.sprite.bin"
MetaSprite_13_4a7b_END::
MetaSprite_13_4a90::
    INCBIN "gfx/unknown/metasprite_13/4a90.sprite.bin"
MetaSprite_13_4a90_END::
MetaSprite_13_4aa5::
    INCBIN "gfx/unknown/metasprite_13/4aa5.sprite.bin"
MetaSprite_13_4aa5_END::
MetaSprite_13_4aab::
    INCBIN "gfx/unknown/metasprite_13/4aab.sprite.bin"
MetaSprite_13_4aab_END::
MetaSprite_13_4ab1::
    INCBIN "gfx/unknown/metasprite_13/4ab1.sprite.bin"
MetaSprite_13_4ab1_END::
MetaSprite_13_4abc::
    INCBIN "gfx/unknown/metasprite_13/4abc.sprite.bin"
MetaSprite_13_4abc_END::
MetaSprite_13_4ac7::
    INCBIN "gfx/unknown/metasprite_13/4ac7.sprite.bin"
MetaSprite_13_4ac7_END::
MetaSprite_13_4af5::
    INCBIN "gfx/unknown/metasprite_13/4af5.sprite.bin"
MetaSprite_13_4af5_END::
MetaSprite_13_4afb::
    INCBIN "gfx/unknown/metasprite_13/4afb.sprite.bin"
MetaSprite_13_4afb_END::
MetaSprite_13_4b06::
    INCBIN "gfx/unknown/metasprite_13/4b06.sprite.bin"
MetaSprite_13_4b06_END::
MetaSprite_13_4b11::
    INCBIN "gfx/unknown/metasprite_13/4b11.sprite.bin"
MetaSprite_13_4b11_END::
MetaSprite_13_4b1c::
    INCBIN "gfx/unknown/metasprite_13/4b1c.sprite.bin"
MetaSprite_13_4b1c_END::
MetaSprite_13_4b27::
MetaSprite_13_4b27_END::

SECTION "MetaSprite_14", ROMX[$4000], BANK[$14]
MetaSprite_14::
    dw MetaSprite_14_41b8
    dw MetaSprite_14_41c8
    dw MetaSprite_14_41e2
    dw MetaSprite_14_4201
    dw MetaSprite_14_421b
    dw MetaSprite_14_422b
    dw MetaSprite_14_4240
    dw MetaSprite_14_4264
    dw MetaSprite_14_4297
    dw MetaSprite_14_42bb
    dw MetaSprite_14_42d0
    dw MetaSprite_14_42e0
    dw MetaSprite_14_42ff
    dw MetaSprite_14_431e
    dw MetaSprite_14_432e
    dw MetaSprite_14_4343
    dw MetaSprite_14_4367
    dw MetaSprite_14_437c
    dw MetaSprite_14_43a0
    dw MetaSprite_14_43ab
    dw MetaSprite_14_43bb
    dw MetaSprite_14_43d0
    dw MetaSprite_14_43ea
    dw MetaSprite_14_4404
    dw MetaSprite_14_4419
    dw MetaSprite_14_4424
    dw MetaSprite_14_4439
    dw MetaSprite_14_445d
    dw MetaSprite_14_447c
    dw MetaSprite_14_449b
    dw MetaSprite_14_44c4
    dw MetaSprite_14_4501
    dw MetaSprite_14_4511
    dw MetaSprite_14_452b
    dw MetaSprite_14_454a
    dw MetaSprite_14_4564
    dw MetaSprite_14_4574
    dw MetaSprite_14_4584
    dw MetaSprite_14_459e
    dw MetaSprite_14_45bd
    dw MetaSprite_14_45d7
    dw MetaSprite_14_45e7
    dw MetaSprite_14_45fc
    dw MetaSprite_14_4611
    dw MetaSprite_14_464e
    dw MetaSprite_14_4663
    dw MetaSprite_14_4678
    dw MetaSprite_14_468d
    dw MetaSprite_14_46a2
    dw MetaSprite_14_46a8
    dw MetaSprite_14_46bd
    dw MetaSprite_14_474a
    dw MetaSprite_14_47d7
    dw MetaSprite_14_47e7
    dw MetaSprite_14_4801
    dw MetaSprite_14_4820
    dw MetaSprite_14_483a
    dw MetaSprite_14_484a
    dw MetaSprite_14_485a
    dw MetaSprite_14_4874
    dw MetaSprite_14_4893
    dw MetaSprite_14_48ad
    dw MetaSprite_14_48bd
    dw MetaSprite_14_48d2
    dw MetaSprite_14_48f6
    dw MetaSprite_14_4929
    dw MetaSprite_14_494d
    dw MetaSprite_14_4962
    dw MetaSprite_14_4977
    dw MetaSprite_14_499b
    dw MetaSprite_14_49ce
    dw MetaSprite_14_49f2
    dw MetaSprite_14_4a07
    dw MetaSprite_14_4a1c
    dw MetaSprite_14_4a40
    dw MetaSprite_14_4a73
    dw MetaSprite_14_4a97
    dw MetaSprite_14_4aac
    dw MetaSprite_14_4abc
    dw MetaSprite_14_4adb
    dw MetaSprite_14_4afa
    dw MetaSprite_14_4b0a
    dw MetaSprite_14_4b6f
    dw MetaSprite_14_4c06
    dw MetaSprite_14_4c6b
    dw MetaSprite_14_4c8a
    dw MetaSprite_14_4ca9
    dw MetaSprite_14_4cb4
    dw MetaSprite_14_4cdd
    dw MetaSprite_14_4cf2
    dw MetaSprite_14_4d07
    dw MetaSprite_14_4d1c
    dw MetaSprite_14_4d45
    dw MetaSprite_14_4d6e
    dw MetaSprite_14_4d83
    dw MetaSprite_14_4d98
    dw MetaSprite_14_4dad
    dw MetaSprite_14_4dc2
    dw MetaSprite_14_4dd7
    dw MetaSprite_14_4dec
    dw MetaSprite_14_4e01
    dw MetaSprite_14_4e1b
    dw MetaSprite_14_4e35
    dw MetaSprite_14_4e4f
    dw MetaSprite_14_4e64
    dw MetaSprite_14_4e83
    dw MetaSprite_14_4eac
    dw MetaSprite_14_4edf
    dw MetaSprite_14_4f08
    dw MetaSprite_14_4f27
    dw MetaSprite_14_4f3c
    dw MetaSprite_14_4f51
    dw MetaSprite_14_4f6b
    dw MetaSprite_14_4f85
    dw MetaSprite_14_4fa4
    dw MetaSprite_14_4fbe
    dw MetaSprite_14_4fec
    dw MetaSprite_14_5024
    dw MetaSprite_14_5052
    dw MetaSprite_14_508a
    dw MetaSprite_14_50b8
    dw MetaSprite_14_50be
    dw MetaSprite_14_50d3
    dw MetaSprite_14_50fc
    dw MetaSprite_14_511b
    dw MetaSprite_14_5135
    dw MetaSprite_14_514f
    dw MetaSprite_14_516e
    dw MetaSprite_14_5188
    dw MetaSprite_14_51b6
    dw MetaSprite_14_51ee
    dw MetaSprite_14_521c
    dw MetaSprite_14_5254
    dw MetaSprite_14_5282
    dw MetaSprite_14_5288
    dw MetaSprite_14_529d
    dw MetaSprite_14_52c6
    dw MetaSprite_14_52e5
    dw MetaSprite_14_5336
    dw MetaSprite_14_537d
    dw MetaSprite_14_53a6
    dw MetaSprite_14_53d9
    dw MetaSprite_14_5416
    dw MetaSprite_14_545d
    dw MetaSprite_14_549a
    dw MetaSprite_14_54c3
    dw MetaSprite_14_5514
    dw MetaSprite_14_555b
    dw MetaSprite_14_5575
    dw MetaSprite_14_558f
    dw MetaSprite_14_55a9
    dw MetaSprite_14_55d7
    dw MetaSprite_14_5614
    dw MetaSprite_14_5660
    dw MetaSprite_14_56bb
    dw MetaSprite_14_5707
    dw MetaSprite_14_5735
    dw MetaSprite_14_574f
    dw MetaSprite_14_5769
    dw MetaSprite_14_578d
    dw MetaSprite_14_57c5
    dw MetaSprite_14_581b
    dw MetaSprite_14_5867
    dw MetaSprite_14_58cc
    dw MetaSprite_14_5922
    dw MetaSprite_14_5937
    dw MetaSprite_14_594c
    dw MetaSprite_14_5975
    dw MetaSprite_14_599e
    dw MetaSprite_14_59b8
    dw MetaSprite_14_59d2
    dw MetaSprite_14_59ec
    dw MetaSprite_14_5a15
    dw MetaSprite_14_5a52
    dw MetaSprite_14_5aa3
    dw MetaSprite_14_5af4
    dw MetaSprite_14_5b31
    dw MetaSprite_14_5b5a
    dw MetaSprite_14_5b6f
    dw MetaSprite_14_5b84
    dw MetaSprite_14_5bad
    dw MetaSprite_14_5bd6
    dw MetaSprite_14_5beb
    dw MetaSprite_14_5c00
    dw MetaSprite_14_5c06
    dw MetaSprite_14_5c0c
    dw MetaSprite_14_5c21
    dw MetaSprite_14_5c36
    dw MetaSprite_14_5c3c
    dw MetaSprite_14_5c42
    dw MetaSprite_14_5c57
    dw MetaSprite_14_5c6c
    dw MetaSprite_14_5c72
    dw MetaSprite_14_5c78
    dw MetaSprite_14_5c88
    dw MetaSprite_14_5ca2
    dw MetaSprite_14_5cc1
    dw MetaSprite_14_5cdb
    dw MetaSprite_14_5ceb
    dw MetaSprite_14_5d00
    dw MetaSprite_14_5d24
    dw MetaSprite_14_5d57
    dw MetaSprite_14_5d7b
    dw MetaSprite_14_5d90
    dw MetaSprite_14_5da5
    dw MetaSprite_14_5dba
    dw MetaSprite_14_5de3
    dw MetaSprite_14_5dfd
    dw MetaSprite_14_5e26
    dw MetaSprite_14_5e3b
    dw MetaSprite_14_5e78
    dw MetaSprite_14_5e8d
    dw MetaSprite_14_5ea2
    dw MetaSprite_14_5edf
    dw MetaSprite_14_5f1c
    dw MetaSprite_14_5f31
    dw MetaSprite_14_5f46
    dw MetaSprite_14_5f6f
    dw MetaSprite_14_5fd4
    dw MetaSprite_14_6025

SECTION "MetaSprite_14_41b8", ROMX[$41b8], BANK[$14]
MetaSprite_14_41b8::
    INCBIN "gfx/unknown/metasprite_14/41b8.sprite.bin"
MetaSprite_14_41b8_END::
MetaSprite_14_41c8::
    INCBIN "gfx/unknown/metasprite_14/41c8.sprite.bin"
MetaSprite_14_41c8_END::
MetaSprite_14_41e2::
    INCBIN "gfx/unknown/metasprite_14/41e2.sprite.bin"
MetaSprite_14_41e2_END::
MetaSprite_14_4201::
    INCBIN "gfx/unknown/metasprite_14/4201.sprite.bin"
MetaSprite_14_4201_END::
MetaSprite_14_421b::
    INCBIN "gfx/unknown/metasprite_14/421b.sprite.bin"
MetaSprite_14_421b_END::
MetaSprite_14_422b::
    INCBIN "gfx/unknown/metasprite_14/422b.sprite.bin"
MetaSprite_14_422b_END::
MetaSprite_14_4240::
    INCBIN "gfx/unknown/metasprite_14/4240.sprite.bin"
MetaSprite_14_4240_END::
MetaSprite_14_4264::
    INCBIN "gfx/unknown/metasprite_14/4264.sprite.bin"
MetaSprite_14_4264_END::
MetaSprite_14_4297::
    INCBIN "gfx/unknown/metasprite_14/4297.sprite.bin"
MetaSprite_14_4297_END::
MetaSprite_14_42bb::
    INCBIN "gfx/unknown/metasprite_14/42bb.sprite.bin"
MetaSprite_14_42bb_END::
MetaSprite_14_42d0::
    INCBIN "gfx/unknown/metasprite_14/42d0.sprite.bin"
MetaSprite_14_42d0_END::
MetaSprite_14_42e0::
    INCBIN "gfx/unknown/metasprite_14/42e0.sprite.bin"
MetaSprite_14_42e0_END::
MetaSprite_14_42ff::
    INCBIN "gfx/unknown/metasprite_14/42ff.sprite.bin"
MetaSprite_14_42ff_END::
MetaSprite_14_431e::
    INCBIN "gfx/unknown/metasprite_14/431e.sprite.bin"
MetaSprite_14_431e_END::
MetaSprite_14_432e::
    INCBIN "gfx/unknown/metasprite_14/432e.sprite.bin"
MetaSprite_14_432e_END::
MetaSprite_14_4343::
    INCBIN "gfx/unknown/metasprite_14/4343.sprite.bin"
MetaSprite_14_4343_END::
MetaSprite_14_4367::
    INCBIN "gfx/unknown/metasprite_14/4367.sprite.bin"
MetaSprite_14_4367_END::
MetaSprite_14_437c::
    INCBIN "gfx/unknown/metasprite_14/437c.sprite.bin"
MetaSprite_14_437c_END::
MetaSprite_14_43a0::
    INCBIN "gfx/unknown/metasprite_14/43a0.sprite.bin"
MetaSprite_14_43a0_END::
MetaSprite_14_43ab::
    INCBIN "gfx/unknown/metasprite_14/43ab.sprite.bin"
MetaSprite_14_43ab_END::
MetaSprite_14_43bb::
    INCBIN "gfx/unknown/metasprite_14/43bb.sprite.bin"
MetaSprite_14_43bb_END::
MetaSprite_14_43d0::
    INCBIN "gfx/unknown/metasprite_14/43d0.sprite.bin"
MetaSprite_14_43d0_END::
MetaSprite_14_43ea::
    INCBIN "gfx/unknown/metasprite_14/43ea.sprite.bin"
MetaSprite_14_43ea_END::
MetaSprite_14_4404::
    INCBIN "gfx/unknown/metasprite_14/4404.sprite.bin"
MetaSprite_14_4404_END::
MetaSprite_14_4419::
    INCBIN "gfx/unknown/metasprite_14/4419.sprite.bin"
MetaSprite_14_4419_END::
MetaSprite_14_4424::
    INCBIN "gfx/unknown/metasprite_14/4424.sprite.bin"
MetaSprite_14_4424_END::
MetaSprite_14_4439::
    INCBIN "gfx/unknown/metasprite_14/4439.sprite.bin"
MetaSprite_14_4439_END::
MetaSprite_14_445d::
    INCBIN "gfx/unknown/metasprite_14/445d.sprite.bin"
MetaSprite_14_445d_END::
MetaSprite_14_447c::
    INCBIN "gfx/unknown/metasprite_14/447c.sprite.bin"
MetaSprite_14_447c_END::
MetaSprite_14_449b::
    INCBIN "gfx/unknown/metasprite_14/449b.sprite.bin"
MetaSprite_14_449b_END::
MetaSprite_14_44c4::
    INCBIN "gfx/unknown/metasprite_14/44c4.sprite.bin"
MetaSprite_14_44c4_END::
MetaSprite_14_4501::
    INCBIN "gfx/unknown/metasprite_14/4501.sprite.bin"
MetaSprite_14_4501_END::
MetaSprite_14_4511::
    INCBIN "gfx/unknown/metasprite_14/4511.sprite.bin"
MetaSprite_14_4511_END::
MetaSprite_14_452b::
    INCBIN "gfx/unknown/metasprite_14/452b.sprite.bin"
MetaSprite_14_452b_END::
MetaSprite_14_454a::
    INCBIN "gfx/unknown/metasprite_14/454a.sprite.bin"
MetaSprite_14_454a_END::
MetaSprite_14_4564::
    INCBIN "gfx/unknown/metasprite_14/4564.sprite.bin"
MetaSprite_14_4564_END::
MetaSprite_14_4574::
    INCBIN "gfx/unknown/metasprite_14/4574.sprite.bin"
MetaSprite_14_4574_END::
MetaSprite_14_4584::
    INCBIN "gfx/unknown/metasprite_14/4584.sprite.bin"
MetaSprite_14_4584_END::
MetaSprite_14_459e::
    INCBIN "gfx/unknown/metasprite_14/459e.sprite.bin"
MetaSprite_14_459e_END::
MetaSprite_14_45bd::
    INCBIN "gfx/unknown/metasprite_14/45bd.sprite.bin"
MetaSprite_14_45bd_END::
MetaSprite_14_45d7::
    INCBIN "gfx/unknown/metasprite_14/45d7.sprite.bin"
MetaSprite_14_45d7_END::
MetaSprite_14_45e7::
    INCBIN "gfx/unknown/metasprite_14/45e7.sprite.bin"
MetaSprite_14_45e7_END::
MetaSprite_14_45fc::
    INCBIN "gfx/unknown/metasprite_14/45fc.sprite.bin"
MetaSprite_14_45fc_END::
MetaSprite_14_4611::
    INCBIN "gfx/unknown/metasprite_14/4611.sprite.bin"
MetaSprite_14_4611_END::
MetaSprite_14_464e::
    INCBIN "gfx/unknown/metasprite_14/464e.sprite.bin"
MetaSprite_14_464e_END::
MetaSprite_14_4663::
    INCBIN "gfx/unknown/metasprite_14/4663.sprite.bin"
MetaSprite_14_4663_END::
MetaSprite_14_4678::
    INCBIN "gfx/unknown/metasprite_14/4678.sprite.bin"
MetaSprite_14_4678_END::
MetaSprite_14_468d::
    INCBIN "gfx/unknown/metasprite_14/468d.sprite.bin"
MetaSprite_14_468d_END::
MetaSprite_14_46a2::
    INCBIN "gfx/unknown/metasprite_14/46a2.sprite.bin"
MetaSprite_14_46a2_END::
MetaSprite_14_46a8::
    INCBIN "gfx/unknown/metasprite_14/46a8.sprite.bin"
MetaSprite_14_46a8_END::
MetaSprite_14_46bd::
    INCBIN "gfx/unknown/metasprite_14/46bd.sprite.bin"
MetaSprite_14_46bd_END::
MetaSprite_14_474a::
    INCBIN "gfx/unknown/metasprite_14/474a.sprite.bin"
MetaSprite_14_474a_END::
MetaSprite_14_47d7::
    INCBIN "gfx/unknown/metasprite_14/47d7.sprite.bin"
MetaSprite_14_47d7_END::
MetaSprite_14_47e7::
    INCBIN "gfx/unknown/metasprite_14/47e7.sprite.bin"
MetaSprite_14_47e7_END::
MetaSprite_14_4801::
    INCBIN "gfx/unknown/metasprite_14/4801.sprite.bin"
MetaSprite_14_4801_END::
MetaSprite_14_4820::
    INCBIN "gfx/unknown/metasprite_14/4820.sprite.bin"
MetaSprite_14_4820_END::
MetaSprite_14_483a::
    INCBIN "gfx/unknown/metasprite_14/483a.sprite.bin"
MetaSprite_14_483a_END::
MetaSprite_14_484a::
    INCBIN "gfx/unknown/metasprite_14/484a.sprite.bin"
MetaSprite_14_484a_END::
MetaSprite_14_485a::
    INCBIN "gfx/unknown/metasprite_14/485a.sprite.bin"
MetaSprite_14_485a_END::
MetaSprite_14_4874::
    INCBIN "gfx/unknown/metasprite_14/4874.sprite.bin"
MetaSprite_14_4874_END::
MetaSprite_14_4893::
    INCBIN "gfx/unknown/metasprite_14/4893.sprite.bin"
MetaSprite_14_4893_END::
MetaSprite_14_48ad::
    INCBIN "gfx/unknown/metasprite_14/48ad.sprite.bin"
MetaSprite_14_48ad_END::
MetaSprite_14_48bd::
    INCBIN "gfx/unknown/metasprite_14/48bd.sprite.bin"
MetaSprite_14_48bd_END::
MetaSprite_14_48d2::
    INCBIN "gfx/unknown/metasprite_14/48d2.sprite.bin"
MetaSprite_14_48d2_END::
MetaSprite_14_48f6::
    INCBIN "gfx/unknown/metasprite_14/48f6.sprite.bin"
MetaSprite_14_48f6_END::
MetaSprite_14_4929::
    INCBIN "gfx/unknown/metasprite_14/4929.sprite.bin"
MetaSprite_14_4929_END::
MetaSprite_14_494d::
    INCBIN "gfx/unknown/metasprite_14/494d.sprite.bin"
MetaSprite_14_494d_END::
MetaSprite_14_4962::
    INCBIN "gfx/unknown/metasprite_14/4962.sprite.bin"
MetaSprite_14_4962_END::
MetaSprite_14_4977::
    INCBIN "gfx/unknown/metasprite_14/4977.sprite.bin"
MetaSprite_14_4977_END::
MetaSprite_14_499b::
    INCBIN "gfx/unknown/metasprite_14/499b.sprite.bin"
MetaSprite_14_499b_END::
MetaSprite_14_49ce::
    INCBIN "gfx/unknown/metasprite_14/49ce.sprite.bin"
MetaSprite_14_49ce_END::
MetaSprite_14_49f2::
    INCBIN "gfx/unknown/metasprite_14/49f2.sprite.bin"
MetaSprite_14_49f2_END::
MetaSprite_14_4a07::
    INCBIN "gfx/unknown/metasprite_14/4a07.sprite.bin"
MetaSprite_14_4a07_END::
MetaSprite_14_4a1c::
    INCBIN "gfx/unknown/metasprite_14/4a1c.sprite.bin"
MetaSprite_14_4a1c_END::
MetaSprite_14_4a40::
    INCBIN "gfx/unknown/metasprite_14/4a40.sprite.bin"
MetaSprite_14_4a40_END::
MetaSprite_14_4a73::
    INCBIN "gfx/unknown/metasprite_14/4a73.sprite.bin"
MetaSprite_14_4a73_END::
MetaSprite_14_4a97::
    INCBIN "gfx/unknown/metasprite_14/4a97.sprite.bin"
MetaSprite_14_4a97_END::
MetaSprite_14_4aac::
    INCBIN "gfx/unknown/metasprite_14/4aac.sprite.bin"
MetaSprite_14_4aac_END::
MetaSprite_14_4abc::
    INCBIN "gfx/unknown/metasprite_14/4abc.sprite.bin"
MetaSprite_14_4abc_END::
MetaSprite_14_4adb::
    INCBIN "gfx/unknown/metasprite_14/4adb.sprite.bin"
MetaSprite_14_4adb_END::
MetaSprite_14_4afa::
    INCBIN "gfx/unknown/metasprite_14/4afa.sprite.bin"
MetaSprite_14_4afa_END::
MetaSprite_14_4b0a::
    INCBIN "gfx/unknown/metasprite_14/4b0a.sprite.bin"
MetaSprite_14_4b0a_END::
MetaSprite_14_4b6f::
    INCBIN "gfx/unknown/metasprite_14/4b6f.sprite.bin"
MetaSprite_14_4b6f_END::
MetaSprite_14_4c06::
    INCBIN "gfx/unknown/metasprite_14/4c06.sprite.bin"
MetaSprite_14_4c06_END::
MetaSprite_14_4c6b::
    INCBIN "gfx/unknown/metasprite_14/4c6b.sprite.bin"
MetaSprite_14_4c6b_END::
MetaSprite_14_4c8a::
    INCBIN "gfx/unknown/metasprite_14/4c8a.sprite.bin"
MetaSprite_14_4c8a_END::
MetaSprite_14_4ca9::
    INCBIN "gfx/unknown/metasprite_14/4ca9.sprite.bin"
MetaSprite_14_4ca9_END::
MetaSprite_14_4cb4::
    INCBIN "gfx/unknown/metasprite_14/4cb4.sprite.bin"
MetaSprite_14_4cb4_END::
MetaSprite_14_4cdd::
    INCBIN "gfx/unknown/metasprite_14/4cdd.sprite.bin"
MetaSprite_14_4cdd_END::
MetaSprite_14_4cf2::
    INCBIN "gfx/unknown/metasprite_14/4cf2.sprite.bin"
MetaSprite_14_4cf2_END::
MetaSprite_14_4d07::
    INCBIN "gfx/unknown/metasprite_14/4d07.sprite.bin"
MetaSprite_14_4d07_END::
MetaSprite_14_4d1c::
    INCBIN "gfx/unknown/metasprite_14/4d1c.sprite.bin"
MetaSprite_14_4d1c_END::
MetaSprite_14_4d45::
    INCBIN "gfx/unknown/metasprite_14/4d45.sprite.bin"
MetaSprite_14_4d45_END::
MetaSprite_14_4d6e::
    INCBIN "gfx/unknown/metasprite_14/4d6e.sprite.bin"
MetaSprite_14_4d6e_END::
MetaSprite_14_4d83::
    INCBIN "gfx/unknown/metasprite_14/4d83.sprite.bin"
MetaSprite_14_4d83_END::
MetaSprite_14_4d98::
    INCBIN "gfx/unknown/metasprite_14/4d98.sprite.bin"
MetaSprite_14_4d98_END::
MetaSprite_14_4dad::
    INCBIN "gfx/unknown/metasprite_14/4dad.sprite.bin"
MetaSprite_14_4dad_END::
MetaSprite_14_4dc2::
    INCBIN "gfx/unknown/metasprite_14/4dc2.sprite.bin"
MetaSprite_14_4dc2_END::
MetaSprite_14_4dd7::
    INCBIN "gfx/unknown/metasprite_14/4dd7.sprite.bin"
MetaSprite_14_4dd7_END::
MetaSprite_14_4dec::
    INCBIN "gfx/unknown/metasprite_14/4dec.sprite.bin"
MetaSprite_14_4dec_END::
MetaSprite_14_4e01::
    INCBIN "gfx/unknown/metasprite_14/4e01.sprite.bin"
MetaSprite_14_4e01_END::
MetaSprite_14_4e1b::
    INCBIN "gfx/unknown/metasprite_14/4e1b.sprite.bin"
MetaSprite_14_4e1b_END::
MetaSprite_14_4e35::
    INCBIN "gfx/unknown/metasprite_14/4e35.sprite.bin"
MetaSprite_14_4e35_END::
MetaSprite_14_4e4f::
    INCBIN "gfx/unknown/metasprite_14/4e4f.sprite.bin"
MetaSprite_14_4e4f_END::
MetaSprite_14_4e64::
    INCBIN "gfx/unknown/metasprite_14/4e64.sprite.bin"
MetaSprite_14_4e64_END::
MetaSprite_14_4e83::
    INCBIN "gfx/unknown/metasprite_14/4e83.sprite.bin"
MetaSprite_14_4e83_END::
MetaSprite_14_4eac::
    INCBIN "gfx/unknown/metasprite_14/4eac.sprite.bin"
MetaSprite_14_4eac_END::
MetaSprite_14_4edf::
    INCBIN "gfx/unknown/metasprite_14/4edf.sprite.bin"
MetaSprite_14_4edf_END::
MetaSprite_14_4f08::
    INCBIN "gfx/unknown/metasprite_14/4f08.sprite.bin"
MetaSprite_14_4f08_END::
MetaSprite_14_4f27::
    INCBIN "gfx/unknown/metasprite_14/4f27.sprite.bin"
MetaSprite_14_4f27_END::
MetaSprite_14_4f3c::
    INCBIN "gfx/unknown/metasprite_14/4f3c.sprite.bin"
MetaSprite_14_4f3c_END::
MetaSprite_14_4f51::
    INCBIN "gfx/unknown/metasprite_14/4f51.sprite.bin"
MetaSprite_14_4f51_END::
MetaSprite_14_4f6b::
    INCBIN "gfx/unknown/metasprite_14/4f6b.sprite.bin"
MetaSprite_14_4f6b_END::
MetaSprite_14_4f85::
    INCBIN "gfx/unknown/metasprite_14/4f85.sprite.bin"
MetaSprite_14_4f85_END::
MetaSprite_14_4fa4::
    INCBIN "gfx/unknown/metasprite_14/4fa4.sprite.bin"
MetaSprite_14_4fa4_END::
MetaSprite_14_4fbe::
    INCBIN "gfx/unknown/metasprite_14/4fbe.sprite.bin"
MetaSprite_14_4fbe_END::
MetaSprite_14_4fec::
    INCBIN "gfx/unknown/metasprite_14/4fec.sprite.bin"
MetaSprite_14_4fec_END::
MetaSprite_14_5024::
    INCBIN "gfx/unknown/metasprite_14/5024.sprite.bin"
MetaSprite_14_5024_END::
MetaSprite_14_5052::
    INCBIN "gfx/unknown/metasprite_14/5052.sprite.bin"
MetaSprite_14_5052_END::
MetaSprite_14_508a::
    INCBIN "gfx/unknown/metasprite_14/508a.sprite.bin"
MetaSprite_14_508a_END::
MetaSprite_14_50b8::
    INCBIN "gfx/unknown/metasprite_14/50b8.sprite.bin"
MetaSprite_14_50b8_END::
MetaSprite_14_50be::
    INCBIN "gfx/unknown/metasprite_14/50be.sprite.bin"
MetaSprite_14_50be_END::
MetaSprite_14_50d3::
    INCBIN "gfx/unknown/metasprite_14/50d3.sprite.bin"
MetaSprite_14_50d3_END::
MetaSprite_14_50fc::
    INCBIN "gfx/unknown/metasprite_14/50fc.sprite.bin"
MetaSprite_14_50fc_END::
MetaSprite_14_511b::
    INCBIN "gfx/unknown/metasprite_14/511b.sprite.bin"
MetaSprite_14_511b_END::
MetaSprite_14_5135::
    INCBIN "gfx/unknown/metasprite_14/5135.sprite.bin"
MetaSprite_14_5135_END::
MetaSprite_14_514f::
    INCBIN "gfx/unknown/metasprite_14/514f.sprite.bin"
MetaSprite_14_514f_END::
MetaSprite_14_516e::
    INCBIN "gfx/unknown/metasprite_14/516e.sprite.bin"
MetaSprite_14_516e_END::
MetaSprite_14_5188::
    INCBIN "gfx/unknown/metasprite_14/5188.sprite.bin"
MetaSprite_14_5188_END::
MetaSprite_14_51b6::
    INCBIN "gfx/unknown/metasprite_14/51b6.sprite.bin"
MetaSprite_14_51b6_END::
MetaSprite_14_51ee::
    INCBIN "gfx/unknown/metasprite_14/51ee.sprite.bin"
MetaSprite_14_51ee_END::
MetaSprite_14_521c::
    INCBIN "gfx/unknown/metasprite_14/521c.sprite.bin"
MetaSprite_14_521c_END::
MetaSprite_14_5254::
    INCBIN "gfx/unknown/metasprite_14/5254.sprite.bin"
MetaSprite_14_5254_END::
MetaSprite_14_5282::
    INCBIN "gfx/unknown/metasprite_14/5282.sprite.bin"
MetaSprite_14_5282_END::
MetaSprite_14_5288::
    INCBIN "gfx/unknown/metasprite_14/5288.sprite.bin"
MetaSprite_14_5288_END::
MetaSprite_14_529d::
    INCBIN "gfx/unknown/metasprite_14/529d.sprite.bin"
MetaSprite_14_529d_END::
MetaSprite_14_52c6::
    INCBIN "gfx/unknown/metasprite_14/52c6.sprite.bin"
MetaSprite_14_52c6_END::
MetaSprite_14_52e5::
    INCBIN "gfx/unknown/metasprite_14/52e5.sprite.bin"
MetaSprite_14_52e5_END::
MetaSprite_14_5336::
    INCBIN "gfx/unknown/metasprite_14/5336.sprite.bin"
MetaSprite_14_5336_END::
MetaSprite_14_537d::
    INCBIN "gfx/unknown/metasprite_14/537d.sprite.bin"
MetaSprite_14_537d_END::
MetaSprite_14_53a6::
    INCBIN "gfx/unknown/metasprite_14/53a6.sprite.bin"
MetaSprite_14_53a6_END::
MetaSprite_14_53d9::
    INCBIN "gfx/unknown/metasprite_14/53d9.sprite.bin"
MetaSprite_14_53d9_END::
MetaSprite_14_5416::
    INCBIN "gfx/unknown/metasprite_14/5416.sprite.bin"
MetaSprite_14_5416_END::
MetaSprite_14_545d::
    INCBIN "gfx/unknown/metasprite_14/545d.sprite.bin"
MetaSprite_14_545d_END::
MetaSprite_14_549a::
    INCBIN "gfx/unknown/metasprite_14/549a.sprite.bin"
MetaSprite_14_549a_END::
MetaSprite_14_54c3::
    INCBIN "gfx/unknown/metasprite_14/54c3.sprite.bin"
MetaSprite_14_54c3_END::
MetaSprite_14_5514::
    INCBIN "gfx/unknown/metasprite_14/5514.sprite.bin"
MetaSprite_14_5514_END::
MetaSprite_14_555b::
    INCBIN "gfx/unknown/metasprite_14/555b.sprite.bin"
MetaSprite_14_555b_END::
MetaSprite_14_5575::
    INCBIN "gfx/unknown/metasprite_14/5575.sprite.bin"
MetaSprite_14_5575_END::
MetaSprite_14_558f::
    INCBIN "gfx/unknown/metasprite_14/558f.sprite.bin"
MetaSprite_14_558f_END::
MetaSprite_14_55a9::
    INCBIN "gfx/unknown/metasprite_14/55a9.sprite.bin"
MetaSprite_14_55a9_END::
MetaSprite_14_55d7::
    INCBIN "gfx/unknown/metasprite_14/55d7.sprite.bin"
MetaSprite_14_55d7_END::
MetaSprite_14_5614::
    INCBIN "gfx/unknown/metasprite_14/5614.sprite.bin"
MetaSprite_14_5614_END::
MetaSprite_14_5660::
    INCBIN "gfx/unknown/metasprite_14/5660.sprite.bin"
MetaSprite_14_5660_END::
MetaSprite_14_56bb::
    INCBIN "gfx/unknown/metasprite_14/56bb.sprite.bin"
MetaSprite_14_56bb_END::
MetaSprite_14_5707::
    INCBIN "gfx/unknown/metasprite_14/5707.sprite.bin"
MetaSprite_14_5707_END::
MetaSprite_14_5735::
    INCBIN "gfx/unknown/metasprite_14/5735.sprite.bin"
MetaSprite_14_5735_END::
MetaSprite_14_574f::
    INCBIN "gfx/unknown/metasprite_14/574f.sprite.bin"
MetaSprite_14_574f_END::
MetaSprite_14_5769::
    INCBIN "gfx/unknown/metasprite_14/5769.sprite.bin"
MetaSprite_14_5769_END::
MetaSprite_14_578d::
    INCBIN "gfx/unknown/metasprite_14/578d.sprite.bin"
MetaSprite_14_578d_END::
MetaSprite_14_57c5::
    INCBIN "gfx/unknown/metasprite_14/57c5.sprite.bin"
MetaSprite_14_57c5_END::
MetaSprite_14_581b::
    INCBIN "gfx/unknown/metasprite_14/581b.sprite.bin"
MetaSprite_14_581b_END::
MetaSprite_14_5867::
    INCBIN "gfx/unknown/metasprite_14/5867.sprite.bin"
MetaSprite_14_5867_END::
MetaSprite_14_58cc::
    INCBIN "gfx/unknown/metasprite_14/58cc.sprite.bin"
MetaSprite_14_58cc_END::
MetaSprite_14_5922::
    INCBIN "gfx/unknown/metasprite_14/5922.sprite.bin"
MetaSprite_14_5922_END::
MetaSprite_14_5937::
    INCBIN "gfx/unknown/metasprite_14/5937.sprite.bin"
MetaSprite_14_5937_END::
MetaSprite_14_594c::
    INCBIN "gfx/unknown/metasprite_14/594c.sprite.bin"
MetaSprite_14_594c_END::
MetaSprite_14_5975::
    INCBIN "gfx/unknown/metasprite_14/5975.sprite.bin"
MetaSprite_14_5975_END::
MetaSprite_14_599e::
    INCBIN "gfx/unknown/metasprite_14/599e.sprite.bin"
MetaSprite_14_599e_END::
MetaSprite_14_59b8::
    INCBIN "gfx/unknown/metasprite_14/59b8.sprite.bin"
MetaSprite_14_59b8_END::
MetaSprite_14_59d2::
    INCBIN "gfx/unknown/metasprite_14/59d2.sprite.bin"
MetaSprite_14_59d2_END::
MetaSprite_14_59ec::
    INCBIN "gfx/unknown/metasprite_14/59ec.sprite.bin"
MetaSprite_14_59ec_END::
MetaSprite_14_5a15::
    INCBIN "gfx/unknown/metasprite_14/5a15.sprite.bin"
MetaSprite_14_5a15_END::
MetaSprite_14_5a52::
    INCBIN "gfx/unknown/metasprite_14/5a52.sprite.bin"
MetaSprite_14_5a52_END::
MetaSprite_14_5aa3::
    INCBIN "gfx/unknown/metasprite_14/5aa3.sprite.bin"
MetaSprite_14_5aa3_END::
MetaSprite_14_5af4::
    INCBIN "gfx/unknown/metasprite_14/5af4.sprite.bin"
MetaSprite_14_5af4_END::
MetaSprite_14_5b31::
    INCBIN "gfx/unknown/metasprite_14/5b31.sprite.bin"
MetaSprite_14_5b31_END::
MetaSprite_14_5b5a::
    INCBIN "gfx/unknown/metasprite_14/5b5a.sprite.bin"
MetaSprite_14_5b5a_END::
MetaSprite_14_5b6f::
    INCBIN "gfx/unknown/metasprite_14/5b6f.sprite.bin"
MetaSprite_14_5b6f_END::
MetaSprite_14_5b84::
    INCBIN "gfx/unknown/metasprite_14/5b84.sprite.bin"
MetaSprite_14_5b84_END::
MetaSprite_14_5bad::
    INCBIN "gfx/unknown/metasprite_14/5bad.sprite.bin"
MetaSprite_14_5bad_END::
MetaSprite_14_5bd6::
    INCBIN "gfx/unknown/metasprite_14/5bd6.sprite.bin"
MetaSprite_14_5bd6_END::
MetaSprite_14_5beb::
    INCBIN "gfx/unknown/metasprite_14/5beb.sprite.bin"
MetaSprite_14_5beb_END::
MetaSprite_14_5c00::
    INCBIN "gfx/unknown/metasprite_14/5c00.sprite.bin"
MetaSprite_14_5c00_END::
MetaSprite_14_5c06::
    INCBIN "gfx/unknown/metasprite_14/5c06.sprite.bin"
MetaSprite_14_5c06_END::
MetaSprite_14_5c0c::
    INCBIN "gfx/unknown/metasprite_14/5c0c.sprite.bin"
MetaSprite_14_5c0c_END::
MetaSprite_14_5c21::
    INCBIN "gfx/unknown/metasprite_14/5c21.sprite.bin"
MetaSprite_14_5c21_END::
MetaSprite_14_5c36::
    INCBIN "gfx/unknown/metasprite_14/5c36.sprite.bin"
MetaSprite_14_5c36_END::
MetaSprite_14_5c3c::
    INCBIN "gfx/unknown/metasprite_14/5c3c.sprite.bin"
MetaSprite_14_5c3c_END::
MetaSprite_14_5c42::
    INCBIN "gfx/unknown/metasprite_14/5c42.sprite.bin"
MetaSprite_14_5c42_END::
MetaSprite_14_5c57::
    INCBIN "gfx/unknown/metasprite_14/5c57.sprite.bin"
MetaSprite_14_5c57_END::
MetaSprite_14_5c6c::
    INCBIN "gfx/unknown/metasprite_14/5c6c.sprite.bin"
MetaSprite_14_5c6c_END::
MetaSprite_14_5c72::
    INCBIN "gfx/unknown/metasprite_14/5c72.sprite.bin"
MetaSprite_14_5c72_END::
MetaSprite_14_5c78::
    INCBIN "gfx/unknown/metasprite_14/5c78.sprite.bin"
MetaSprite_14_5c78_END::
MetaSprite_14_5c88::
    INCBIN "gfx/unknown/metasprite_14/5c88.sprite.bin"
MetaSprite_14_5c88_END::
MetaSprite_14_5ca2::
    INCBIN "gfx/unknown/metasprite_14/5ca2.sprite.bin"
MetaSprite_14_5ca2_END::
MetaSprite_14_5cc1::
    INCBIN "gfx/unknown/metasprite_14/5cc1.sprite.bin"
MetaSprite_14_5cc1_END::
MetaSprite_14_5cdb::
    INCBIN "gfx/unknown/metasprite_14/5cdb.sprite.bin"
MetaSprite_14_5cdb_END::
MetaSprite_14_5ceb::
    INCBIN "gfx/unknown/metasprite_14/5ceb.sprite.bin"
MetaSprite_14_5ceb_END::
MetaSprite_14_5d00::
    INCBIN "gfx/unknown/metasprite_14/5d00.sprite.bin"
MetaSprite_14_5d00_END::
MetaSprite_14_5d24::
    INCBIN "gfx/unknown/metasprite_14/5d24.sprite.bin"
MetaSprite_14_5d24_END::
MetaSprite_14_5d57::
    INCBIN "gfx/unknown/metasprite_14/5d57.sprite.bin"
MetaSprite_14_5d57_END::
MetaSprite_14_5d7b::
    INCBIN "gfx/unknown/metasprite_14/5d7b.sprite.bin"
MetaSprite_14_5d7b_END::
MetaSprite_14_5d90::
    INCBIN "gfx/unknown/metasprite_14/5d90.sprite.bin"
MetaSprite_14_5d90_END::
MetaSprite_14_5da5::
    INCBIN "gfx/unknown/metasprite_14/5da5.sprite.bin"
MetaSprite_14_5da5_END::
MetaSprite_14_5dba::
    INCBIN "gfx/unknown/metasprite_14/5dba.sprite.bin"
MetaSprite_14_5dba_END::
MetaSprite_14_5de3::
    INCBIN "gfx/unknown/metasprite_14/5de3.sprite.bin"
MetaSprite_14_5de3_END::
MetaSprite_14_5dfd::
    INCBIN "gfx/unknown/metasprite_14/5dfd.sprite.bin"
MetaSprite_14_5dfd_END::
MetaSprite_14_5e26::
    INCBIN "gfx/unknown/metasprite_14/5e26.sprite.bin"
MetaSprite_14_5e26_END::
MetaSprite_14_5e3b::
    INCBIN "gfx/unknown/metasprite_14/5e3b.sprite.bin"
MetaSprite_14_5e3b_END::
MetaSprite_14_5e78::
    INCBIN "gfx/unknown/metasprite_14/5e78.sprite.bin"
MetaSprite_14_5e78_END::
MetaSprite_14_5e8d::
    INCBIN "gfx/unknown/metasprite_14/5e8d.sprite.bin"
MetaSprite_14_5e8d_END::
MetaSprite_14_5ea2::
    INCBIN "gfx/unknown/metasprite_14/5ea2.sprite.bin"
MetaSprite_14_5ea2_END::
MetaSprite_14_5edf::
    INCBIN "gfx/unknown/metasprite_14/5edf.sprite.bin"
MetaSprite_14_5edf_END::
MetaSprite_14_5f1c::
    INCBIN "gfx/unknown/metasprite_14/5f1c.sprite.bin"
MetaSprite_14_5f1c_END::
MetaSprite_14_5f31::
    INCBIN "gfx/unknown/metasprite_14/5f31.sprite.bin"
MetaSprite_14_5f31_END::
MetaSprite_14_5f46::
    INCBIN "gfx/unknown/metasprite_14/5f46.sprite.bin"
MetaSprite_14_5f46_END::
MetaSprite_14_5f6f::
    INCBIN "gfx/unknown/metasprite_14/5f6f.sprite.bin"
MetaSprite_14_5f6f_END::
MetaSprite_14_5fd4::
    INCBIN "gfx/unknown/metasprite_14/5fd4.sprite.bin"
MetaSprite_14_5fd4_END::
MetaSprite_14_6025::
    INCBIN "gfx/unknown/metasprite_14/6025.sprite.bin"
MetaSprite_14_6025_END::

SECTION "MetaSprite_15", ROMX[$4000], BANK[$15]
MetaSprite_15::
    dw MetaSprite_15_4178
    dw MetaSprite_15_418d
    dw MetaSprite_15_41a2
    dw MetaSprite_15_41a8
    dw MetaSprite_15_41ae
    dw MetaSprite_15_41c3
    dw MetaSprite_15_41d8
    dw MetaSprite_15_4201
    dw MetaSprite_15_4216
    dw MetaSprite_15_422b
    dw MetaSprite_15_4231
    dw MetaSprite_15_4237
    dw MetaSprite_15_425b
    dw MetaSprite_15_427f
    dw MetaSprite_15_4285
    dw MetaSprite_15_428b
    dw MetaSprite_15_42a0
    dw MetaSprite_15_42b5
    dw MetaSprite_15_42ca
    dw MetaSprite_15_42df
    dw MetaSprite_15_42f4
    dw MetaSprite_15_4309
    dw MetaSprite_15_431e
    dw MetaSprite_15_4324
    dw MetaSprite_15_432a
    dw MetaSprite_15_4344
    dw MetaSprite_15_435e
    dw MetaSprite_15_4378
    dw MetaSprite_15_4392
    dw MetaSprite_15_43a7
    dw MetaSprite_15_43f8
    dw MetaSprite_15_4449
    dw MetaSprite_15_445e
    dw MetaSprite_15_44af
    dw MetaSprite_15_4500
    dw MetaSprite_15_4515
    dw MetaSprite_15_452a
    dw MetaSprite_15_4553
    dw MetaSprite_15_4568
    dw MetaSprite_15_45b9
    dw MetaSprite_15_460a
    dw MetaSprite_15_461f
    dw MetaSprite_15_4634
    dw MetaSprite_15_465d
    dw MetaSprite_15_4663
    dw MetaSprite_15_4678
    dw MetaSprite_15_4697
    dw MetaSprite_15_46b6
    dw MetaSprite_15_46bc
    dw MetaSprite_15_46db
    dw MetaSprite_15_46fa
    dw MetaSprite_15_4719
    dw MetaSprite_15_4724
    dw MetaSprite_15_472f
    dw MetaSprite_15_473a
    dw MetaSprite_15_4745
    dw MetaSprite_15_4764
    dw MetaSprite_15_4774
    dw MetaSprite_15_4784
    dw MetaSprite_15_4794
    dw MetaSprite_15_47a4
    dw MetaSprite_15_47af
    dw MetaSprite_15_47bf
    dw MetaSprite_15_47d4
    dw MetaSprite_15_47ee
    dw MetaSprite_15_4808
    dw MetaSprite_15_481d
    dw MetaSprite_15_4828
    dw MetaSprite_15_4865
    dw MetaSprite_15_48a2
    dw MetaSprite_15_48a8
    dw MetaSprite_15_48b3
    dw MetaSprite_15_48c3
    dw MetaSprite_15_48d3
    dw MetaSprite_15_48e3
    dw MetaSprite_15_48f3
    dw MetaSprite_15_48fe
    dw MetaSprite_15_4904
    dw MetaSprite_15_4919
    dw MetaSprite_15_4924
    dw MetaSprite_15_494d
    dw MetaSprite_15_4962
    dw MetaSprite_15_4977
    dw MetaSprite_15_498c
    dw MetaSprite_15_4997
    dw MetaSprite_15_49bb
    dw MetaSprite_15_49df
    dw MetaSprite_15_49f4
    dw MetaSprite_15_4a09
    dw MetaSprite_15_4a1e
    dw MetaSprite_15_4a33
    dw MetaSprite_15_4a48
    dw MetaSprite_15_4ac1
    dw MetaSprite_15_4b3a
    dw MetaSprite_15_4b8b
    dw MetaSprite_15_4bdc
    dw MetaSprite_15_4c05
    dw MetaSprite_15_4c4c
    dw MetaSprite_15_4cb1
    dw MetaSprite_15_4d34
    dw MetaSprite_15_4dd5
    dw MetaSprite_15_4df4
    dw MetaSprite_15_4e31
    dw MetaSprite_15_4e8c
    dw MetaSprite_15_4f05
    dw MetaSprite_15_4f9c
    dw MetaSprite_15_5051
    dw MetaSprite_15_5098
    dw MetaSprite_15_50ad
    dw MetaSprite_15_50fe
    dw MetaSprite_15_5145
    dw MetaSprite_15_515a
    dw MetaSprite_15_516f
    dw MetaSprite_15_5184
    dw MetaSprite_15_51d5
    dw MetaSprite_15_5226
    dw MetaSprite_15_5245
    dw MetaSprite_15_526e
    dw MetaSprite_15_52ab
    dw MetaSprite_15_52c0
    dw MetaSprite_15_52c6
    dw MetaSprite_15_52cc
    dw MetaSprite_15_52d2
    dw MetaSprite_15_52d8
    dw MetaSprite_15_52de
    dw MetaSprite_15_52f3
    dw MetaSprite_15_531c
    dw MetaSprite_15_5345
    dw MetaSprite_15_5373
    dw MetaSprite_15_538d
    dw MetaSprite_15_53a2
    dw MetaSprite_15_53cb
    dw MetaSprite_15_53f4
    dw MetaSprite_15_5422
    dw MetaSprite_15_543c
    dw MetaSprite_15_5465
    dw MetaSprite_15_547f
    dw MetaSprite_15_5499
    dw MetaSprite_15_54b3
    dw MetaSprite_15_54cd
    dw MetaSprite_15_54e7
    dw MetaSprite_15_5501
    dw MetaSprite_15_5516
    dw MetaSprite_15_5535
    dw MetaSprite_15_554f
    dw MetaSprite_15_5569
    dw MetaSprite_15_5583
    dw MetaSprite_15_5598
    dw MetaSprite_15_55b7
    dw MetaSprite_15_55e0
    dw MetaSprite_15_5609
    dw MetaSprite_15_563c
    dw MetaSprite_15_565b
    dw MetaSprite_15_5675
    dw MetaSprite_15_568f
    dw MetaSprite_15_56a9
    dw MetaSprite_15_56d2
    dw MetaSprite_15_5705
    dw MetaSprite_15_5724
    dw MetaSprite_15_572f
    dw MetaSprite_15_5744
    dw MetaSprite_15_5763
    dw MetaSprite_15_578c
    dw MetaSprite_15_57bf
    dw MetaSprite_15_57fc
    dw MetaSprite_15_582f
    dw MetaSprite_15_5858
    dw MetaSprite_15_5877
    dw MetaSprite_15_588c
    dw MetaSprite_15_5897
    dw MetaSprite_15_58ac
    dw MetaSprite_15_58b7
    dw MetaSprite_15_58cc
    dw MetaSprite_15_58d7
    dw MetaSprite_15_58dd
    dw MetaSprite_15_58e8
    dw MetaSprite_15_58f8
    dw MetaSprite_15_590d
    dw MetaSprite_15_5927
    dw MetaSprite_15_5946
    dw MetaSprite_15_5960
    dw MetaSprite_15_5975
    dw MetaSprite_15_5985
    dw MetaSprite_15_5990
    dw MetaSprite_15_5996
    dw MetaSprite_15_59a1
    dw MetaSprite_15_59a7
    dw MetaSprite_15_59b2

SECTION "MetaSprite_15_4178", ROMX[$4178], BANK[$15]
MetaSprite_15_4178::
    INCBIN "gfx/unknown/metasprite_15/4178.sprite.bin"
MetaSprite_15_4178_END::
MetaSprite_15_418d::
    INCBIN "gfx/unknown/metasprite_15/418d.sprite.bin"
MetaSprite_15_418d_END::
MetaSprite_15_41a2::
    INCBIN "gfx/unknown/metasprite_15/41a2.sprite.bin"
MetaSprite_15_41a2_END::
MetaSprite_15_41a8::
    INCBIN "gfx/unknown/metasprite_15/41a8.sprite.bin"
MetaSprite_15_41a8_END::
MetaSprite_15_41ae::
    INCBIN "gfx/unknown/metasprite_15/41ae.sprite.bin"
MetaSprite_15_41ae_END::
MetaSprite_15_41c3::
    INCBIN "gfx/unknown/metasprite_15/41c3.sprite.bin"
MetaSprite_15_41c3_END::
MetaSprite_15_41d8::
    INCBIN "gfx/unknown/metasprite_15/41d8.sprite.bin"
MetaSprite_15_41d8_END::
MetaSprite_15_4201::
    INCBIN "gfx/unknown/metasprite_15/4201.sprite.bin"
MetaSprite_15_4201_END::
MetaSprite_15_4216::
    INCBIN "gfx/unknown/metasprite_15/4216.sprite.bin"
MetaSprite_15_4216_END::
MetaSprite_15_422b::
    INCBIN "gfx/unknown/metasprite_15/422b.sprite.bin"
MetaSprite_15_422b_END::
MetaSprite_15_4231::
    INCBIN "gfx/unknown/metasprite_15/4231.sprite.bin"
MetaSprite_15_4231_END::
MetaSprite_15_4237::
    INCBIN "gfx/unknown/metasprite_15/4237.sprite.bin"
MetaSprite_15_4237_END::
MetaSprite_15_425b::
    INCBIN "gfx/unknown/metasprite_15/425b.sprite.bin"
MetaSprite_15_425b_END::
MetaSprite_15_427f::
    INCBIN "gfx/unknown/metasprite_15/427f.sprite.bin"
MetaSprite_15_427f_END::
MetaSprite_15_4285::
    INCBIN "gfx/unknown/metasprite_15/4285.sprite.bin"
MetaSprite_15_4285_END::
MetaSprite_15_428b::
    INCBIN "gfx/unknown/metasprite_15/428b.sprite.bin"
MetaSprite_15_428b_END::
MetaSprite_15_42a0::
    INCBIN "gfx/unknown/metasprite_15/42a0.sprite.bin"
MetaSprite_15_42a0_END::
MetaSprite_15_42b5::
    INCBIN "gfx/unknown/metasprite_15/42b5.sprite.bin"
MetaSprite_15_42b5_END::
MetaSprite_15_42ca::
    INCBIN "gfx/unknown/metasprite_15/42ca.sprite.bin"
MetaSprite_15_42ca_END::
MetaSprite_15_42df::
    INCBIN "gfx/unknown/metasprite_15/42df.sprite.bin"
MetaSprite_15_42df_END::
MetaSprite_15_42f4::
    INCBIN "gfx/unknown/metasprite_15/42f4.sprite.bin"
MetaSprite_15_42f4_END::
MetaSprite_15_4309::
    INCBIN "gfx/unknown/metasprite_15/4309.sprite.bin"
MetaSprite_15_4309_END::
MetaSprite_15_431e::
    INCBIN "gfx/unknown/metasprite_15/431e.sprite.bin"
MetaSprite_15_431e_END::
MetaSprite_15_4324::
    INCBIN "gfx/unknown/metasprite_15/4324.sprite.bin"
MetaSprite_15_4324_END::
MetaSprite_15_432a::
    INCBIN "gfx/unknown/metasprite_15/432a.sprite.bin"
MetaSprite_15_432a_END::
MetaSprite_15_4344::
    INCBIN "gfx/unknown/metasprite_15/4344.sprite.bin"
MetaSprite_15_4344_END::
MetaSprite_15_435e::
    INCBIN "gfx/unknown/metasprite_15/435e.sprite.bin"
MetaSprite_15_435e_END::
MetaSprite_15_4378::
    INCBIN "gfx/unknown/metasprite_15/4378.sprite.bin"
MetaSprite_15_4378_END::
MetaSprite_15_4392::
    INCBIN "gfx/unknown/metasprite_15/4392.sprite.bin"
MetaSprite_15_4392_END::
MetaSprite_15_43a7::
    INCBIN "gfx/unknown/metasprite_15/43a7.sprite.bin"
MetaSprite_15_43a7_END::
MetaSprite_15_43f8::
    INCBIN "gfx/unknown/metasprite_15/43f8.sprite.bin"
MetaSprite_15_43f8_END::
MetaSprite_15_4449::
    INCBIN "gfx/unknown/metasprite_15/4449.sprite.bin"
MetaSprite_15_4449_END::
MetaSprite_15_445e::
    INCBIN "gfx/unknown/metasprite_15/445e.sprite.bin"
MetaSprite_15_445e_END::
MetaSprite_15_44af::
    INCBIN "gfx/unknown/metasprite_15/44af.sprite.bin"
MetaSprite_15_44af_END::
MetaSprite_15_4500::
    INCBIN "gfx/unknown/metasprite_15/4500.sprite.bin"
MetaSprite_15_4500_END::
MetaSprite_15_4515::
    INCBIN "gfx/unknown/metasprite_15/4515.sprite.bin"
MetaSprite_15_4515_END::
MetaSprite_15_452a::
    INCBIN "gfx/unknown/metasprite_15/452a.sprite.bin"
MetaSprite_15_452a_END::
MetaSprite_15_4553::
    INCBIN "gfx/unknown/metasprite_15/4553.sprite.bin"
MetaSprite_15_4553_END::
MetaSprite_15_4568::
    INCBIN "gfx/unknown/metasprite_15/4568.sprite.bin"
MetaSprite_15_4568_END::
MetaSprite_15_45b9::
    INCBIN "gfx/unknown/metasprite_15/45b9.sprite.bin"
MetaSprite_15_45b9_END::
MetaSprite_15_460a::
    INCBIN "gfx/unknown/metasprite_15/460a.sprite.bin"
MetaSprite_15_460a_END::
MetaSprite_15_461f::
    INCBIN "gfx/unknown/metasprite_15/461f.sprite.bin"
MetaSprite_15_461f_END::
MetaSprite_15_4634::
    INCBIN "gfx/unknown/metasprite_15/4634.sprite.bin"
MetaSprite_15_4634_END::
MetaSprite_15_465d::
    INCBIN "gfx/unknown/metasprite_15/465d.sprite.bin"
MetaSprite_15_465d_END::
MetaSprite_15_4663::
    INCBIN "gfx/unknown/metasprite_15/4663.sprite.bin"
MetaSprite_15_4663_END::
MetaSprite_15_4678::
    INCBIN "gfx/unknown/metasprite_15/4678.sprite.bin"
MetaSprite_15_4678_END::
MetaSprite_15_4697::
    INCBIN "gfx/unknown/metasprite_15/4697.sprite.bin"
MetaSprite_15_4697_END::
MetaSprite_15_46b6::
    INCBIN "gfx/unknown/metasprite_15/46b6.sprite.bin"
MetaSprite_15_46b6_END::
MetaSprite_15_46bc::
    INCBIN "gfx/unknown/metasprite_15/46bc.sprite.bin"
MetaSprite_15_46bc_END::
MetaSprite_15_46db::
    INCBIN "gfx/unknown/metasprite_15/46db.sprite.bin"
MetaSprite_15_46db_END::
MetaSprite_15_46fa::
    INCBIN "gfx/unknown/metasprite_15/46fa.sprite.bin"
MetaSprite_15_46fa_END::
MetaSprite_15_4719::
    INCBIN "gfx/unknown/metasprite_15/4719.sprite.bin"
MetaSprite_15_4719_END::
MetaSprite_15_4724::
    INCBIN "gfx/unknown/metasprite_15/4724.sprite.bin"
MetaSprite_15_4724_END::
MetaSprite_15_472f::
    INCBIN "gfx/unknown/metasprite_15/472f.sprite.bin"
MetaSprite_15_472f_END::
MetaSprite_15_473a::
    INCBIN "gfx/unknown/metasprite_15/473a.sprite.bin"
MetaSprite_15_473a_END::
MetaSprite_15_4745::
    INCBIN "gfx/unknown/metasprite_15/4745.sprite.bin"
MetaSprite_15_4745_END::
MetaSprite_15_4764::
    INCBIN "gfx/unknown/metasprite_15/4764.sprite.bin"
MetaSprite_15_4764_END::
MetaSprite_15_4774::
    INCBIN "gfx/unknown/metasprite_15/4774.sprite.bin"
MetaSprite_15_4774_END::
MetaSprite_15_4784::
    INCBIN "gfx/unknown/metasprite_15/4784.sprite.bin"
MetaSprite_15_4784_END::
MetaSprite_15_4794::
    INCBIN "gfx/unknown/metasprite_15/4794.sprite.bin"
MetaSprite_15_4794_END::
MetaSprite_15_47a4::
    INCBIN "gfx/unknown/metasprite_15/47a4.sprite.bin"
MetaSprite_15_47a4_END::
MetaSprite_15_47af::
    INCBIN "gfx/unknown/metasprite_15/47af.sprite.bin"
MetaSprite_15_47af_END::
MetaSprite_15_47bf::
    INCBIN "gfx/unknown/metasprite_15/47bf.sprite.bin"
MetaSprite_15_47bf_END::
MetaSprite_15_47d4::
    INCBIN "gfx/unknown/metasprite_15/47d4.sprite.bin"
MetaSprite_15_47d4_END::
MetaSprite_15_47ee::
    INCBIN "gfx/unknown/metasprite_15/47ee.sprite.bin"
MetaSprite_15_47ee_END::
MetaSprite_15_4808::
    INCBIN "gfx/unknown/metasprite_15/4808.sprite.bin"
MetaSprite_15_4808_END::
MetaSprite_15_481d::
    INCBIN "gfx/unknown/metasprite_15/481d.sprite.bin"
MetaSprite_15_481d_END::
MetaSprite_15_4828::
    INCBIN "gfx/unknown/metasprite_15/4828.sprite.bin"
MetaSprite_15_4828_END::
MetaSprite_15_4865::
    INCBIN "gfx/unknown/metasprite_15/4865.sprite.bin"
MetaSprite_15_4865_END::
MetaSprite_15_48a2::
    INCBIN "gfx/unknown/metasprite_15/48a2.sprite.bin"
MetaSprite_15_48a2_END::
MetaSprite_15_48a8::
    INCBIN "gfx/unknown/metasprite_15/48a8.sprite.bin"
MetaSprite_15_48a8_END::
MetaSprite_15_48b3::
    INCBIN "gfx/unknown/metasprite_15/48b3.sprite.bin"
MetaSprite_15_48b3_END::
MetaSprite_15_48c3::
    INCBIN "gfx/unknown/metasprite_15/48c3.sprite.bin"
MetaSprite_15_48c3_END::
MetaSprite_15_48d3::
    INCBIN "gfx/unknown/metasprite_15/48d3.sprite.bin"
MetaSprite_15_48d3_END::
MetaSprite_15_48e3::
    INCBIN "gfx/unknown/metasprite_15/48e3.sprite.bin"
MetaSprite_15_48e3_END::
MetaSprite_15_48f3::
    INCBIN "gfx/unknown/metasprite_15/48f3.sprite.bin"
MetaSprite_15_48f3_END::
MetaSprite_15_48fe::
    INCBIN "gfx/unknown/metasprite_15/48fe.sprite.bin"
MetaSprite_15_48fe_END::
MetaSprite_15_4904::
    INCBIN "gfx/unknown/metasprite_15/4904.sprite.bin"
MetaSprite_15_4904_END::
MetaSprite_15_4919::
    INCBIN "gfx/unknown/metasprite_15/4919.sprite.bin"
MetaSprite_15_4919_END::
MetaSprite_15_4924::
    INCBIN "gfx/unknown/metasprite_15/4924.sprite.bin"
MetaSprite_15_4924_END::
MetaSprite_15_494d::
    INCBIN "gfx/unknown/metasprite_15/494d.sprite.bin"
MetaSprite_15_494d_END::
MetaSprite_15_4962::
    INCBIN "gfx/unknown/metasprite_15/4962.sprite.bin"
MetaSprite_15_4962_END::
MetaSprite_15_4977::
    INCBIN "gfx/unknown/metasprite_15/4977.sprite.bin"
MetaSprite_15_4977_END::
MetaSprite_15_498c::
    INCBIN "gfx/unknown/metasprite_15/498c.sprite.bin"
MetaSprite_15_498c_END::
MetaSprite_15_4997::
    INCBIN "gfx/unknown/metasprite_15/4997.sprite.bin"
MetaSprite_15_4997_END::
MetaSprite_15_49bb::
    INCBIN "gfx/unknown/metasprite_15/49bb.sprite.bin"
MetaSprite_15_49bb_END::
MetaSprite_15_49df::
    INCBIN "gfx/unknown/metasprite_15/49df.sprite.bin"
MetaSprite_15_49df_END::
MetaSprite_15_49f4::
    INCBIN "gfx/unknown/metasprite_15/49f4.sprite.bin"
MetaSprite_15_49f4_END::
MetaSprite_15_4a09::
    INCBIN "gfx/unknown/metasprite_15/4a09.sprite.bin"
MetaSprite_15_4a09_END::
MetaSprite_15_4a1e::
    INCBIN "gfx/unknown/metasprite_15/4a1e.sprite.bin"
MetaSprite_15_4a1e_END::
MetaSprite_15_4a33::
    INCBIN "gfx/unknown/metasprite_15/4a33.sprite.bin"
MetaSprite_15_4a33_END::
MetaSprite_15_4a48::
    INCBIN "gfx/unknown/metasprite_15/4a48.sprite.bin"
MetaSprite_15_4a48_END::
MetaSprite_15_4ac1::
    INCBIN "gfx/unknown/metasprite_15/4ac1.sprite.bin"
MetaSprite_15_4ac1_END::
MetaSprite_15_4b3a::
    INCBIN "gfx/unknown/metasprite_15/4b3a.sprite.bin"
MetaSprite_15_4b3a_END::
MetaSprite_15_4b8b::
    INCBIN "gfx/unknown/metasprite_15/4b8b.sprite.bin"
MetaSprite_15_4b8b_END::
MetaSprite_15_4bdc::
    INCBIN "gfx/unknown/metasprite_15/4bdc.sprite.bin"
MetaSprite_15_4bdc_END::
MetaSprite_15_4c05::
    INCBIN "gfx/unknown/metasprite_15/4c05.sprite.bin"
MetaSprite_15_4c05_END::
MetaSprite_15_4c4c::
    INCBIN "gfx/unknown/metasprite_15/4c4c.sprite.bin"
MetaSprite_15_4c4c_END::
MetaSprite_15_4cb1::
    INCBIN "gfx/unknown/metasprite_15/4cb1.sprite.bin"
MetaSprite_15_4cb1_END::
MetaSprite_15_4d34::
    INCBIN "gfx/unknown/metasprite_15/4d34.sprite.bin"
MetaSprite_15_4d34_END::
MetaSprite_15_4dd5::
    INCBIN "gfx/unknown/metasprite_15/4dd5.sprite.bin"
MetaSprite_15_4dd5_END::
MetaSprite_15_4df4::
    INCBIN "gfx/unknown/metasprite_15/4df4.sprite.bin"
MetaSprite_15_4df4_END::
MetaSprite_15_4e31::
    INCBIN "gfx/unknown/metasprite_15/4e31.sprite.bin"
MetaSprite_15_4e31_END::
MetaSprite_15_4e8c::
    INCBIN "gfx/unknown/metasprite_15/4e8c.sprite.bin"
MetaSprite_15_4e8c_END::
MetaSprite_15_4f05::
    INCBIN "gfx/unknown/metasprite_15/4f05.sprite.bin"
MetaSprite_15_4f05_END::
MetaSprite_15_4f9c::
    INCBIN "gfx/unknown/metasprite_15/4f9c.sprite.bin"
MetaSprite_15_4f9c_END::
MetaSprite_15_5051::
    INCBIN "gfx/unknown/metasprite_15/5051.sprite.bin"
MetaSprite_15_5051_END::
MetaSprite_15_5098::
    INCBIN "gfx/unknown/metasprite_15/5098.sprite.bin"
MetaSprite_15_5098_END::
MetaSprite_15_50ad::
    INCBIN "gfx/unknown/metasprite_15/50ad.sprite.bin"
MetaSprite_15_50ad_END::
MetaSprite_15_50fe::
    INCBIN "gfx/unknown/metasprite_15/50fe.sprite.bin"
MetaSprite_15_50fe_END::
MetaSprite_15_5145::
    INCBIN "gfx/unknown/metasprite_15/5145.sprite.bin"
MetaSprite_15_5145_END::
MetaSprite_15_515a::
    INCBIN "gfx/unknown/metasprite_15/515a.sprite.bin"
MetaSprite_15_515a_END::
MetaSprite_15_516f::
    INCBIN "gfx/unknown/metasprite_15/516f.sprite.bin"
MetaSprite_15_516f_END::
MetaSprite_15_5184::
    INCBIN "gfx/unknown/metasprite_15/5184.sprite.bin"
MetaSprite_15_5184_END::
MetaSprite_15_51d5::
    INCBIN "gfx/unknown/metasprite_15/51d5.sprite.bin"
MetaSprite_15_51d5_END::
MetaSprite_15_5226::
    INCBIN "gfx/unknown/metasprite_15/5226.sprite.bin"
MetaSprite_15_5226_END::
MetaSprite_15_5245::
    INCBIN "gfx/unknown/metasprite_15/5245.sprite.bin"
MetaSprite_15_5245_END::
MetaSprite_15_526e::
    INCBIN "gfx/unknown/metasprite_15/526e.sprite.bin"
MetaSprite_15_526e_END::
MetaSprite_15_52ab::
    INCBIN "gfx/unknown/metasprite_15/52ab.sprite.bin"
MetaSprite_15_52ab_END::
MetaSprite_15_52c0::
    INCBIN "gfx/unknown/metasprite_15/52c0.sprite.bin"
MetaSprite_15_52c0_END::
MetaSprite_15_52c6::
    INCBIN "gfx/unknown/metasprite_15/52c6.sprite.bin"
MetaSprite_15_52c6_END::
MetaSprite_15_52cc::
    INCBIN "gfx/unknown/metasprite_15/52cc.sprite.bin"
MetaSprite_15_52cc_END::
MetaSprite_15_52d2::
    INCBIN "gfx/unknown/metasprite_15/52d2.sprite.bin"
MetaSprite_15_52d2_END::
MetaSprite_15_52d8::
    INCBIN "gfx/unknown/metasprite_15/52d8.sprite.bin"
MetaSprite_15_52d8_END::
MetaSprite_15_52de::
    INCBIN "gfx/unknown/metasprite_15/52de.sprite.bin"
MetaSprite_15_52de_END::
MetaSprite_15_52f3::
    INCBIN "gfx/unknown/metasprite_15/52f3.sprite.bin"
MetaSprite_15_52f3_END::
MetaSprite_15_531c::
    INCBIN "gfx/unknown/metasprite_15/531c.sprite.bin"
MetaSprite_15_531c_END::
MetaSprite_15_5345::
    INCBIN "gfx/unknown/metasprite_15/5345.sprite.bin"
MetaSprite_15_5345_END::
MetaSprite_15_5373::
    INCBIN "gfx/unknown/metasprite_15/5373.sprite.bin"
MetaSprite_15_5373_END::
MetaSprite_15_538d::
    INCBIN "gfx/unknown/metasprite_15/538d.sprite.bin"
MetaSprite_15_538d_END::
MetaSprite_15_53a2::
    INCBIN "gfx/unknown/metasprite_15/53a2.sprite.bin"
MetaSprite_15_53a2_END::
MetaSprite_15_53cb::
    INCBIN "gfx/unknown/metasprite_15/53cb.sprite.bin"
MetaSprite_15_53cb_END::
MetaSprite_15_53f4::
    INCBIN "gfx/unknown/metasprite_15/53f4.sprite.bin"
MetaSprite_15_53f4_END::
MetaSprite_15_5422::
    INCBIN "gfx/unknown/metasprite_15/5422.sprite.bin"
MetaSprite_15_5422_END::
MetaSprite_15_543c::
    INCBIN "gfx/unknown/metasprite_15/543c.sprite.bin"
MetaSprite_15_543c_END::
MetaSprite_15_5465::
    INCBIN "gfx/unknown/metasprite_15/5465.sprite.bin"
MetaSprite_15_5465_END::
MetaSprite_15_547f::
    INCBIN "gfx/unknown/metasprite_15/547f.sprite.bin"
MetaSprite_15_547f_END::
MetaSprite_15_5499::
    INCBIN "gfx/unknown/metasprite_15/5499.sprite.bin"
MetaSprite_15_5499_END::
MetaSprite_15_54b3::
    INCBIN "gfx/unknown/metasprite_15/54b3.sprite.bin"
MetaSprite_15_54b3_END::
MetaSprite_15_54cd::
    INCBIN "gfx/unknown/metasprite_15/54cd.sprite.bin"
MetaSprite_15_54cd_END::
MetaSprite_15_54e7::
    INCBIN "gfx/unknown/metasprite_15/54e7.sprite.bin"
MetaSprite_15_54e7_END::
MetaSprite_15_5501::
    INCBIN "gfx/unknown/metasprite_15/5501.sprite.bin"
MetaSprite_15_5501_END::
MetaSprite_15_5516::
    INCBIN "gfx/unknown/metasprite_15/5516.sprite.bin"
MetaSprite_15_5516_END::
MetaSprite_15_5535::
    INCBIN "gfx/unknown/metasprite_15/5535.sprite.bin"
MetaSprite_15_5535_END::
MetaSprite_15_554f::
    INCBIN "gfx/unknown/metasprite_15/554f.sprite.bin"
MetaSprite_15_554f_END::
MetaSprite_15_5569::
    INCBIN "gfx/unknown/metasprite_15/5569.sprite.bin"
MetaSprite_15_5569_END::
MetaSprite_15_5583::
    INCBIN "gfx/unknown/metasprite_15/5583.sprite.bin"
MetaSprite_15_5583_END::
MetaSprite_15_5598::
    INCBIN "gfx/unknown/metasprite_15/5598.sprite.bin"
MetaSprite_15_5598_END::
MetaSprite_15_55b7::
    INCBIN "gfx/unknown/metasprite_15/55b7.sprite.bin"
MetaSprite_15_55b7_END::
MetaSprite_15_55e0::
    INCBIN "gfx/unknown/metasprite_15/55e0.sprite.bin"
MetaSprite_15_55e0_END::
MetaSprite_15_5609::
    INCBIN "gfx/unknown/metasprite_15/5609.sprite.bin"
MetaSprite_15_5609_END::
MetaSprite_15_563c::
    INCBIN "gfx/unknown/metasprite_15/563c.sprite.bin"
MetaSprite_15_563c_END::
MetaSprite_15_565b::
    INCBIN "gfx/unknown/metasprite_15/565b.sprite.bin"
MetaSprite_15_565b_END::
MetaSprite_15_5675::
    INCBIN "gfx/unknown/metasprite_15/5675.sprite.bin"
MetaSprite_15_5675_END::
MetaSprite_15_568f::
    INCBIN "gfx/unknown/metasprite_15/568f.sprite.bin"
MetaSprite_15_568f_END::
MetaSprite_15_56a9::
    INCBIN "gfx/unknown/metasprite_15/56a9.sprite.bin"
MetaSprite_15_56a9_END::
MetaSprite_15_56d2::
    INCBIN "gfx/unknown/metasprite_15/56d2.sprite.bin"
MetaSprite_15_56d2_END::
MetaSprite_15_5705::
    INCBIN "gfx/unknown/metasprite_15/5705.sprite.bin"
MetaSprite_15_5705_END::
MetaSprite_15_5724::
    INCBIN "gfx/unknown/metasprite_15/5724.sprite.bin"
MetaSprite_15_5724_END::
MetaSprite_15_572f::
    INCBIN "gfx/unknown/metasprite_15/572f.sprite.bin"
MetaSprite_15_572f_END::
MetaSprite_15_5744::
    INCBIN "gfx/unknown/metasprite_15/5744.sprite.bin"
MetaSprite_15_5744_END::
MetaSprite_15_5763::
    INCBIN "gfx/unknown/metasprite_15/5763.sprite.bin"
MetaSprite_15_5763_END::
MetaSprite_15_578c::
    INCBIN "gfx/unknown/metasprite_15/578c.sprite.bin"
MetaSprite_15_578c_END::
MetaSprite_15_57bf::
    INCBIN "gfx/unknown/metasprite_15/57bf.sprite.bin"
MetaSprite_15_57bf_END::
MetaSprite_15_57fc::
    INCBIN "gfx/unknown/metasprite_15/57fc.sprite.bin"
MetaSprite_15_57fc_END::
MetaSprite_15_582f::
    INCBIN "gfx/unknown/metasprite_15/582f.sprite.bin"
MetaSprite_15_582f_END::
MetaSprite_15_5858::
    INCBIN "gfx/unknown/metasprite_15/5858.sprite.bin"
MetaSprite_15_5858_END::
MetaSprite_15_5877::
    INCBIN "gfx/unknown/metasprite_15/5877.sprite.bin"
MetaSprite_15_5877_END::
MetaSprite_15_588c::
    INCBIN "gfx/unknown/metasprite_15/588c.sprite.bin"
MetaSprite_15_588c_END::
MetaSprite_15_5897::
    INCBIN "gfx/unknown/metasprite_15/5897.sprite.bin"
MetaSprite_15_5897_END::
MetaSprite_15_58ac::
    INCBIN "gfx/unknown/metasprite_15/58ac.sprite.bin"
MetaSprite_15_58ac_END::
MetaSprite_15_58b7::
    INCBIN "gfx/unknown/metasprite_15/58b7.sprite.bin"
MetaSprite_15_58b7_END::
MetaSprite_15_58cc::
    INCBIN "gfx/unknown/metasprite_15/58cc.sprite.bin"
MetaSprite_15_58cc_END::
MetaSprite_15_58d7::
    INCBIN "gfx/unknown/metasprite_15/58d7.sprite.bin"
MetaSprite_15_58d7_END::
MetaSprite_15_58dd::
    INCBIN "gfx/unknown/metasprite_15/58dd.sprite.bin"
MetaSprite_15_58dd_END::
MetaSprite_15_58e8::
    INCBIN "gfx/unknown/metasprite_15/58e8.sprite.bin"
MetaSprite_15_58e8_END::
MetaSprite_15_58f8::
    INCBIN "gfx/unknown/metasprite_15/58f8.sprite.bin"
MetaSprite_15_58f8_END::
MetaSprite_15_590d::
    INCBIN "gfx/unknown/metasprite_15/590d.sprite.bin"
MetaSprite_15_590d_END::
MetaSprite_15_5927::
    INCBIN "gfx/unknown/metasprite_15/5927.sprite.bin"
MetaSprite_15_5927_END::
MetaSprite_15_5946::
    INCBIN "gfx/unknown/metasprite_15/5946.sprite.bin"
MetaSprite_15_5946_END::
MetaSprite_15_5960::
    INCBIN "gfx/unknown/metasprite_15/5960.sprite.bin"
MetaSprite_15_5960_END::
MetaSprite_15_5975::
    INCBIN "gfx/unknown/metasprite_15/5975.sprite.bin"
MetaSprite_15_5975_END::
MetaSprite_15_5985::
    INCBIN "gfx/unknown/metasprite_15/5985.sprite.bin"
MetaSprite_15_5985_END::
MetaSprite_15_5990::
    INCBIN "gfx/unknown/metasprite_15/5990.sprite.bin"
MetaSprite_15_5990_END::
MetaSprite_15_5996::
    INCBIN "gfx/unknown/metasprite_15/5996.sprite.bin"
MetaSprite_15_5996_END::
MetaSprite_15_59a1::
    INCBIN "gfx/unknown/metasprite_15/59a1.sprite.bin"
MetaSprite_15_59a1_END::
MetaSprite_15_59a7::
    INCBIN "gfx/unknown/metasprite_15/59a7.sprite.bin"
MetaSprite_15_59a7_END::
MetaSprite_15_59b2::
    INCBIN "gfx/unknown/metasprite_15/59b2.sprite.bin"
MetaSprite_15_59b2_END::

SECTION "MetaSprite_16", ROMX[$4000], BANK[$16]
MetaSprite_16::
    dw MetaSprite_16_4162
    dw MetaSprite_16_4168
    dw MetaSprite_16_417d
    dw MetaSprite_16_41a1
    dw MetaSprite_16_41b6
    dw MetaSprite_16_41e4
    dw MetaSprite_16_420d
    dw MetaSprite_16_424a
    dw MetaSprite_16_429b
    dw MetaSprite_16_4300
    dw MetaSprite_16_4365
    dw MetaSprite_16_43b6
    dw MetaSprite_16_43f3
    dw MetaSprite_16_441c
    dw MetaSprite_16_4445
    dw MetaSprite_16_4482
    dw MetaSprite_16_44d3
    dw MetaSprite_16_4538
    dw MetaSprite_16_459d
    dw MetaSprite_16_45ee
    dw MetaSprite_16_462b
    dw MetaSprite_16_4654
    dw MetaSprite_16_467d
    dw MetaSprite_16_46ba
    dw MetaSprite_16_470b
    dw MetaSprite_16_4770
    dw MetaSprite_16_47d5
    dw MetaSprite_16_4826
    dw MetaSprite_16_4863
    dw MetaSprite_16_488c
    dw MetaSprite_16_4897
    dw MetaSprite_16_48c0
    dw MetaSprite_16_48e9
    dw MetaSprite_16_4962
    dw MetaSprite_16_49db
    dw MetaSprite_16_49e6
    dw MetaSprite_16_4a0f
    dw MetaSprite_16_4a38
    dw MetaSprite_16_4a6b
    dw MetaSprite_16_4a9e
    dw MetaSprite_16_4ab3
    dw MetaSprite_16_4ac8
    dw MetaSprite_16_4add
    dw MetaSprite_16_4af2
    dw MetaSprite_16_4b07
    dw MetaSprite_16_4b3a
    dw MetaSprite_16_4b6d
    dw MetaSprite_16_4b82
    dw MetaSprite_16_4b97
    dw MetaSprite_16_4bac
    dw MetaSprite_16_4bb7
    dw MetaSprite_16_4be0
    dw MetaSprite_16_4c09
    dw MetaSprite_16_4c3c
    dw MetaSprite_16_4c6f
    dw MetaSprite_16_4c84
    dw MetaSprite_16_4cad
    dw MetaSprite_16_4cd6
    dw MetaSprite_16_4cff
    dw MetaSprite_16_4d28
    dw MetaSprite_16_4d2e
    dw MetaSprite_16_4d43
    dw MetaSprite_16_4d58
    dw MetaSprite_16_4d6d
    dw MetaSprite_16_4d96
    dw MetaSprite_16_4dab
    dw MetaSprite_16_4dc0
    dw MetaSprite_16_4dd5
    dw MetaSprite_16_4dea
    dw MetaSprite_16_4e13
    dw MetaSprite_16_4e19
    dw MetaSprite_16_4e2e
    dw MetaSprite_16_4e43
    dw MetaSprite_16_4e6c
    dw MetaSprite_16_4e9f
    dw MetaSprite_16_4ed2
    dw MetaSprite_16_4ee7
    dw MetaSprite_16_4efc
    dw MetaSprite_16_4f07
    dw MetaSprite_16_4f0d
    dw MetaSprite_16_4f1d
    dw MetaSprite_16_4f50
    dw MetaSprite_16_4f5b
    dw MetaSprite_16_4f7a
    dw MetaSprite_16_4fad
    dw MetaSprite_16_4fe0
    dw MetaSprite_16_5013
    dw MetaSprite_16_5028
    dw MetaSprite_16_503d
    dw MetaSprite_16_5052
    dw MetaSprite_16_5067
    dw MetaSprite_16_509a
    dw MetaSprite_16_50cd
    dw MetaSprite_16_50d3
    dw MetaSprite_16_5106
    dw MetaSprite_16_5139
    dw MetaSprite_16_5162
    dw MetaSprite_16_519f
    dw MetaSprite_16_51f0
    dw MetaSprite_16_5255
    dw MetaSprite_16_52ba
    dw MetaSprite_16_530b
    dw MetaSprite_16_5348
    dw MetaSprite_16_5371
    dw MetaSprite_16_5386
    dw MetaSprite_16_539b
    dw MetaSprite_16_53b0
    dw MetaSprite_16_53c5
    dw MetaSprite_16_53ee
    dw MetaSprite_16_542b
    dw MetaSprite_16_547c
    dw MetaSprite_16_54e1
    dw MetaSprite_16_5546
    dw MetaSprite_16_5597
    dw MetaSprite_16_55d4
    dw MetaSprite_16_55fd
    dw MetaSprite_16_5612
    dw MetaSprite_16_563b
    dw MetaSprite_16_5664
    dw MetaSprite_16_568d
    dw MetaSprite_16_56a2
    dw MetaSprite_16_571b
    dw MetaSprite_16_5794
    dw MetaSprite_16_57c7
    dw MetaSprite_16_57dc
    dw MetaSprite_16_57f1
    dw MetaSprite_16_5806
    dw MetaSprite_16_581b
    dw MetaSprite_16_5867
    dw MetaSprite_16_58e0
    dw MetaSprite_16_5959
    dw MetaSprite_16_596e
    dw MetaSprite_16_5983
    dw MetaSprite_16_59fc
    dw MetaSprite_16_5a75
    dw MetaSprite_16_5a8a
    dw MetaSprite_16_5b03
    dw MetaSprite_16_5b7c
    dw MetaSprite_16_5b91
    dw MetaSprite_16_5bba
    dw MetaSprite_16_5be3
    dw MetaSprite_16_5c0c
    dw MetaSprite_16_5c35
    dw MetaSprite_16_5c5e
    dw MetaSprite_16_5c9b
    dw MetaSprite_16_5cec
    dw MetaSprite_16_5d51
    dw MetaSprite_16_5db6
    dw MetaSprite_16_5e07
    dw MetaSprite_16_5e44
    dw MetaSprite_16_5e6d
    dw MetaSprite_16_5e82
    dw MetaSprite_16_5e97
    dw MetaSprite_16_5eb6
    dw MetaSprite_16_5efd
    dw MetaSprite_16_5f03
    dw MetaSprite_16_5f0e
    dw MetaSprite_16_5f1e
    dw MetaSprite_16_5f33
    dw MetaSprite_16_5f4d
    dw MetaSprite_16_5f53
    dw MetaSprite_16_5f72
    dw MetaSprite_16_5f78
    dw MetaSprite_16_5f8d
    dw MetaSprite_16_5fa2
    dw MetaSprite_16_5fc6
    dw MetaSprite_16_5fcc
    dw MetaSprite_16_5fd2
    dw MetaSprite_16_5fd8
    dw MetaSprite_16_5fde
    dw MetaSprite_16_5fe4
    dw MetaSprite_16_5fea
    dw MetaSprite_16_5ff0
    dw MetaSprite_16_5ffb
    dw MetaSprite_16_6024
    dw MetaSprite_16_6039
    dw MetaSprite_16_604e

SECTION "MetaSprite_16_4162", ROMX[$4162], BANK[$16]
MetaSprite_16_4162::
    INCBIN "gfx/unknown/metasprite_16/4162.sprite.bin"
MetaSprite_16_4162_END::
MetaSprite_16_4168::
    INCBIN "gfx/unknown/metasprite_16/4168.sprite.bin"
MetaSprite_16_4168_END::
MetaSprite_16_417d::
    INCBIN "gfx/unknown/metasprite_16/417d.sprite.bin"
MetaSprite_16_417d_END::
MetaSprite_16_41a1::
    INCBIN "gfx/unknown/metasprite_16/41a1.sprite.bin"
MetaSprite_16_41a1_END::
MetaSprite_16_41b6::
    INCBIN "gfx/unknown/metasprite_16/41b6.sprite.bin"
MetaSprite_16_41b6_END::
MetaSprite_16_41e4::
    INCBIN "gfx/unknown/metasprite_16/41e4.sprite.bin"
MetaSprite_16_41e4_END::
MetaSprite_16_420d::
    INCBIN "gfx/unknown/metasprite_16/420d.sprite.bin"
MetaSprite_16_420d_END::
MetaSprite_16_424a::
    INCBIN "gfx/unknown/metasprite_16/424a.sprite.bin"
MetaSprite_16_424a_END::
MetaSprite_16_429b::
    INCBIN "gfx/unknown/metasprite_16/429b.sprite.bin"
MetaSprite_16_429b_END::
MetaSprite_16_4300::
    INCBIN "gfx/unknown/metasprite_16/4300.sprite.bin"
MetaSprite_16_4300_END::
MetaSprite_16_4365::
    INCBIN "gfx/unknown/metasprite_16/4365.sprite.bin"
MetaSprite_16_4365_END::
MetaSprite_16_43b6::
    INCBIN "gfx/unknown/metasprite_16/43b6.sprite.bin"
MetaSprite_16_43b6_END::
MetaSprite_16_43f3::
    INCBIN "gfx/unknown/metasprite_16/43f3.sprite.bin"
MetaSprite_16_43f3_END::
MetaSprite_16_441c::
    INCBIN "gfx/unknown/metasprite_16/441c.sprite.bin"
MetaSprite_16_441c_END::
MetaSprite_16_4445::
    INCBIN "gfx/unknown/metasprite_16/4445.sprite.bin"
MetaSprite_16_4445_END::
MetaSprite_16_4482::
    INCBIN "gfx/unknown/metasprite_16/4482.sprite.bin"
MetaSprite_16_4482_END::
MetaSprite_16_44d3::
    INCBIN "gfx/unknown/metasprite_16/44d3.sprite.bin"
MetaSprite_16_44d3_END::
MetaSprite_16_4538::
    INCBIN "gfx/unknown/metasprite_16/4538.sprite.bin"
MetaSprite_16_4538_END::
MetaSprite_16_459d::
    INCBIN "gfx/unknown/metasprite_16/459d.sprite.bin"
MetaSprite_16_459d_END::
MetaSprite_16_45ee::
    INCBIN "gfx/unknown/metasprite_16/45ee.sprite.bin"
MetaSprite_16_45ee_END::
MetaSprite_16_462b::
    INCBIN "gfx/unknown/metasprite_16/462b.sprite.bin"
MetaSprite_16_462b_END::
MetaSprite_16_4654::
    INCBIN "gfx/unknown/metasprite_16/4654.sprite.bin"
MetaSprite_16_4654_END::
MetaSprite_16_467d::
    INCBIN "gfx/unknown/metasprite_16/467d.sprite.bin"
MetaSprite_16_467d_END::
MetaSprite_16_46ba::
    INCBIN "gfx/unknown/metasprite_16/46ba.sprite.bin"
MetaSprite_16_46ba_END::
MetaSprite_16_470b::
    INCBIN "gfx/unknown/metasprite_16/470b.sprite.bin"
MetaSprite_16_470b_END::
MetaSprite_16_4770::
    INCBIN "gfx/unknown/metasprite_16/4770.sprite.bin"
MetaSprite_16_4770_END::
MetaSprite_16_47d5::
    INCBIN "gfx/unknown/metasprite_16/47d5.sprite.bin"
MetaSprite_16_47d5_END::
MetaSprite_16_4826::
    INCBIN "gfx/unknown/metasprite_16/4826.sprite.bin"
MetaSprite_16_4826_END::
MetaSprite_16_4863::
    INCBIN "gfx/unknown/metasprite_16/4863.sprite.bin"
MetaSprite_16_4863_END::
MetaSprite_16_488c::
    INCBIN "gfx/unknown/metasprite_16/488c.sprite.bin"
MetaSprite_16_488c_END::
MetaSprite_16_4897::
    INCBIN "gfx/unknown/metasprite_16/4897.sprite.bin"
MetaSprite_16_4897_END::
MetaSprite_16_48c0::
    INCBIN "gfx/unknown/metasprite_16/48c0.sprite.bin"
MetaSprite_16_48c0_END::
MetaSprite_16_48e9::
    INCBIN "gfx/unknown/metasprite_16/48e9.sprite.bin"
MetaSprite_16_48e9_END::
MetaSprite_16_4962::
    INCBIN "gfx/unknown/metasprite_16/4962.sprite.bin"
MetaSprite_16_4962_END::
MetaSprite_16_49db::
    INCBIN "gfx/unknown/metasprite_16/49db.sprite.bin"
MetaSprite_16_49db_END::
MetaSprite_16_49e6::
    INCBIN "gfx/unknown/metasprite_16/49e6.sprite.bin"
MetaSprite_16_49e6_END::
MetaSprite_16_4a0f::
    INCBIN "gfx/unknown/metasprite_16/4a0f.sprite.bin"
MetaSprite_16_4a0f_END::
MetaSprite_16_4a38::
    INCBIN "gfx/unknown/metasprite_16/4a38.sprite.bin"
MetaSprite_16_4a38_END::
MetaSprite_16_4a6b::
    INCBIN "gfx/unknown/metasprite_16/4a6b.sprite.bin"
MetaSprite_16_4a6b_END::
MetaSprite_16_4a9e::
    INCBIN "gfx/unknown/metasprite_16/4a9e.sprite.bin"
MetaSprite_16_4a9e_END::
MetaSprite_16_4ab3::
    INCBIN "gfx/unknown/metasprite_16/4ab3.sprite.bin"
MetaSprite_16_4ab3_END::
MetaSprite_16_4ac8::
    INCBIN "gfx/unknown/metasprite_16/4ac8.sprite.bin"
MetaSprite_16_4ac8_END::
MetaSprite_16_4add::
    INCBIN "gfx/unknown/metasprite_16/4add.sprite.bin"
MetaSprite_16_4add_END::
MetaSprite_16_4af2::
    INCBIN "gfx/unknown/metasprite_16/4af2.sprite.bin"
MetaSprite_16_4af2_END::
MetaSprite_16_4b07::
    INCBIN "gfx/unknown/metasprite_16/4b07.sprite.bin"
MetaSprite_16_4b07_END::
MetaSprite_16_4b3a::
    INCBIN "gfx/unknown/metasprite_16/4b3a.sprite.bin"
MetaSprite_16_4b3a_END::
MetaSprite_16_4b6d::
    INCBIN "gfx/unknown/metasprite_16/4b6d.sprite.bin"
MetaSprite_16_4b6d_END::
MetaSprite_16_4b82::
    INCBIN "gfx/unknown/metasprite_16/4b82.sprite.bin"
MetaSprite_16_4b82_END::
MetaSprite_16_4b97::
    INCBIN "gfx/unknown/metasprite_16/4b97.sprite.bin"
MetaSprite_16_4b97_END::
MetaSprite_16_4bac::
    INCBIN "gfx/unknown/metasprite_16/4bac.sprite.bin"
MetaSprite_16_4bac_END::
MetaSprite_16_4bb7::
    INCBIN "gfx/unknown/metasprite_16/4bb7.sprite.bin"
MetaSprite_16_4bb7_END::
MetaSprite_16_4be0::
    INCBIN "gfx/unknown/metasprite_16/4be0.sprite.bin"
MetaSprite_16_4be0_END::
MetaSprite_16_4c09::
    INCBIN "gfx/unknown/metasprite_16/4c09.sprite.bin"
MetaSprite_16_4c09_END::
MetaSprite_16_4c3c::
    INCBIN "gfx/unknown/metasprite_16/4c3c.sprite.bin"
MetaSprite_16_4c3c_END::
MetaSprite_16_4c6f::
    INCBIN "gfx/unknown/metasprite_16/4c6f.sprite.bin"
MetaSprite_16_4c6f_END::
MetaSprite_16_4c84::
    INCBIN "gfx/unknown/metasprite_16/4c84.sprite.bin"
MetaSprite_16_4c84_END::
MetaSprite_16_4cad::
    INCBIN "gfx/unknown/metasprite_16/4cad.sprite.bin"
MetaSprite_16_4cad_END::
MetaSprite_16_4cd6::
    INCBIN "gfx/unknown/metasprite_16/4cd6.sprite.bin"
MetaSprite_16_4cd6_END::
MetaSprite_16_4cff::
    INCBIN "gfx/unknown/metasprite_16/4cff.sprite.bin"
MetaSprite_16_4cff_END::
MetaSprite_16_4d28::
    INCBIN "gfx/unknown/metasprite_16/4d28.sprite.bin"
MetaSprite_16_4d28_END::
MetaSprite_16_4d2e::
    INCBIN "gfx/unknown/metasprite_16/4d2e.sprite.bin"
MetaSprite_16_4d2e_END::
MetaSprite_16_4d43::
    INCBIN "gfx/unknown/metasprite_16/4d43.sprite.bin"
MetaSprite_16_4d43_END::
MetaSprite_16_4d58::
    INCBIN "gfx/unknown/metasprite_16/4d58.sprite.bin"
MetaSprite_16_4d58_END::
MetaSprite_16_4d6d::
    INCBIN "gfx/unknown/metasprite_16/4d6d.sprite.bin"
MetaSprite_16_4d6d_END::
MetaSprite_16_4d96::
    INCBIN "gfx/unknown/metasprite_16/4d96.sprite.bin"
MetaSprite_16_4d96_END::
MetaSprite_16_4dab::
    INCBIN "gfx/unknown/metasprite_16/4dab.sprite.bin"
MetaSprite_16_4dab_END::
MetaSprite_16_4dc0::
    INCBIN "gfx/unknown/metasprite_16/4dc0.sprite.bin"
MetaSprite_16_4dc0_END::
MetaSprite_16_4dd5::
    INCBIN "gfx/unknown/metasprite_16/4dd5.sprite.bin"
MetaSprite_16_4dd5_END::
MetaSprite_16_4dea::
    INCBIN "gfx/unknown/metasprite_16/4dea.sprite.bin"
MetaSprite_16_4dea_END::
MetaSprite_16_4e13::
    INCBIN "gfx/unknown/metasprite_16/4e13.sprite.bin"
MetaSprite_16_4e13_END::
MetaSprite_16_4e19::
    INCBIN "gfx/unknown/metasprite_16/4e19.sprite.bin"
MetaSprite_16_4e19_END::
MetaSprite_16_4e2e::
    INCBIN "gfx/unknown/metasprite_16/4e2e.sprite.bin"
MetaSprite_16_4e2e_END::
MetaSprite_16_4e43::
    INCBIN "gfx/unknown/metasprite_16/4e43.sprite.bin"
MetaSprite_16_4e43_END::
MetaSprite_16_4e6c::
    INCBIN "gfx/unknown/metasprite_16/4e6c.sprite.bin"
MetaSprite_16_4e6c_END::
MetaSprite_16_4e9f::
    INCBIN "gfx/unknown/metasprite_16/4e9f.sprite.bin"
MetaSprite_16_4e9f_END::
MetaSprite_16_4ed2::
    INCBIN "gfx/unknown/metasprite_16/4ed2.sprite.bin"
MetaSprite_16_4ed2_END::
MetaSprite_16_4ee7::
    INCBIN "gfx/unknown/metasprite_16/4ee7.sprite.bin"
MetaSprite_16_4ee7_END::
MetaSprite_16_4efc::
    INCBIN "gfx/unknown/metasprite_16/4efc.sprite.bin"
MetaSprite_16_4efc_END::
MetaSprite_16_4f07::
    INCBIN "gfx/unknown/metasprite_16/4f07.sprite.bin"
MetaSprite_16_4f07_END::
MetaSprite_16_4f0d::
    INCBIN "gfx/unknown/metasprite_16/4f0d.sprite.bin"
MetaSprite_16_4f0d_END::
MetaSprite_16_4f1d::
    INCBIN "gfx/unknown/metasprite_16/4f1d.sprite.bin"
MetaSprite_16_4f1d_END::
MetaSprite_16_4f50::
    INCBIN "gfx/unknown/metasprite_16/4f50.sprite.bin"
MetaSprite_16_4f50_END::
MetaSprite_16_4f5b::
    INCBIN "gfx/unknown/metasprite_16/4f5b.sprite.bin"
MetaSprite_16_4f5b_END::
MetaSprite_16_4f7a::
    INCBIN "gfx/unknown/metasprite_16/4f7a.sprite.bin"
MetaSprite_16_4f7a_END::
MetaSprite_16_4fad::
    INCBIN "gfx/unknown/metasprite_16/4fad.sprite.bin"
MetaSprite_16_4fad_END::
MetaSprite_16_4fe0::
    INCBIN "gfx/unknown/metasprite_16/4fe0.sprite.bin"
MetaSprite_16_4fe0_END::
MetaSprite_16_5013::
    INCBIN "gfx/unknown/metasprite_16/5013.sprite.bin"
MetaSprite_16_5013_END::
MetaSprite_16_5028::
    INCBIN "gfx/unknown/metasprite_16/5028.sprite.bin"
MetaSprite_16_5028_END::
MetaSprite_16_503d::
    INCBIN "gfx/unknown/metasprite_16/503d.sprite.bin"
MetaSprite_16_503d_END::
MetaSprite_16_5052::
    INCBIN "gfx/unknown/metasprite_16/5052.sprite.bin"
MetaSprite_16_5052_END::
MetaSprite_16_5067::
    INCBIN "gfx/unknown/metasprite_16/5067.sprite.bin"
MetaSprite_16_5067_END::
MetaSprite_16_509a::
    INCBIN "gfx/unknown/metasprite_16/509a.sprite.bin"
MetaSprite_16_509a_END::
MetaSprite_16_50cd::
    INCBIN "gfx/unknown/metasprite_16/50cd.sprite.bin"
MetaSprite_16_50cd_END::
MetaSprite_16_50d3::
    INCBIN "gfx/unknown/metasprite_16/50d3.sprite.bin"
MetaSprite_16_50d3_END::
MetaSprite_16_5106::
    INCBIN "gfx/unknown/metasprite_16/5106.sprite.bin"
MetaSprite_16_5106_END::
MetaSprite_16_5139::
    INCBIN "gfx/unknown/metasprite_16/5139.sprite.bin"
MetaSprite_16_5139_END::
MetaSprite_16_5162::
    INCBIN "gfx/unknown/metasprite_16/5162.sprite.bin"
MetaSprite_16_5162_END::
MetaSprite_16_519f::
    INCBIN "gfx/unknown/metasprite_16/519f.sprite.bin"
MetaSprite_16_519f_END::
MetaSprite_16_51f0::
    INCBIN "gfx/unknown/metasprite_16/51f0.sprite.bin"
MetaSprite_16_51f0_END::
MetaSprite_16_5255::
    INCBIN "gfx/unknown/metasprite_16/5255.sprite.bin"
MetaSprite_16_5255_END::
MetaSprite_16_52ba::
    INCBIN "gfx/unknown/metasprite_16/52ba.sprite.bin"
MetaSprite_16_52ba_END::
MetaSprite_16_530b::
    INCBIN "gfx/unknown/metasprite_16/530b.sprite.bin"
MetaSprite_16_530b_END::
MetaSprite_16_5348::
    INCBIN "gfx/unknown/metasprite_16/5348.sprite.bin"
MetaSprite_16_5348_END::
MetaSprite_16_5371::
    INCBIN "gfx/unknown/metasprite_16/5371.sprite.bin"
MetaSprite_16_5371_END::
MetaSprite_16_5386::
    INCBIN "gfx/unknown/metasprite_16/5386.sprite.bin"
MetaSprite_16_5386_END::
MetaSprite_16_539b::
    INCBIN "gfx/unknown/metasprite_16/539b.sprite.bin"
MetaSprite_16_539b_END::
MetaSprite_16_53b0::
    INCBIN "gfx/unknown/metasprite_16/53b0.sprite.bin"
MetaSprite_16_53b0_END::
MetaSprite_16_53c5::
    INCBIN "gfx/unknown/metasprite_16/53c5.sprite.bin"
MetaSprite_16_53c5_END::
MetaSprite_16_53ee::
    INCBIN "gfx/unknown/metasprite_16/53ee.sprite.bin"
MetaSprite_16_53ee_END::
MetaSprite_16_542b::
    INCBIN "gfx/unknown/metasprite_16/542b.sprite.bin"
MetaSprite_16_542b_END::
MetaSprite_16_547c::
    INCBIN "gfx/unknown/metasprite_16/547c.sprite.bin"
MetaSprite_16_547c_END::
MetaSprite_16_54e1::
    INCBIN "gfx/unknown/metasprite_16/54e1.sprite.bin"
MetaSprite_16_54e1_END::
MetaSprite_16_5546::
    INCBIN "gfx/unknown/metasprite_16/5546.sprite.bin"
MetaSprite_16_5546_END::
MetaSprite_16_5597::
    INCBIN "gfx/unknown/metasprite_16/5597.sprite.bin"
MetaSprite_16_5597_END::
MetaSprite_16_55d4::
    INCBIN "gfx/unknown/metasprite_16/55d4.sprite.bin"
MetaSprite_16_55d4_END::
MetaSprite_16_55fd::
    INCBIN "gfx/unknown/metasprite_16/55fd.sprite.bin"
MetaSprite_16_55fd_END::
MetaSprite_16_5612::
    INCBIN "gfx/unknown/metasprite_16/5612.sprite.bin"
MetaSprite_16_5612_END::
MetaSprite_16_563b::
    INCBIN "gfx/unknown/metasprite_16/563b.sprite.bin"
MetaSprite_16_563b_END::
MetaSprite_16_5664::
    INCBIN "gfx/unknown/metasprite_16/5664.sprite.bin"
MetaSprite_16_5664_END::
MetaSprite_16_568d::
    INCBIN "gfx/unknown/metasprite_16/568d.sprite.bin"
MetaSprite_16_568d_END::
MetaSprite_16_56a2::
    INCBIN "gfx/unknown/metasprite_16/56a2.sprite.bin"
MetaSprite_16_56a2_END::
MetaSprite_16_571b::
    INCBIN "gfx/unknown/metasprite_16/571b.sprite.bin"
MetaSprite_16_571b_END::
MetaSprite_16_5794::
    INCBIN "gfx/unknown/metasprite_16/5794.sprite.bin"
MetaSprite_16_5794_END::
MetaSprite_16_57c7::
    INCBIN "gfx/unknown/metasprite_16/57c7.sprite.bin"
MetaSprite_16_57c7_END::
MetaSprite_16_57dc::
    INCBIN "gfx/unknown/metasprite_16/57dc.sprite.bin"
MetaSprite_16_57dc_END::
MetaSprite_16_57f1::
    INCBIN "gfx/unknown/metasprite_16/57f1.sprite.bin"
MetaSprite_16_57f1_END::
MetaSprite_16_5806::
    INCBIN "gfx/unknown/metasprite_16/5806.sprite.bin"
MetaSprite_16_5806_END::
MetaSprite_16_581b::
    INCBIN "gfx/unknown/metasprite_16/581b.sprite.bin"
MetaSprite_16_581b_END::
MetaSprite_16_5867::
    INCBIN "gfx/unknown/metasprite_16/5867.sprite.bin"
MetaSprite_16_5867_END::
MetaSprite_16_58e0::
    INCBIN "gfx/unknown/metasprite_16/58e0.sprite.bin"
MetaSprite_16_58e0_END::
MetaSprite_16_5959::
    INCBIN "gfx/unknown/metasprite_16/5959.sprite.bin"
MetaSprite_16_5959_END::
MetaSprite_16_596e::
    INCBIN "gfx/unknown/metasprite_16/596e.sprite.bin"
MetaSprite_16_596e_END::
MetaSprite_16_5983::
    INCBIN "gfx/unknown/metasprite_16/5983.sprite.bin"
MetaSprite_16_5983_END::
MetaSprite_16_59fc::
    INCBIN "gfx/unknown/metasprite_16/59fc.sprite.bin"
MetaSprite_16_59fc_END::
MetaSprite_16_5a75::
    INCBIN "gfx/unknown/metasprite_16/5a75.sprite.bin"
MetaSprite_16_5a75_END::
MetaSprite_16_5a8a::
    INCBIN "gfx/unknown/metasprite_16/5a8a.sprite.bin"
MetaSprite_16_5a8a_END::
MetaSprite_16_5b03::
    INCBIN "gfx/unknown/metasprite_16/5b03.sprite.bin"
MetaSprite_16_5b03_END::
MetaSprite_16_5b7c::
    INCBIN "gfx/unknown/metasprite_16/5b7c.sprite.bin"
MetaSprite_16_5b7c_END::
MetaSprite_16_5b91::
    INCBIN "gfx/unknown/metasprite_16/5b91.sprite.bin"
MetaSprite_16_5b91_END::
MetaSprite_16_5bba::
    INCBIN "gfx/unknown/metasprite_16/5bba.sprite.bin"
MetaSprite_16_5bba_END::
MetaSprite_16_5be3::
    INCBIN "gfx/unknown/metasprite_16/5be3.sprite.bin"
MetaSprite_16_5be3_END::
MetaSprite_16_5c0c::
    INCBIN "gfx/unknown/metasprite_16/5c0c.sprite.bin"
MetaSprite_16_5c0c_END::
MetaSprite_16_5c35::
    INCBIN "gfx/unknown/metasprite_16/5c35.sprite.bin"
MetaSprite_16_5c35_END::
MetaSprite_16_5c5e::
    INCBIN "gfx/unknown/metasprite_16/5c5e.sprite.bin"
MetaSprite_16_5c5e_END::
MetaSprite_16_5c9b::
    INCBIN "gfx/unknown/metasprite_16/5c9b.sprite.bin"
MetaSprite_16_5c9b_END::
MetaSprite_16_5cec::
    INCBIN "gfx/unknown/metasprite_16/5cec.sprite.bin"
MetaSprite_16_5cec_END::
MetaSprite_16_5d51::
    INCBIN "gfx/unknown/metasprite_16/5d51.sprite.bin"
MetaSprite_16_5d51_END::
MetaSprite_16_5db6::
    INCBIN "gfx/unknown/metasprite_16/5db6.sprite.bin"
MetaSprite_16_5db6_END::
MetaSprite_16_5e07::
    INCBIN "gfx/unknown/metasprite_16/5e07.sprite.bin"
MetaSprite_16_5e07_END::
MetaSprite_16_5e44::
    INCBIN "gfx/unknown/metasprite_16/5e44.sprite.bin"
MetaSprite_16_5e44_END::
MetaSprite_16_5e6d::
    INCBIN "gfx/unknown/metasprite_16/5e6d.sprite.bin"
MetaSprite_16_5e6d_END::
MetaSprite_16_5e82::
    INCBIN "gfx/unknown/metasprite_16/5e82.sprite.bin"
MetaSprite_16_5e82_END::
MetaSprite_16_5e97::
    INCBIN "gfx/unknown/metasprite_16/5e97.sprite.bin"
MetaSprite_16_5e97_END::
MetaSprite_16_5eb6::
    INCBIN "gfx/unknown/metasprite_16/5eb6.sprite.bin"
MetaSprite_16_5eb6_END::
MetaSprite_16_5efd::
    INCBIN "gfx/unknown/metasprite_16/5efd.sprite.bin"
MetaSprite_16_5efd_END::
MetaSprite_16_5f03::
    INCBIN "gfx/unknown/metasprite_16/5f03.sprite.bin"
MetaSprite_16_5f03_END::
MetaSprite_16_5f0e::
    INCBIN "gfx/unknown/metasprite_16/5f0e.sprite.bin"
MetaSprite_16_5f0e_END::
MetaSprite_16_5f1e::
    INCBIN "gfx/unknown/metasprite_16/5f1e.sprite.bin"
MetaSprite_16_5f1e_END::
MetaSprite_16_5f33::
    INCBIN "gfx/unknown/metasprite_16/5f33.sprite.bin"
MetaSprite_16_5f33_END::
MetaSprite_16_5f4d::
    INCBIN "gfx/unknown/metasprite_16/5f4d.sprite.bin"
MetaSprite_16_5f4d_END::
MetaSprite_16_5f53::
    INCBIN "gfx/unknown/metasprite_16/5f53.sprite.bin"
MetaSprite_16_5f53_END::
MetaSprite_16_5f72::
    INCBIN "gfx/unknown/metasprite_16/5f72.sprite.bin"
MetaSprite_16_5f72_END::
MetaSprite_16_5f78::
    INCBIN "gfx/unknown/metasprite_16/5f78.sprite.bin"
MetaSprite_16_5f78_END::
MetaSprite_16_5f8d::
    INCBIN "gfx/unknown/metasprite_16/5f8d.sprite.bin"
MetaSprite_16_5f8d_END::
MetaSprite_16_5fa2::
    INCBIN "gfx/unknown/metasprite_16/5fa2.sprite.bin"
MetaSprite_16_5fa2_END::
MetaSprite_16_5fc6::
    INCBIN "gfx/unknown/metasprite_16/5fc6.sprite.bin"
MetaSprite_16_5fc6_END::
MetaSprite_16_5fcc::
    INCBIN "gfx/unknown/metasprite_16/5fcc.sprite.bin"
MetaSprite_16_5fcc_END::
MetaSprite_16_5fd2::
    INCBIN "gfx/unknown/metasprite_16/5fd2.sprite.bin"
MetaSprite_16_5fd2_END::
MetaSprite_16_5fd8::
    INCBIN "gfx/unknown/metasprite_16/5fd8.sprite.bin"
MetaSprite_16_5fd8_END::
MetaSprite_16_5fde::
    INCBIN "gfx/unknown/metasprite_16/5fde.sprite.bin"
MetaSprite_16_5fde_END::
MetaSprite_16_5fe4::
    INCBIN "gfx/unknown/metasprite_16/5fe4.sprite.bin"
MetaSprite_16_5fe4_END::
MetaSprite_16_5fea::
    INCBIN "gfx/unknown/metasprite_16/5fea.sprite.bin"
MetaSprite_16_5fea_END::
MetaSprite_16_5ff0::
    INCBIN "gfx/unknown/metasprite_16/5ff0.sprite.bin"
MetaSprite_16_5ff0_END::
MetaSprite_16_5ffb::
    INCBIN "gfx/unknown/metasprite_16/5ffb.sprite.bin"
MetaSprite_16_5ffb_END::
MetaSprite_16_6024::
    INCBIN "gfx/unknown/metasprite_16/6024.sprite.bin"
MetaSprite_16_6024_END::
MetaSprite_16_6039::
    INCBIN "gfx/unknown/metasprite_16/6039.sprite.bin"
MetaSprite_16_6039_END::
MetaSprite_16_604e::
    INCBIN "gfx/unknown/metasprite_16/604e.sprite.bin"
MetaSprite_16_604e_END::

SECTION "MetaSprite_17", ROMX[$4000], BANK[$17]
MetaSprite_17::
    dw MetaSprite_17_41b8
    dw MetaSprite_17_41c8
    dw MetaSprite_17_41e2
    dw MetaSprite_17_4201
    dw MetaSprite_17_421b
    dw MetaSprite_17_422b
    dw MetaSprite_17_4240
    dw MetaSprite_17_4264
    dw MetaSprite_17_4297
    dw MetaSprite_17_42bb
    dw MetaSprite_17_42d0
    dw MetaSprite_17_42e0
    dw MetaSprite_17_42ff
    dw MetaSprite_17_431e
    dw MetaSprite_17_432e
    dw MetaSprite_17_4343
    dw MetaSprite_17_4367
    dw MetaSprite_17_437c
    dw MetaSprite_17_43a0
    dw MetaSprite_17_43ab
    dw MetaSprite_17_43bb
    dw MetaSprite_17_43d0
    dw MetaSprite_17_43ea
    dw MetaSprite_17_4404
    dw MetaSprite_17_4419
    dw MetaSprite_17_4424
    dw MetaSprite_17_4439
    dw MetaSprite_17_445d
    dw MetaSprite_17_447c
    dw MetaSprite_17_449b
    dw MetaSprite_17_44c4
    dw MetaSprite_17_4501
    dw MetaSprite_17_4511
    dw MetaSprite_17_452b
    dw MetaSprite_17_454a
    dw MetaSprite_17_4564
    dw MetaSprite_17_4574
    dw MetaSprite_17_4584
    dw MetaSprite_17_459e
    dw MetaSprite_17_45bd
    dw MetaSprite_17_45d7
    dw MetaSprite_17_45e7
    dw MetaSprite_17_45fc
    dw MetaSprite_17_4611
    dw MetaSprite_17_464e
    dw MetaSprite_17_4663
    dw MetaSprite_17_4678
    dw MetaSprite_17_468d
    dw MetaSprite_17_46a2
    dw MetaSprite_17_46a8
    dw MetaSprite_17_46bd
    dw MetaSprite_17_474a
    dw MetaSprite_17_47d7
    dw MetaSprite_17_47e7
    dw MetaSprite_17_4801
    dw MetaSprite_17_4820
    dw MetaSprite_17_483a
    dw MetaSprite_17_484a
    dw MetaSprite_17_485a
    dw MetaSprite_17_4874
    dw MetaSprite_17_4893
    dw MetaSprite_17_48ad
    dw MetaSprite_17_48bd
    dw MetaSprite_17_48d2
    dw MetaSprite_17_48f6
    dw MetaSprite_17_4929
    dw MetaSprite_17_494d
    dw MetaSprite_17_4962
    dw MetaSprite_17_4977
    dw MetaSprite_17_499b
    dw MetaSprite_17_49ce
    dw MetaSprite_17_49f2
    dw MetaSprite_17_4a07
    dw MetaSprite_17_4a1c
    dw MetaSprite_17_4a40
    dw MetaSprite_17_4a73
    dw MetaSprite_17_4a97
    dw MetaSprite_17_4aac
    dw MetaSprite_17_4abc
    dw MetaSprite_17_4adb
    dw MetaSprite_17_4afa
    dw MetaSprite_17_4b0a
    dw MetaSprite_17_4b6f
    dw MetaSprite_17_4c06
    dw MetaSprite_17_4c6b
    dw MetaSprite_17_4c8a
    dw MetaSprite_17_4ca9
    dw MetaSprite_17_4cb4
    dw MetaSprite_17_4cdd
    dw MetaSprite_17_4cf2
    dw MetaSprite_17_4d07
    dw MetaSprite_17_4d1c
    dw MetaSprite_17_4d45
    dw MetaSprite_17_4d6e
    dw MetaSprite_17_4d83
    dw MetaSprite_17_4d98
    dw MetaSprite_17_4dad
    dw MetaSprite_17_4dc2
    dw MetaSprite_17_4dd7
    dw MetaSprite_17_4dec
    dw MetaSprite_17_4e01
    dw MetaSprite_17_4e1b
    dw MetaSprite_17_4e35
    dw MetaSprite_17_4e4f
    dw MetaSprite_17_4e64
    dw MetaSprite_17_4e83
    dw MetaSprite_17_4eac
    dw MetaSprite_17_4edf
    dw MetaSprite_17_4f08
    dw MetaSprite_17_4f27
    dw MetaSprite_17_4f3c
    dw MetaSprite_17_4f51
    dw MetaSprite_17_4f6b
    dw MetaSprite_17_4f85
    dw MetaSprite_17_4fa4
    dw MetaSprite_17_4fbe
    dw MetaSprite_17_4fec
    dw MetaSprite_17_5024
    dw MetaSprite_17_5052
    dw MetaSprite_17_508a
    dw MetaSprite_17_50b8
    dw MetaSprite_17_50be
    dw MetaSprite_17_50d3
    dw MetaSprite_17_50fc
    dw MetaSprite_17_511b
    dw MetaSprite_17_5135
    dw MetaSprite_17_514f
    dw MetaSprite_17_516e
    dw MetaSprite_17_5188
    dw MetaSprite_17_51b6
    dw MetaSprite_17_51ee
    dw MetaSprite_17_521c
    dw MetaSprite_17_5254
    dw MetaSprite_17_5282
    dw MetaSprite_17_5288
    dw MetaSprite_17_529d
    dw MetaSprite_17_52c6
    dw MetaSprite_17_52e5
    dw MetaSprite_17_5336
    dw MetaSprite_17_537d
    dw MetaSprite_17_53a6
    dw MetaSprite_17_53d9
    dw MetaSprite_17_5416
    dw MetaSprite_17_545d
    dw MetaSprite_17_549a
    dw MetaSprite_17_54c3
    dw MetaSprite_17_5514
    dw MetaSprite_17_555b
    dw MetaSprite_17_5575
    dw MetaSprite_17_558f
    dw MetaSprite_17_55a9
    dw MetaSprite_17_55d7
    dw MetaSprite_17_5614
    dw MetaSprite_17_5660
    dw MetaSprite_17_56bb
    dw MetaSprite_17_5707
    dw MetaSprite_17_5735
    dw MetaSprite_17_574f
    dw MetaSprite_17_5769
    dw MetaSprite_17_578d
    dw MetaSprite_17_57c5
    dw MetaSprite_17_581b
    dw MetaSprite_17_5867
    dw MetaSprite_17_58cc
    dw MetaSprite_17_5922
    dw MetaSprite_17_5937
    dw MetaSprite_17_594c
    dw MetaSprite_17_5975
    dw MetaSprite_17_599e
    dw MetaSprite_17_59b8
    dw MetaSprite_17_59d2
    dw MetaSprite_17_59ec
    dw MetaSprite_17_5a15
    dw MetaSprite_17_5a52
    dw MetaSprite_17_5aa3
    dw MetaSprite_17_5af4
    dw MetaSprite_17_5b31
    dw MetaSprite_17_5b5a
    dw MetaSprite_17_5b6f
    dw MetaSprite_17_5b84
    dw MetaSprite_17_5bad
    dw MetaSprite_17_5bd6
    dw MetaSprite_17_5beb
    dw MetaSprite_17_5c00
    dw MetaSprite_17_5c06
    dw MetaSprite_17_5c0c
    dw MetaSprite_17_5c21
    dw MetaSprite_17_5c36
    dw MetaSprite_17_5c3c
    dw MetaSprite_17_5c42
    dw MetaSprite_17_5c57
    dw MetaSprite_17_5c6c
    dw MetaSprite_17_5c72
    dw MetaSprite_17_5c78
    dw MetaSprite_17_5c88
    dw MetaSprite_17_5ca2
    dw MetaSprite_17_5cc1
    dw MetaSprite_17_5cdb
    dw MetaSprite_17_5ceb
    dw MetaSprite_17_5d00
    dw MetaSprite_17_5d24
    dw MetaSprite_17_5d57
    dw MetaSprite_17_5d7b
    dw MetaSprite_17_5d90
    dw MetaSprite_17_5da5
    dw MetaSprite_17_5dba
    dw MetaSprite_17_5de3
    dw MetaSprite_17_5dfd
    dw MetaSprite_17_5e26
    dw MetaSprite_17_5e3b
    dw MetaSprite_17_5e78
    dw MetaSprite_17_5e8d
    dw MetaSprite_17_5ea2
    dw MetaSprite_17_5edf
    dw MetaSprite_17_5f1c
    dw MetaSprite_17_5f31
    dw MetaSprite_17_5f46
    dw MetaSprite_17_5f6f
    dw MetaSprite_17_5fd4
    dw MetaSprite_17_6025

SECTION "MetaSprite_17_41b8", ROMX[$41b8], BANK[$17]
MetaSprite_17_41b8::
    INCBIN "gfx/unknown/metasprite_17/41b8.sprite.bin"
MetaSprite_17_41b8_END::
MetaSprite_17_41c8::
    INCBIN "gfx/unknown/metasprite_17/41c8.sprite.bin"
MetaSprite_17_41c8_END::
MetaSprite_17_41e2::
    INCBIN "gfx/unknown/metasprite_17/41e2.sprite.bin"
MetaSprite_17_41e2_END::
MetaSprite_17_4201::
    INCBIN "gfx/unknown/metasprite_17/4201.sprite.bin"
MetaSprite_17_4201_END::
MetaSprite_17_421b::
    INCBIN "gfx/unknown/metasprite_17/421b.sprite.bin"
MetaSprite_17_421b_END::
MetaSprite_17_422b::
    INCBIN "gfx/unknown/metasprite_17/422b.sprite.bin"
MetaSprite_17_422b_END::
MetaSprite_17_4240::
    INCBIN "gfx/unknown/metasprite_17/4240.sprite.bin"
MetaSprite_17_4240_END::
MetaSprite_17_4264::
    INCBIN "gfx/unknown/metasprite_17/4264.sprite.bin"
MetaSprite_17_4264_END::
MetaSprite_17_4297::
    INCBIN "gfx/unknown/metasprite_17/4297.sprite.bin"
MetaSprite_17_4297_END::
MetaSprite_17_42bb::
    INCBIN "gfx/unknown/metasprite_17/42bb.sprite.bin"
MetaSprite_17_42bb_END::
MetaSprite_17_42d0::
    INCBIN "gfx/unknown/metasprite_17/42d0.sprite.bin"
MetaSprite_17_42d0_END::
MetaSprite_17_42e0::
    INCBIN "gfx/unknown/metasprite_17/42e0.sprite.bin"
MetaSprite_17_42e0_END::
MetaSprite_17_42ff::
    INCBIN "gfx/unknown/metasprite_17/42ff.sprite.bin"
MetaSprite_17_42ff_END::
MetaSprite_17_431e::
    INCBIN "gfx/unknown/metasprite_17/431e.sprite.bin"
MetaSprite_17_431e_END::
MetaSprite_17_432e::
    INCBIN "gfx/unknown/metasprite_17/432e.sprite.bin"
MetaSprite_17_432e_END::
MetaSprite_17_4343::
    INCBIN "gfx/unknown/metasprite_17/4343.sprite.bin"
MetaSprite_17_4343_END::
MetaSprite_17_4367::
    INCBIN "gfx/unknown/metasprite_17/4367.sprite.bin"
MetaSprite_17_4367_END::
MetaSprite_17_437c::
    INCBIN "gfx/unknown/metasprite_17/437c.sprite.bin"
MetaSprite_17_437c_END::
MetaSprite_17_43a0::
    INCBIN "gfx/unknown/metasprite_17/43a0.sprite.bin"
MetaSprite_17_43a0_END::
MetaSprite_17_43ab::
    INCBIN "gfx/unknown/metasprite_17/43ab.sprite.bin"
MetaSprite_17_43ab_END::
MetaSprite_17_43bb::
    INCBIN "gfx/unknown/metasprite_17/43bb.sprite.bin"
MetaSprite_17_43bb_END::
MetaSprite_17_43d0::
    INCBIN "gfx/unknown/metasprite_17/43d0.sprite.bin"
MetaSprite_17_43d0_END::
MetaSprite_17_43ea::
    INCBIN "gfx/unknown/metasprite_17/43ea.sprite.bin"
MetaSprite_17_43ea_END::
MetaSprite_17_4404::
    INCBIN "gfx/unknown/metasprite_17/4404.sprite.bin"
MetaSprite_17_4404_END::
MetaSprite_17_4419::
    INCBIN "gfx/unknown/metasprite_17/4419.sprite.bin"
MetaSprite_17_4419_END::
MetaSprite_17_4424::
    INCBIN "gfx/unknown/metasprite_17/4424.sprite.bin"
MetaSprite_17_4424_END::
MetaSprite_17_4439::
    INCBIN "gfx/unknown/metasprite_17/4439.sprite.bin"
MetaSprite_17_4439_END::
MetaSprite_17_445d::
    INCBIN "gfx/unknown/metasprite_17/445d.sprite.bin"
MetaSprite_17_445d_END::
MetaSprite_17_447c::
    INCBIN "gfx/unknown/metasprite_17/447c.sprite.bin"
MetaSprite_17_447c_END::
MetaSprite_17_449b::
    INCBIN "gfx/unknown/metasprite_17/449b.sprite.bin"
MetaSprite_17_449b_END::
MetaSprite_17_44c4::
    INCBIN "gfx/unknown/metasprite_17/44c4.sprite.bin"
MetaSprite_17_44c4_END::
MetaSprite_17_4501::
    INCBIN "gfx/unknown/metasprite_17/4501.sprite.bin"
MetaSprite_17_4501_END::
MetaSprite_17_4511::
    INCBIN "gfx/unknown/metasprite_17/4511.sprite.bin"
MetaSprite_17_4511_END::
MetaSprite_17_452b::
    INCBIN "gfx/unknown/metasprite_17/452b.sprite.bin"
MetaSprite_17_452b_END::
MetaSprite_17_454a::
    INCBIN "gfx/unknown/metasprite_17/454a.sprite.bin"
MetaSprite_17_454a_END::
MetaSprite_17_4564::
    INCBIN "gfx/unknown/metasprite_17/4564.sprite.bin"
MetaSprite_17_4564_END::
MetaSprite_17_4574::
    INCBIN "gfx/unknown/metasprite_17/4574.sprite.bin"
MetaSprite_17_4574_END::
MetaSprite_17_4584::
    INCBIN "gfx/unknown/metasprite_17/4584.sprite.bin"
MetaSprite_17_4584_END::
MetaSprite_17_459e::
    INCBIN "gfx/unknown/metasprite_17/459e.sprite.bin"
MetaSprite_17_459e_END::
MetaSprite_17_45bd::
    INCBIN "gfx/unknown/metasprite_17/45bd.sprite.bin"
MetaSprite_17_45bd_END::
MetaSprite_17_45d7::
    INCBIN "gfx/unknown/metasprite_17/45d7.sprite.bin"
MetaSprite_17_45d7_END::
MetaSprite_17_45e7::
    INCBIN "gfx/unknown/metasprite_17/45e7.sprite.bin"
MetaSprite_17_45e7_END::
MetaSprite_17_45fc::
    INCBIN "gfx/unknown/metasprite_17/45fc.sprite.bin"
MetaSprite_17_45fc_END::
MetaSprite_17_4611::
    INCBIN "gfx/unknown/metasprite_17/4611.sprite.bin"
MetaSprite_17_4611_END::
MetaSprite_17_464e::
    INCBIN "gfx/unknown/metasprite_17/464e.sprite.bin"
MetaSprite_17_464e_END::
MetaSprite_17_4663::
    INCBIN "gfx/unknown/metasprite_17/4663.sprite.bin"
MetaSprite_17_4663_END::
MetaSprite_17_4678::
    INCBIN "gfx/unknown/metasprite_17/4678.sprite.bin"
MetaSprite_17_4678_END::
MetaSprite_17_468d::
    INCBIN "gfx/unknown/metasprite_17/468d.sprite.bin"
MetaSprite_17_468d_END::
MetaSprite_17_46a2::
    INCBIN "gfx/unknown/metasprite_17/46a2.sprite.bin"
MetaSprite_17_46a2_END::
MetaSprite_17_46a8::
    INCBIN "gfx/unknown/metasprite_17/46a8.sprite.bin"
MetaSprite_17_46a8_END::
MetaSprite_17_46bd::
    INCBIN "gfx/unknown/metasprite_17/46bd.sprite.bin"
MetaSprite_17_46bd_END::
MetaSprite_17_474a::
    INCBIN "gfx/unknown/metasprite_17/474a.sprite.bin"
MetaSprite_17_474a_END::
MetaSprite_17_47d7::
    INCBIN "gfx/unknown/metasprite_17/47d7.sprite.bin"
MetaSprite_17_47d7_END::
MetaSprite_17_47e7::
    INCBIN "gfx/unknown/metasprite_17/47e7.sprite.bin"
MetaSprite_17_47e7_END::
MetaSprite_17_4801::
    INCBIN "gfx/unknown/metasprite_17/4801.sprite.bin"
MetaSprite_17_4801_END::
MetaSprite_17_4820::
    INCBIN "gfx/unknown/metasprite_17/4820.sprite.bin"
MetaSprite_17_4820_END::
MetaSprite_17_483a::
    INCBIN "gfx/unknown/metasprite_17/483a.sprite.bin"
MetaSprite_17_483a_END::
MetaSprite_17_484a::
    INCBIN "gfx/unknown/metasprite_17/484a.sprite.bin"
MetaSprite_17_484a_END::
MetaSprite_17_485a::
    INCBIN "gfx/unknown/metasprite_17/485a.sprite.bin"
MetaSprite_17_485a_END::
MetaSprite_17_4874::
    INCBIN "gfx/unknown/metasprite_17/4874.sprite.bin"
MetaSprite_17_4874_END::
MetaSprite_17_4893::
    INCBIN "gfx/unknown/metasprite_17/4893.sprite.bin"
MetaSprite_17_4893_END::
MetaSprite_17_48ad::
    INCBIN "gfx/unknown/metasprite_17/48ad.sprite.bin"
MetaSprite_17_48ad_END::
MetaSprite_17_48bd::
    INCBIN "gfx/unknown/metasprite_17/48bd.sprite.bin"
MetaSprite_17_48bd_END::
MetaSprite_17_48d2::
    INCBIN "gfx/unknown/metasprite_17/48d2.sprite.bin"
MetaSprite_17_48d2_END::
MetaSprite_17_48f6::
    INCBIN "gfx/unknown/metasprite_17/48f6.sprite.bin"
MetaSprite_17_48f6_END::
MetaSprite_17_4929::
    INCBIN "gfx/unknown/metasprite_17/4929.sprite.bin"
MetaSprite_17_4929_END::
MetaSprite_17_494d::
    INCBIN "gfx/unknown/metasprite_17/494d.sprite.bin"
MetaSprite_17_494d_END::
MetaSprite_17_4962::
    INCBIN "gfx/unknown/metasprite_17/4962.sprite.bin"
MetaSprite_17_4962_END::
MetaSprite_17_4977::
    INCBIN "gfx/unknown/metasprite_17/4977.sprite.bin"
MetaSprite_17_4977_END::
MetaSprite_17_499b::
    INCBIN "gfx/unknown/metasprite_17/499b.sprite.bin"
MetaSprite_17_499b_END::
MetaSprite_17_49ce::
    INCBIN "gfx/unknown/metasprite_17/49ce.sprite.bin"
MetaSprite_17_49ce_END::
MetaSprite_17_49f2::
    INCBIN "gfx/unknown/metasprite_17/49f2.sprite.bin"
MetaSprite_17_49f2_END::
MetaSprite_17_4a07::
    INCBIN "gfx/unknown/metasprite_17/4a07.sprite.bin"
MetaSprite_17_4a07_END::
MetaSprite_17_4a1c::
    INCBIN "gfx/unknown/metasprite_17/4a1c.sprite.bin"
MetaSprite_17_4a1c_END::
MetaSprite_17_4a40::
    INCBIN "gfx/unknown/metasprite_17/4a40.sprite.bin"
MetaSprite_17_4a40_END::
MetaSprite_17_4a73::
    INCBIN "gfx/unknown/metasprite_17/4a73.sprite.bin"
MetaSprite_17_4a73_END::
MetaSprite_17_4a97::
    INCBIN "gfx/unknown/metasprite_17/4a97.sprite.bin"
MetaSprite_17_4a97_END::
MetaSprite_17_4aac::
    INCBIN "gfx/unknown/metasprite_17/4aac.sprite.bin"
MetaSprite_17_4aac_END::
MetaSprite_17_4abc::
    INCBIN "gfx/unknown/metasprite_17/4abc.sprite.bin"
MetaSprite_17_4abc_END::
MetaSprite_17_4adb::
    INCBIN "gfx/unknown/metasprite_17/4adb.sprite.bin"
MetaSprite_17_4adb_END::
MetaSprite_17_4afa::
    INCBIN "gfx/unknown/metasprite_17/4afa.sprite.bin"
MetaSprite_17_4afa_END::
MetaSprite_17_4b0a::
    INCBIN "gfx/unknown/metasprite_17/4b0a.sprite.bin"
MetaSprite_17_4b0a_END::
MetaSprite_17_4b6f::
    INCBIN "gfx/unknown/metasprite_17/4b6f.sprite.bin"
MetaSprite_17_4b6f_END::
MetaSprite_17_4c06::
    INCBIN "gfx/unknown/metasprite_17/4c06.sprite.bin"
MetaSprite_17_4c06_END::
MetaSprite_17_4c6b::
    INCBIN "gfx/unknown/metasprite_17/4c6b.sprite.bin"
MetaSprite_17_4c6b_END::
MetaSprite_17_4c8a::
    INCBIN "gfx/unknown/metasprite_17/4c8a.sprite.bin"
MetaSprite_17_4c8a_END::
MetaSprite_17_4ca9::
    INCBIN "gfx/unknown/metasprite_17/4ca9.sprite.bin"
MetaSprite_17_4ca9_END::
MetaSprite_17_4cb4::
    INCBIN "gfx/unknown/metasprite_17/4cb4.sprite.bin"
MetaSprite_17_4cb4_END::
MetaSprite_17_4cdd::
    INCBIN "gfx/unknown/metasprite_17/4cdd.sprite.bin"
MetaSprite_17_4cdd_END::
MetaSprite_17_4cf2::
    INCBIN "gfx/unknown/metasprite_17/4cf2.sprite.bin"
MetaSprite_17_4cf2_END::
MetaSprite_17_4d07::
    INCBIN "gfx/unknown/metasprite_17/4d07.sprite.bin"
MetaSprite_17_4d07_END::
MetaSprite_17_4d1c::
    INCBIN "gfx/unknown/metasprite_17/4d1c.sprite.bin"
MetaSprite_17_4d1c_END::
MetaSprite_17_4d45::
    INCBIN "gfx/unknown/metasprite_17/4d45.sprite.bin"
MetaSprite_17_4d45_END::
MetaSprite_17_4d6e::
    INCBIN "gfx/unknown/metasprite_17/4d6e.sprite.bin"
MetaSprite_17_4d6e_END::
MetaSprite_17_4d83::
    INCBIN "gfx/unknown/metasprite_17/4d83.sprite.bin"
MetaSprite_17_4d83_END::
MetaSprite_17_4d98::
    INCBIN "gfx/unknown/metasprite_17/4d98.sprite.bin"
MetaSprite_17_4d98_END::
MetaSprite_17_4dad::
    INCBIN "gfx/unknown/metasprite_17/4dad.sprite.bin"
MetaSprite_17_4dad_END::
MetaSprite_17_4dc2::
    INCBIN "gfx/unknown/metasprite_17/4dc2.sprite.bin"
MetaSprite_17_4dc2_END::
MetaSprite_17_4dd7::
    INCBIN "gfx/unknown/metasprite_17/4dd7.sprite.bin"
MetaSprite_17_4dd7_END::
MetaSprite_17_4dec::
    INCBIN "gfx/unknown/metasprite_17/4dec.sprite.bin"
MetaSprite_17_4dec_END::
MetaSprite_17_4e01::
    INCBIN "gfx/unknown/metasprite_17/4e01.sprite.bin"
MetaSprite_17_4e01_END::
MetaSprite_17_4e1b::
    INCBIN "gfx/unknown/metasprite_17/4e1b.sprite.bin"
MetaSprite_17_4e1b_END::
MetaSprite_17_4e35::
    INCBIN "gfx/unknown/metasprite_17/4e35.sprite.bin"
MetaSprite_17_4e35_END::
MetaSprite_17_4e4f::
    INCBIN "gfx/unknown/metasprite_17/4e4f.sprite.bin"
MetaSprite_17_4e4f_END::
MetaSprite_17_4e64::
    INCBIN "gfx/unknown/metasprite_17/4e64.sprite.bin"
MetaSprite_17_4e64_END::
MetaSprite_17_4e83::
    INCBIN "gfx/unknown/metasprite_17/4e83.sprite.bin"
MetaSprite_17_4e83_END::
MetaSprite_17_4eac::
    INCBIN "gfx/unknown/metasprite_17/4eac.sprite.bin"
MetaSprite_17_4eac_END::
MetaSprite_17_4edf::
    INCBIN "gfx/unknown/metasprite_17/4edf.sprite.bin"
MetaSprite_17_4edf_END::
MetaSprite_17_4f08::
    INCBIN "gfx/unknown/metasprite_17/4f08.sprite.bin"
MetaSprite_17_4f08_END::
MetaSprite_17_4f27::
    INCBIN "gfx/unknown/metasprite_17/4f27.sprite.bin"
MetaSprite_17_4f27_END::
MetaSprite_17_4f3c::
    INCBIN "gfx/unknown/metasprite_17/4f3c.sprite.bin"
MetaSprite_17_4f3c_END::
MetaSprite_17_4f51::
    INCBIN "gfx/unknown/metasprite_17/4f51.sprite.bin"
MetaSprite_17_4f51_END::
MetaSprite_17_4f6b::
    INCBIN "gfx/unknown/metasprite_17/4f6b.sprite.bin"
MetaSprite_17_4f6b_END::
MetaSprite_17_4f85::
    INCBIN "gfx/unknown/metasprite_17/4f85.sprite.bin"
MetaSprite_17_4f85_END::
MetaSprite_17_4fa4::
    INCBIN "gfx/unknown/metasprite_17/4fa4.sprite.bin"
MetaSprite_17_4fa4_END::
MetaSprite_17_4fbe::
    INCBIN "gfx/unknown/metasprite_17/4fbe.sprite.bin"
MetaSprite_17_4fbe_END::
MetaSprite_17_4fec::
    INCBIN "gfx/unknown/metasprite_17/4fec.sprite.bin"
MetaSprite_17_4fec_END::
MetaSprite_17_5024::
    INCBIN "gfx/unknown/metasprite_17/5024.sprite.bin"
MetaSprite_17_5024_END::
MetaSprite_17_5052::
    INCBIN "gfx/unknown/metasprite_17/5052.sprite.bin"
MetaSprite_17_5052_END::
MetaSprite_17_508a::
    INCBIN "gfx/unknown/metasprite_17/508a.sprite.bin"
MetaSprite_17_508a_END::
MetaSprite_17_50b8::
    INCBIN "gfx/unknown/metasprite_17/50b8.sprite.bin"
MetaSprite_17_50b8_END::
MetaSprite_17_50be::
    INCBIN "gfx/unknown/metasprite_17/50be.sprite.bin"
MetaSprite_17_50be_END::
MetaSprite_17_50d3::
    INCBIN "gfx/unknown/metasprite_17/50d3.sprite.bin"
MetaSprite_17_50d3_END::
MetaSprite_17_50fc::
    INCBIN "gfx/unknown/metasprite_17/50fc.sprite.bin"
MetaSprite_17_50fc_END::
MetaSprite_17_511b::
    INCBIN "gfx/unknown/metasprite_17/511b.sprite.bin"
MetaSprite_17_511b_END::
MetaSprite_17_5135::
    INCBIN "gfx/unknown/metasprite_17/5135.sprite.bin"
MetaSprite_17_5135_END::
MetaSprite_17_514f::
    INCBIN "gfx/unknown/metasprite_17/514f.sprite.bin"
MetaSprite_17_514f_END::
MetaSprite_17_516e::
    INCBIN "gfx/unknown/metasprite_17/516e.sprite.bin"
MetaSprite_17_516e_END::
MetaSprite_17_5188::
    INCBIN "gfx/unknown/metasprite_17/5188.sprite.bin"
MetaSprite_17_5188_END::
MetaSprite_17_51b6::
    INCBIN "gfx/unknown/metasprite_17/51b6.sprite.bin"
MetaSprite_17_51b6_END::
MetaSprite_17_51ee::
    INCBIN "gfx/unknown/metasprite_17/51ee.sprite.bin"
MetaSprite_17_51ee_END::
MetaSprite_17_521c::
    INCBIN "gfx/unknown/metasprite_17/521c.sprite.bin"
MetaSprite_17_521c_END::
MetaSprite_17_5254::
    INCBIN "gfx/unknown/metasprite_17/5254.sprite.bin"
MetaSprite_17_5254_END::
MetaSprite_17_5282::
    INCBIN "gfx/unknown/metasprite_17/5282.sprite.bin"
MetaSprite_17_5282_END::
MetaSprite_17_5288::
    INCBIN "gfx/unknown/metasprite_17/5288.sprite.bin"
MetaSprite_17_5288_END::
MetaSprite_17_529d::
    INCBIN "gfx/unknown/metasprite_17/529d.sprite.bin"
MetaSprite_17_529d_END::
MetaSprite_17_52c6::
    INCBIN "gfx/unknown/metasprite_17/52c6.sprite.bin"
MetaSprite_17_52c6_END::
MetaSprite_17_52e5::
    INCBIN "gfx/unknown/metasprite_17/52e5.sprite.bin"
MetaSprite_17_52e5_END::
MetaSprite_17_5336::
    INCBIN "gfx/unknown/metasprite_17/5336.sprite.bin"
MetaSprite_17_5336_END::
MetaSprite_17_537d::
    INCBIN "gfx/unknown/metasprite_17/537d.sprite.bin"
MetaSprite_17_537d_END::
MetaSprite_17_53a6::
    INCBIN "gfx/unknown/metasprite_17/53a6.sprite.bin"
MetaSprite_17_53a6_END::
MetaSprite_17_53d9::
    INCBIN "gfx/unknown/metasprite_17/53d9.sprite.bin"
MetaSprite_17_53d9_END::
MetaSprite_17_5416::
    INCBIN "gfx/unknown/metasprite_17/5416.sprite.bin"
MetaSprite_17_5416_END::
MetaSprite_17_545d::
    INCBIN "gfx/unknown/metasprite_17/545d.sprite.bin"
MetaSprite_17_545d_END::
MetaSprite_17_549a::
    INCBIN "gfx/unknown/metasprite_17/549a.sprite.bin"
MetaSprite_17_549a_END::
MetaSprite_17_54c3::
    INCBIN "gfx/unknown/metasprite_17/54c3.sprite.bin"
MetaSprite_17_54c3_END::
MetaSprite_17_5514::
    INCBIN "gfx/unknown/metasprite_17/5514.sprite.bin"
MetaSprite_17_5514_END::
MetaSprite_17_555b::
    INCBIN "gfx/unknown/metasprite_17/555b.sprite.bin"
MetaSprite_17_555b_END::
MetaSprite_17_5575::
    INCBIN "gfx/unknown/metasprite_17/5575.sprite.bin"
MetaSprite_17_5575_END::
MetaSprite_17_558f::
    INCBIN "gfx/unknown/metasprite_17/558f.sprite.bin"
MetaSprite_17_558f_END::
MetaSprite_17_55a9::
    INCBIN "gfx/unknown/metasprite_17/55a9.sprite.bin"
MetaSprite_17_55a9_END::
MetaSprite_17_55d7::
    INCBIN "gfx/unknown/metasprite_17/55d7.sprite.bin"
MetaSprite_17_55d7_END::
MetaSprite_17_5614::
    INCBIN "gfx/unknown/metasprite_17/5614.sprite.bin"
MetaSprite_17_5614_END::
MetaSprite_17_5660::
    INCBIN "gfx/unknown/metasprite_17/5660.sprite.bin"
MetaSprite_17_5660_END::
MetaSprite_17_56bb::
    INCBIN "gfx/unknown/metasprite_17/56bb.sprite.bin"
MetaSprite_17_56bb_END::
MetaSprite_17_5707::
    INCBIN "gfx/unknown/metasprite_17/5707.sprite.bin"
MetaSprite_17_5707_END::
MetaSprite_17_5735::
    INCBIN "gfx/unknown/metasprite_17/5735.sprite.bin"
MetaSprite_17_5735_END::
MetaSprite_17_574f::
    INCBIN "gfx/unknown/metasprite_17/574f.sprite.bin"
MetaSprite_17_574f_END::
MetaSprite_17_5769::
    INCBIN "gfx/unknown/metasprite_17/5769.sprite.bin"
MetaSprite_17_5769_END::
MetaSprite_17_578d::
    INCBIN "gfx/unknown/metasprite_17/578d.sprite.bin"
MetaSprite_17_578d_END::
MetaSprite_17_57c5::
    INCBIN "gfx/unknown/metasprite_17/57c5.sprite.bin"
MetaSprite_17_57c5_END::
MetaSprite_17_581b::
    INCBIN "gfx/unknown/metasprite_17/581b.sprite.bin"
MetaSprite_17_581b_END::
MetaSprite_17_5867::
    INCBIN "gfx/unknown/metasprite_17/5867.sprite.bin"
MetaSprite_17_5867_END::
MetaSprite_17_58cc::
    INCBIN "gfx/unknown/metasprite_17/58cc.sprite.bin"
MetaSprite_17_58cc_END::
MetaSprite_17_5922::
    INCBIN "gfx/unknown/metasprite_17/5922.sprite.bin"
MetaSprite_17_5922_END::
MetaSprite_17_5937::
    INCBIN "gfx/unknown/metasprite_17/5937.sprite.bin"
MetaSprite_17_5937_END::
MetaSprite_17_594c::
    INCBIN "gfx/unknown/metasprite_17/594c.sprite.bin"
MetaSprite_17_594c_END::
MetaSprite_17_5975::
    INCBIN "gfx/unknown/metasprite_17/5975.sprite.bin"
MetaSprite_17_5975_END::
MetaSprite_17_599e::
    INCBIN "gfx/unknown/metasprite_17/599e.sprite.bin"
MetaSprite_17_599e_END::
MetaSprite_17_59b8::
    INCBIN "gfx/unknown/metasprite_17/59b8.sprite.bin"
MetaSprite_17_59b8_END::
MetaSprite_17_59d2::
    INCBIN "gfx/unknown/metasprite_17/59d2.sprite.bin"
MetaSprite_17_59d2_END::
MetaSprite_17_59ec::
    INCBIN "gfx/unknown/metasprite_17/59ec.sprite.bin"
MetaSprite_17_59ec_END::
MetaSprite_17_5a15::
    INCBIN "gfx/unknown/metasprite_17/5a15.sprite.bin"
MetaSprite_17_5a15_END::
MetaSprite_17_5a52::
    INCBIN "gfx/unknown/metasprite_17/5a52.sprite.bin"
MetaSprite_17_5a52_END::
MetaSprite_17_5aa3::
    INCBIN "gfx/unknown/metasprite_17/5aa3.sprite.bin"
MetaSprite_17_5aa3_END::
MetaSprite_17_5af4::
    INCBIN "gfx/unknown/metasprite_17/5af4.sprite.bin"
MetaSprite_17_5af4_END::
MetaSprite_17_5b31::
    INCBIN "gfx/unknown/metasprite_17/5b31.sprite.bin"
MetaSprite_17_5b31_END::
MetaSprite_17_5b5a::
    INCBIN "gfx/unknown/metasprite_17/5b5a.sprite.bin"
MetaSprite_17_5b5a_END::
MetaSprite_17_5b6f::
    INCBIN "gfx/unknown/metasprite_17/5b6f.sprite.bin"
MetaSprite_17_5b6f_END::
MetaSprite_17_5b84::
    INCBIN "gfx/unknown/metasprite_17/5b84.sprite.bin"
MetaSprite_17_5b84_END::
MetaSprite_17_5bad::
    INCBIN "gfx/unknown/metasprite_17/5bad.sprite.bin"
MetaSprite_17_5bad_END::
MetaSprite_17_5bd6::
    INCBIN "gfx/unknown/metasprite_17/5bd6.sprite.bin"
MetaSprite_17_5bd6_END::
MetaSprite_17_5beb::
    INCBIN "gfx/unknown/metasprite_17/5beb.sprite.bin"
MetaSprite_17_5beb_END::
MetaSprite_17_5c00::
    INCBIN "gfx/unknown/metasprite_17/5c00.sprite.bin"
MetaSprite_17_5c00_END::
MetaSprite_17_5c06::
    INCBIN "gfx/unknown/metasprite_17/5c06.sprite.bin"
MetaSprite_17_5c06_END::
MetaSprite_17_5c0c::
    INCBIN "gfx/unknown/metasprite_17/5c0c.sprite.bin"
MetaSprite_17_5c0c_END::
MetaSprite_17_5c21::
    INCBIN "gfx/unknown/metasprite_17/5c21.sprite.bin"
MetaSprite_17_5c21_END::
MetaSprite_17_5c36::
    INCBIN "gfx/unknown/metasprite_17/5c36.sprite.bin"
MetaSprite_17_5c36_END::
MetaSprite_17_5c3c::
    INCBIN "gfx/unknown/metasprite_17/5c3c.sprite.bin"
MetaSprite_17_5c3c_END::
MetaSprite_17_5c42::
    INCBIN "gfx/unknown/metasprite_17/5c42.sprite.bin"
MetaSprite_17_5c42_END::
MetaSprite_17_5c57::
    INCBIN "gfx/unknown/metasprite_17/5c57.sprite.bin"
MetaSprite_17_5c57_END::
MetaSprite_17_5c6c::
    INCBIN "gfx/unknown/metasprite_17/5c6c.sprite.bin"
MetaSprite_17_5c6c_END::
MetaSprite_17_5c72::
    INCBIN "gfx/unknown/metasprite_17/5c72.sprite.bin"
MetaSprite_17_5c72_END::
MetaSprite_17_5c78::
    INCBIN "gfx/unknown/metasprite_17/5c78.sprite.bin"
MetaSprite_17_5c78_END::
MetaSprite_17_5c88::
    INCBIN "gfx/unknown/metasprite_17/5c88.sprite.bin"
MetaSprite_17_5c88_END::
MetaSprite_17_5ca2::
    INCBIN "gfx/unknown/metasprite_17/5ca2.sprite.bin"
MetaSprite_17_5ca2_END::
MetaSprite_17_5cc1::
    INCBIN "gfx/unknown/metasprite_17/5cc1.sprite.bin"
MetaSprite_17_5cc1_END::
MetaSprite_17_5cdb::
    INCBIN "gfx/unknown/metasprite_17/5cdb.sprite.bin"
MetaSprite_17_5cdb_END::
MetaSprite_17_5ceb::
    INCBIN "gfx/unknown/metasprite_17/5ceb.sprite.bin"
MetaSprite_17_5ceb_END::
MetaSprite_17_5d00::
    INCBIN "gfx/unknown/metasprite_17/5d00.sprite.bin"
MetaSprite_17_5d00_END::
MetaSprite_17_5d24::
    INCBIN "gfx/unknown/metasprite_17/5d24.sprite.bin"
MetaSprite_17_5d24_END::
MetaSprite_17_5d57::
    INCBIN "gfx/unknown/metasprite_17/5d57.sprite.bin"
MetaSprite_17_5d57_END::
MetaSprite_17_5d7b::
    INCBIN "gfx/unknown/metasprite_17/5d7b.sprite.bin"
MetaSprite_17_5d7b_END::
MetaSprite_17_5d90::
    INCBIN "gfx/unknown/metasprite_17/5d90.sprite.bin"
MetaSprite_17_5d90_END::
MetaSprite_17_5da5::
    INCBIN "gfx/unknown/metasprite_17/5da5.sprite.bin"
MetaSprite_17_5da5_END::
MetaSprite_17_5dba::
    INCBIN "gfx/unknown/metasprite_17/5dba.sprite.bin"
MetaSprite_17_5dba_END::
MetaSprite_17_5de3::
    INCBIN "gfx/unknown/metasprite_17/5de3.sprite.bin"
MetaSprite_17_5de3_END::
MetaSprite_17_5dfd::
    INCBIN "gfx/unknown/metasprite_17/5dfd.sprite.bin"
MetaSprite_17_5dfd_END::
MetaSprite_17_5e26::
    INCBIN "gfx/unknown/metasprite_17/5e26.sprite.bin"
MetaSprite_17_5e26_END::
MetaSprite_17_5e3b::
    INCBIN "gfx/unknown/metasprite_17/5e3b.sprite.bin"
MetaSprite_17_5e3b_END::
MetaSprite_17_5e78::
    INCBIN "gfx/unknown/metasprite_17/5e78.sprite.bin"
MetaSprite_17_5e78_END::
MetaSprite_17_5e8d::
    INCBIN "gfx/unknown/metasprite_17/5e8d.sprite.bin"
MetaSprite_17_5e8d_END::
MetaSprite_17_5ea2::
    INCBIN "gfx/unknown/metasprite_17/5ea2.sprite.bin"
MetaSprite_17_5ea2_END::
MetaSprite_17_5edf::
    INCBIN "gfx/unknown/metasprite_17/5edf.sprite.bin"
MetaSprite_17_5edf_END::
MetaSprite_17_5f1c::
    INCBIN "gfx/unknown/metasprite_17/5f1c.sprite.bin"
MetaSprite_17_5f1c_END::
MetaSprite_17_5f31::
    INCBIN "gfx/unknown/metasprite_17/5f31.sprite.bin"
MetaSprite_17_5f31_END::
MetaSprite_17_5f46::
    INCBIN "gfx/unknown/metasprite_17/5f46.sprite.bin"
MetaSprite_17_5f46_END::
MetaSprite_17_5f6f::
    INCBIN "gfx/unknown/metasprite_17/5f6f.sprite.bin"
MetaSprite_17_5f6f_END::
MetaSprite_17_5fd4::
    INCBIN "gfx/unknown/metasprite_17/5fd4.sprite.bin"
MetaSprite_17_5fd4_END::
MetaSprite_17_6025::
    INCBIN "gfx/unknown/metasprite_17/6025.sprite.bin"
MetaSprite_17_6025_END::

SECTION "MetaSprite_18", ROMX[$4000], BANK[$18]
MetaSprite_18::
    dw MetaSprite_18_4178
    dw MetaSprite_18_418d
    dw MetaSprite_18_41a2
    dw MetaSprite_18_41a8
    dw MetaSprite_18_41ae
    dw MetaSprite_18_41c3
    dw MetaSprite_18_41d8
    dw MetaSprite_18_4201
    dw MetaSprite_18_4216
    dw MetaSprite_18_422b
    dw MetaSprite_18_4231
    dw MetaSprite_18_4237
    dw MetaSprite_18_425b
    dw MetaSprite_18_427f
    dw MetaSprite_18_4285
    dw MetaSprite_18_428b
    dw MetaSprite_18_42a0
    dw MetaSprite_18_42b5
    dw MetaSprite_18_42ca
    dw MetaSprite_18_42df
    dw MetaSprite_18_42f4
    dw MetaSprite_18_4309
    dw MetaSprite_18_431e
    dw MetaSprite_18_4324
    dw MetaSprite_18_432a
    dw MetaSprite_18_4344
    dw MetaSprite_18_435e
    dw MetaSprite_18_4378
    dw MetaSprite_18_4392
    dw MetaSprite_18_43a7
    dw MetaSprite_18_43f8
    dw MetaSprite_18_4449
    dw MetaSprite_18_445e
    dw MetaSprite_18_44af
    dw MetaSprite_18_4500
    dw MetaSprite_18_4515
    dw MetaSprite_18_452a
    dw MetaSprite_18_4553
    dw MetaSprite_18_4568
    dw MetaSprite_18_45b9
    dw MetaSprite_18_460a
    dw MetaSprite_18_461f
    dw MetaSprite_18_4634
    dw MetaSprite_18_465d
    dw MetaSprite_18_4663
    dw MetaSprite_18_4678
    dw MetaSprite_18_4697
    dw MetaSprite_18_46b6
    dw MetaSprite_18_46bc
    dw MetaSprite_18_46db
    dw MetaSprite_18_46fa
    dw MetaSprite_18_4719
    dw MetaSprite_18_4724
    dw MetaSprite_18_472f
    dw MetaSprite_18_473a
    dw MetaSprite_18_4745
    dw MetaSprite_18_4764
    dw MetaSprite_18_4774
    dw MetaSprite_18_4784
    dw MetaSprite_18_4794
    dw MetaSprite_18_47a4
    dw MetaSprite_18_47af
    dw MetaSprite_18_47bf
    dw MetaSprite_18_47d4
    dw MetaSprite_18_47ee
    dw MetaSprite_18_4808
    dw MetaSprite_18_481d
    dw MetaSprite_18_4828
    dw MetaSprite_18_4865
    dw MetaSprite_18_48a2
    dw MetaSprite_18_48a8
    dw MetaSprite_18_48b3
    dw MetaSprite_18_48c3
    dw MetaSprite_18_48d3
    dw MetaSprite_18_48e3
    dw MetaSprite_18_48f3
    dw MetaSprite_18_48fe
    dw MetaSprite_18_4904
    dw MetaSprite_18_4919
    dw MetaSprite_18_4924
    dw MetaSprite_18_494d
    dw MetaSprite_18_4962
    dw MetaSprite_18_4977
    dw MetaSprite_18_498c
    dw MetaSprite_18_4997
    dw MetaSprite_18_49bb
    dw MetaSprite_18_49df
    dw MetaSprite_18_49f4
    dw MetaSprite_18_4a09
    dw MetaSprite_18_4a1e
    dw MetaSprite_18_4a33
    dw MetaSprite_18_4a48
    dw MetaSprite_18_4ac1
    dw MetaSprite_18_4b3a
    dw MetaSprite_18_4b8b
    dw MetaSprite_18_4bdc
    dw MetaSprite_18_4c05
    dw MetaSprite_18_4c4c
    dw MetaSprite_18_4cb1
    dw MetaSprite_18_4d34
    dw MetaSprite_18_4dd5
    dw MetaSprite_18_4df4
    dw MetaSprite_18_4e31
    dw MetaSprite_18_4e8c
    dw MetaSprite_18_4f05
    dw MetaSprite_18_4f9c
    dw MetaSprite_18_5051
    dw MetaSprite_18_5098
    dw MetaSprite_18_50ad
    dw MetaSprite_18_50fe
    dw MetaSprite_18_5145
    dw MetaSprite_18_515a
    dw MetaSprite_18_516f
    dw MetaSprite_18_5184
    dw MetaSprite_18_51d5
    dw MetaSprite_18_5226
    dw MetaSprite_18_5245
    dw MetaSprite_18_526e
    dw MetaSprite_18_52ab
    dw MetaSprite_18_52c0
    dw MetaSprite_18_5311
    dw MetaSprite_18_5362
    dw MetaSprite_18_5381
    dw MetaSprite_18_53aa
    dw MetaSprite_18_53e7
    dw MetaSprite_18_53fc
    dw MetaSprite_18_5425
    dw MetaSprite_18_544e
    dw MetaSprite_18_547c
    dw MetaSprite_18_5496
    dw MetaSprite_18_54ab
    dw MetaSprite_18_54d4
    dw MetaSprite_18_54fd
    dw MetaSprite_18_552b
    dw MetaSprite_18_5545
    dw MetaSprite_18_556e
    dw MetaSprite_18_5588
    dw MetaSprite_18_55a2
    dw MetaSprite_18_55bc
    dw MetaSprite_18_55d6
    dw MetaSprite_18_55f0
    dw MetaSprite_18_560a
    dw MetaSprite_18_561f
    dw MetaSprite_18_563e
    dw MetaSprite_18_5658
    dw MetaSprite_18_5672
    dw MetaSprite_18_568c
    dw MetaSprite_18_56a1
    dw MetaSprite_18_56c0
    dw MetaSprite_18_56e9
    dw MetaSprite_18_5712
    dw MetaSprite_18_5745
    dw MetaSprite_18_5764
    dw MetaSprite_18_577e
    dw MetaSprite_18_5798
    dw MetaSprite_18_57b2
    dw MetaSprite_18_57db
    dw MetaSprite_18_580e
    dw MetaSprite_18_582d
    dw MetaSprite_18_5838
    dw MetaSprite_18_584d
    dw MetaSprite_18_586c
    dw MetaSprite_18_5895
    dw MetaSprite_18_58c8
    dw MetaSprite_18_5905
    dw MetaSprite_18_5938
    dw MetaSprite_18_5961
    dw MetaSprite_18_5980
    dw MetaSprite_18_5995
    dw MetaSprite_18_59a0
    dw MetaSprite_18_59c9
    dw MetaSprite_18_59e8
    dw MetaSprite_18_59fd
    dw MetaSprite_18_5a08
    dw MetaSprite_18_5a0e
    dw MetaSprite_18_5a19
    dw MetaSprite_18_5a29
    dw MetaSprite_18_5a3e
    dw MetaSprite_18_5a58
    dw MetaSprite_18_5a77
    dw MetaSprite_18_5a91
    dw MetaSprite_18_5aa6
    dw MetaSprite_18_5ab6
    dw MetaSprite_18_5ac1
    dw MetaSprite_18_5ac7
    dw MetaSprite_18_5adc
    dw MetaSprite_18_5aec
    dw MetaSprite_18_5af7

SECTION "MetaSprite_18_4178", ROMX[$4178], BANK[$18]
MetaSprite_18_4178::
    INCBIN "gfx/unknown/metasprite_18/4178.sprite.bin"
MetaSprite_18_4178_END::
MetaSprite_18_418d::
    INCBIN "gfx/unknown/metasprite_18/418d.sprite.bin"
MetaSprite_18_418d_END::
MetaSprite_18_41a2::
    INCBIN "gfx/unknown/metasprite_18/41a2.sprite.bin"
MetaSprite_18_41a2_END::
MetaSprite_18_41a8::
    INCBIN "gfx/unknown/metasprite_18/41a8.sprite.bin"
MetaSprite_18_41a8_END::
MetaSprite_18_41ae::
    INCBIN "gfx/unknown/metasprite_18/41ae.sprite.bin"
MetaSprite_18_41ae_END::
MetaSprite_18_41c3::
    INCBIN "gfx/unknown/metasprite_18/41c3.sprite.bin"
MetaSprite_18_41c3_END::
MetaSprite_18_41d8::
    INCBIN "gfx/unknown/metasprite_18/41d8.sprite.bin"
MetaSprite_18_41d8_END::
MetaSprite_18_4201::
    INCBIN "gfx/unknown/metasprite_18/4201.sprite.bin"
MetaSprite_18_4201_END::
MetaSprite_18_4216::
    INCBIN "gfx/unknown/metasprite_18/4216.sprite.bin"
MetaSprite_18_4216_END::
MetaSprite_18_422b::
    INCBIN "gfx/unknown/metasprite_18/422b.sprite.bin"
MetaSprite_18_422b_END::
MetaSprite_18_4231::
    INCBIN "gfx/unknown/metasprite_18/4231.sprite.bin"
MetaSprite_18_4231_END::
MetaSprite_18_4237::
    INCBIN "gfx/unknown/metasprite_18/4237.sprite.bin"
MetaSprite_18_4237_END::
MetaSprite_18_425b::
    INCBIN "gfx/unknown/metasprite_18/425b.sprite.bin"
MetaSprite_18_425b_END::
MetaSprite_18_427f::
    INCBIN "gfx/unknown/metasprite_18/427f.sprite.bin"
MetaSprite_18_427f_END::
MetaSprite_18_4285::
    INCBIN "gfx/unknown/metasprite_18/4285.sprite.bin"
MetaSprite_18_4285_END::
MetaSprite_18_428b::
    INCBIN "gfx/unknown/metasprite_18/428b.sprite.bin"
MetaSprite_18_428b_END::
MetaSprite_18_42a0::
    INCBIN "gfx/unknown/metasprite_18/42a0.sprite.bin"
MetaSprite_18_42a0_END::
MetaSprite_18_42b5::
    INCBIN "gfx/unknown/metasprite_18/42b5.sprite.bin"
MetaSprite_18_42b5_END::
MetaSprite_18_42ca::
    INCBIN "gfx/unknown/metasprite_18/42ca.sprite.bin"
MetaSprite_18_42ca_END::
MetaSprite_18_42df::
    INCBIN "gfx/unknown/metasprite_18/42df.sprite.bin"
MetaSprite_18_42df_END::
MetaSprite_18_42f4::
    INCBIN "gfx/unknown/metasprite_18/42f4.sprite.bin"
MetaSprite_18_42f4_END::
MetaSprite_18_4309::
    INCBIN "gfx/unknown/metasprite_18/4309.sprite.bin"
MetaSprite_18_4309_END::
MetaSprite_18_431e::
    INCBIN "gfx/unknown/metasprite_18/431e.sprite.bin"
MetaSprite_18_431e_END::
MetaSprite_18_4324::
    INCBIN "gfx/unknown/metasprite_18/4324.sprite.bin"
MetaSprite_18_4324_END::
MetaSprite_18_432a::
    INCBIN "gfx/unknown/metasprite_18/432a.sprite.bin"
MetaSprite_18_432a_END::
MetaSprite_18_4344::
    INCBIN "gfx/unknown/metasprite_18/4344.sprite.bin"
MetaSprite_18_4344_END::
MetaSprite_18_435e::
    INCBIN "gfx/unknown/metasprite_18/435e.sprite.bin"
MetaSprite_18_435e_END::
MetaSprite_18_4378::
    INCBIN "gfx/unknown/metasprite_18/4378.sprite.bin"
MetaSprite_18_4378_END::
MetaSprite_18_4392::
    INCBIN "gfx/unknown/metasprite_18/4392.sprite.bin"
MetaSprite_18_4392_END::
MetaSprite_18_43a7::
    INCBIN "gfx/unknown/metasprite_18/43a7.sprite.bin"
MetaSprite_18_43a7_END::
MetaSprite_18_43f8::
    INCBIN "gfx/unknown/metasprite_18/43f8.sprite.bin"
MetaSprite_18_43f8_END::
MetaSprite_18_4449::
    INCBIN "gfx/unknown/metasprite_18/4449.sprite.bin"
MetaSprite_18_4449_END::
MetaSprite_18_445e::
    INCBIN "gfx/unknown/metasprite_18/445e.sprite.bin"
MetaSprite_18_445e_END::
MetaSprite_18_44af::
    INCBIN "gfx/unknown/metasprite_18/44af.sprite.bin"
MetaSprite_18_44af_END::
MetaSprite_18_4500::
    INCBIN "gfx/unknown/metasprite_18/4500.sprite.bin"
MetaSprite_18_4500_END::
MetaSprite_18_4515::
    INCBIN "gfx/unknown/metasprite_18/4515.sprite.bin"
MetaSprite_18_4515_END::
MetaSprite_18_452a::
    INCBIN "gfx/unknown/metasprite_18/452a.sprite.bin"
MetaSprite_18_452a_END::
MetaSprite_18_4553::
    INCBIN "gfx/unknown/metasprite_18/4553.sprite.bin"
MetaSprite_18_4553_END::
MetaSprite_18_4568::
    INCBIN "gfx/unknown/metasprite_18/4568.sprite.bin"
MetaSprite_18_4568_END::
MetaSprite_18_45b9::
    INCBIN "gfx/unknown/metasprite_18/45b9.sprite.bin"
MetaSprite_18_45b9_END::
MetaSprite_18_460a::
    INCBIN "gfx/unknown/metasprite_18/460a.sprite.bin"
MetaSprite_18_460a_END::
MetaSprite_18_461f::
    INCBIN "gfx/unknown/metasprite_18/461f.sprite.bin"
MetaSprite_18_461f_END::
MetaSprite_18_4634::
    INCBIN "gfx/unknown/metasprite_18/4634.sprite.bin"
MetaSprite_18_4634_END::
MetaSprite_18_465d::
    INCBIN "gfx/unknown/metasprite_18/465d.sprite.bin"
MetaSprite_18_465d_END::
MetaSprite_18_4663::
    INCBIN "gfx/unknown/metasprite_18/4663.sprite.bin"
MetaSprite_18_4663_END::
MetaSprite_18_4678::
    INCBIN "gfx/unknown/metasprite_18/4678.sprite.bin"
MetaSprite_18_4678_END::
MetaSprite_18_4697::
    INCBIN "gfx/unknown/metasprite_18/4697.sprite.bin"
MetaSprite_18_4697_END::
MetaSprite_18_46b6::
    INCBIN "gfx/unknown/metasprite_18/46b6.sprite.bin"
MetaSprite_18_46b6_END::
MetaSprite_18_46bc::
    INCBIN "gfx/unknown/metasprite_18/46bc.sprite.bin"
MetaSprite_18_46bc_END::
MetaSprite_18_46db::
    INCBIN "gfx/unknown/metasprite_18/46db.sprite.bin"
MetaSprite_18_46db_END::
MetaSprite_18_46fa::
    INCBIN "gfx/unknown/metasprite_18/46fa.sprite.bin"
MetaSprite_18_46fa_END::
MetaSprite_18_4719::
    INCBIN "gfx/unknown/metasprite_18/4719.sprite.bin"
MetaSprite_18_4719_END::
MetaSprite_18_4724::
    INCBIN "gfx/unknown/metasprite_18/4724.sprite.bin"
MetaSprite_18_4724_END::
MetaSprite_18_472f::
    INCBIN "gfx/unknown/metasprite_18/472f.sprite.bin"
MetaSprite_18_472f_END::
MetaSprite_18_473a::
    INCBIN "gfx/unknown/metasprite_18/473a.sprite.bin"
MetaSprite_18_473a_END::
MetaSprite_18_4745::
    INCBIN "gfx/unknown/metasprite_18/4745.sprite.bin"
MetaSprite_18_4745_END::
MetaSprite_18_4764::
    INCBIN "gfx/unknown/metasprite_18/4764.sprite.bin"
MetaSprite_18_4764_END::
MetaSprite_18_4774::
    INCBIN "gfx/unknown/metasprite_18/4774.sprite.bin"
MetaSprite_18_4774_END::
MetaSprite_18_4784::
    INCBIN "gfx/unknown/metasprite_18/4784.sprite.bin"
MetaSprite_18_4784_END::
MetaSprite_18_4794::
    INCBIN "gfx/unknown/metasprite_18/4794.sprite.bin"
MetaSprite_18_4794_END::
MetaSprite_18_47a4::
    INCBIN "gfx/unknown/metasprite_18/47a4.sprite.bin"
MetaSprite_18_47a4_END::
MetaSprite_18_47af::
    INCBIN "gfx/unknown/metasprite_18/47af.sprite.bin"
MetaSprite_18_47af_END::
MetaSprite_18_47bf::
    INCBIN "gfx/unknown/metasprite_18/47bf.sprite.bin"
MetaSprite_18_47bf_END::
MetaSprite_18_47d4::
    INCBIN "gfx/unknown/metasprite_18/47d4.sprite.bin"
MetaSprite_18_47d4_END::
MetaSprite_18_47ee::
    INCBIN "gfx/unknown/metasprite_18/47ee.sprite.bin"
MetaSprite_18_47ee_END::
MetaSprite_18_4808::
    INCBIN "gfx/unknown/metasprite_18/4808.sprite.bin"
MetaSprite_18_4808_END::
MetaSprite_18_481d::
    INCBIN "gfx/unknown/metasprite_18/481d.sprite.bin"
MetaSprite_18_481d_END::
MetaSprite_18_4828::
    INCBIN "gfx/unknown/metasprite_18/4828.sprite.bin"
MetaSprite_18_4828_END::
MetaSprite_18_4865::
    INCBIN "gfx/unknown/metasprite_18/4865.sprite.bin"
MetaSprite_18_4865_END::
MetaSprite_18_48a2::
    INCBIN "gfx/unknown/metasprite_18/48a2.sprite.bin"
MetaSprite_18_48a2_END::
MetaSprite_18_48a8::
    INCBIN "gfx/unknown/metasprite_18/48a8.sprite.bin"
MetaSprite_18_48a8_END::
MetaSprite_18_48b3::
    INCBIN "gfx/unknown/metasprite_18/48b3.sprite.bin"
MetaSprite_18_48b3_END::
MetaSprite_18_48c3::
    INCBIN "gfx/unknown/metasprite_18/48c3.sprite.bin"
MetaSprite_18_48c3_END::
MetaSprite_18_48d3::
    INCBIN "gfx/unknown/metasprite_18/48d3.sprite.bin"
MetaSprite_18_48d3_END::
MetaSprite_18_48e3::
    INCBIN "gfx/unknown/metasprite_18/48e3.sprite.bin"
MetaSprite_18_48e3_END::
MetaSprite_18_48f3::
    INCBIN "gfx/unknown/metasprite_18/48f3.sprite.bin"
MetaSprite_18_48f3_END::
MetaSprite_18_48fe::
    INCBIN "gfx/unknown/metasprite_18/48fe.sprite.bin"
MetaSprite_18_48fe_END::
MetaSprite_18_4904::
    INCBIN "gfx/unknown/metasprite_18/4904.sprite.bin"
MetaSprite_18_4904_END::
MetaSprite_18_4919::
    INCBIN "gfx/unknown/metasprite_18/4919.sprite.bin"
MetaSprite_18_4919_END::
MetaSprite_18_4924::
    INCBIN "gfx/unknown/metasprite_18/4924.sprite.bin"
MetaSprite_18_4924_END::
MetaSprite_18_494d::
    INCBIN "gfx/unknown/metasprite_18/494d.sprite.bin"
MetaSprite_18_494d_END::
MetaSprite_18_4962::
    INCBIN "gfx/unknown/metasprite_18/4962.sprite.bin"
MetaSprite_18_4962_END::
MetaSprite_18_4977::
    INCBIN "gfx/unknown/metasprite_18/4977.sprite.bin"
MetaSprite_18_4977_END::
MetaSprite_18_498c::
    INCBIN "gfx/unknown/metasprite_18/498c.sprite.bin"
MetaSprite_18_498c_END::
MetaSprite_18_4997::
    INCBIN "gfx/unknown/metasprite_18/4997.sprite.bin"
MetaSprite_18_4997_END::
MetaSprite_18_49bb::
    INCBIN "gfx/unknown/metasprite_18/49bb.sprite.bin"
MetaSprite_18_49bb_END::
MetaSprite_18_49df::
    INCBIN "gfx/unknown/metasprite_18/49df.sprite.bin"
MetaSprite_18_49df_END::
MetaSprite_18_49f4::
    INCBIN "gfx/unknown/metasprite_18/49f4.sprite.bin"
MetaSprite_18_49f4_END::
MetaSprite_18_4a09::
    INCBIN "gfx/unknown/metasprite_18/4a09.sprite.bin"
MetaSprite_18_4a09_END::
MetaSprite_18_4a1e::
    INCBIN "gfx/unknown/metasprite_18/4a1e.sprite.bin"
MetaSprite_18_4a1e_END::
MetaSprite_18_4a33::
    INCBIN "gfx/unknown/metasprite_18/4a33.sprite.bin"
MetaSprite_18_4a33_END::
MetaSprite_18_4a48::
    INCBIN "gfx/unknown/metasprite_18/4a48.sprite.bin"
MetaSprite_18_4a48_END::
MetaSprite_18_4ac1::
    INCBIN "gfx/unknown/metasprite_18/4ac1.sprite.bin"
MetaSprite_18_4ac1_END::
MetaSprite_18_4b3a::
    INCBIN "gfx/unknown/metasprite_18/4b3a.sprite.bin"
MetaSprite_18_4b3a_END::
MetaSprite_18_4b8b::
    INCBIN "gfx/unknown/metasprite_18/4b8b.sprite.bin"
MetaSprite_18_4b8b_END::
MetaSprite_18_4bdc::
    INCBIN "gfx/unknown/metasprite_18/4bdc.sprite.bin"
MetaSprite_18_4bdc_END::
MetaSprite_18_4c05::
    INCBIN "gfx/unknown/metasprite_18/4c05.sprite.bin"
MetaSprite_18_4c05_END::
MetaSprite_18_4c4c::
    INCBIN "gfx/unknown/metasprite_18/4c4c.sprite.bin"
MetaSprite_18_4c4c_END::
MetaSprite_18_4cb1::
    INCBIN "gfx/unknown/metasprite_18/4cb1.sprite.bin"
MetaSprite_18_4cb1_END::
MetaSprite_18_4d34::
    INCBIN "gfx/unknown/metasprite_18/4d34.sprite.bin"
MetaSprite_18_4d34_END::
MetaSprite_18_4dd5::
    INCBIN "gfx/unknown/metasprite_18/4dd5.sprite.bin"
MetaSprite_18_4dd5_END::
MetaSprite_18_4df4::
    INCBIN "gfx/unknown/metasprite_18/4df4.sprite.bin"
MetaSprite_18_4df4_END::
MetaSprite_18_4e31::
    INCBIN "gfx/unknown/metasprite_18/4e31.sprite.bin"
MetaSprite_18_4e31_END::
MetaSprite_18_4e8c::
    INCBIN "gfx/unknown/metasprite_18/4e8c.sprite.bin"
MetaSprite_18_4e8c_END::
MetaSprite_18_4f05::
    INCBIN "gfx/unknown/metasprite_18/4f05.sprite.bin"
MetaSprite_18_4f05_END::
MetaSprite_18_4f9c::
    INCBIN "gfx/unknown/metasprite_18/4f9c.sprite.bin"
MetaSprite_18_4f9c_END::
MetaSprite_18_5051::
    INCBIN "gfx/unknown/metasprite_18/5051.sprite.bin"
MetaSprite_18_5051_END::
MetaSprite_18_5098::
    INCBIN "gfx/unknown/metasprite_18/5098.sprite.bin"
MetaSprite_18_5098_END::
MetaSprite_18_50ad::
    INCBIN "gfx/unknown/metasprite_18/50ad.sprite.bin"
MetaSprite_18_50ad_END::
MetaSprite_18_50fe::
    INCBIN "gfx/unknown/metasprite_18/50fe.sprite.bin"
MetaSprite_18_50fe_END::
MetaSprite_18_5145::
    INCBIN "gfx/unknown/metasprite_18/5145.sprite.bin"
MetaSprite_18_5145_END::
MetaSprite_18_515a::
    INCBIN "gfx/unknown/metasprite_18/515a.sprite.bin"
MetaSprite_18_515a_END::
MetaSprite_18_516f::
    INCBIN "gfx/unknown/metasprite_18/516f.sprite.bin"
MetaSprite_18_516f_END::
MetaSprite_18_5184::
    INCBIN "gfx/unknown/metasprite_18/5184.sprite.bin"
MetaSprite_18_5184_END::
MetaSprite_18_51d5::
    INCBIN "gfx/unknown/metasprite_18/51d5.sprite.bin"
MetaSprite_18_51d5_END::
MetaSprite_18_5226::
    INCBIN "gfx/unknown/metasprite_18/5226.sprite.bin"
MetaSprite_18_5226_END::
MetaSprite_18_5245::
    INCBIN "gfx/unknown/metasprite_18/5245.sprite.bin"
MetaSprite_18_5245_END::
MetaSprite_18_526e::
    INCBIN "gfx/unknown/metasprite_18/526e.sprite.bin"
MetaSprite_18_526e_END::
MetaSprite_18_52ab::
    INCBIN "gfx/unknown/metasprite_18/52ab.sprite.bin"
MetaSprite_18_52ab_END::
MetaSprite_18_52c0::
    INCBIN "gfx/unknown/metasprite_18/52c0.sprite.bin"
MetaSprite_18_52c0_END::
MetaSprite_18_5311::
    INCBIN "gfx/unknown/metasprite_18/5311.sprite.bin"
MetaSprite_18_5311_END::
MetaSprite_18_5362::
    INCBIN "gfx/unknown/metasprite_18/5362.sprite.bin"
MetaSprite_18_5362_END::
MetaSprite_18_5381::
    INCBIN "gfx/unknown/metasprite_18/5381.sprite.bin"
MetaSprite_18_5381_END::
MetaSprite_18_53aa::
    INCBIN "gfx/unknown/metasprite_18/53aa.sprite.bin"
MetaSprite_18_53aa_END::
MetaSprite_18_53e7::
    INCBIN "gfx/unknown/metasprite_18/53e7.sprite.bin"
MetaSprite_18_53e7_END::
MetaSprite_18_53fc::
    INCBIN "gfx/unknown/metasprite_18/53fc.sprite.bin"
MetaSprite_18_53fc_END::
MetaSprite_18_5425::
    INCBIN "gfx/unknown/metasprite_18/5425.sprite.bin"
MetaSprite_18_5425_END::
MetaSprite_18_544e::
    INCBIN "gfx/unknown/metasprite_18/544e.sprite.bin"
MetaSprite_18_544e_END::
MetaSprite_18_547c::
    INCBIN "gfx/unknown/metasprite_18/547c.sprite.bin"
MetaSprite_18_547c_END::
MetaSprite_18_5496::
    INCBIN "gfx/unknown/metasprite_18/5496.sprite.bin"
MetaSprite_18_5496_END::
MetaSprite_18_54ab::
    INCBIN "gfx/unknown/metasprite_18/54ab.sprite.bin"
MetaSprite_18_54ab_END::
MetaSprite_18_54d4::
    INCBIN "gfx/unknown/metasprite_18/54d4.sprite.bin"
MetaSprite_18_54d4_END::
MetaSprite_18_54fd::
    INCBIN "gfx/unknown/metasprite_18/54fd.sprite.bin"
MetaSprite_18_54fd_END::
MetaSprite_18_552b::
    INCBIN "gfx/unknown/metasprite_18/552b.sprite.bin"
MetaSprite_18_552b_END::
MetaSprite_18_5545::
    INCBIN "gfx/unknown/metasprite_18/5545.sprite.bin"
MetaSprite_18_5545_END::
MetaSprite_18_556e::
    INCBIN "gfx/unknown/metasprite_18/556e.sprite.bin"
MetaSprite_18_556e_END::
MetaSprite_18_5588::
    INCBIN "gfx/unknown/metasprite_18/5588.sprite.bin"
MetaSprite_18_5588_END::
MetaSprite_18_55a2::
    INCBIN "gfx/unknown/metasprite_18/55a2.sprite.bin"
MetaSprite_18_55a2_END::
MetaSprite_18_55bc::
    INCBIN "gfx/unknown/metasprite_18/55bc.sprite.bin"
MetaSprite_18_55bc_END::
MetaSprite_18_55d6::
    INCBIN "gfx/unknown/metasprite_18/55d6.sprite.bin"
MetaSprite_18_55d6_END::
MetaSprite_18_55f0::
    INCBIN "gfx/unknown/metasprite_18/55f0.sprite.bin"
MetaSprite_18_55f0_END::
MetaSprite_18_560a::
    INCBIN "gfx/unknown/metasprite_18/560a.sprite.bin"
MetaSprite_18_560a_END::
MetaSprite_18_561f::
    INCBIN "gfx/unknown/metasprite_18/561f.sprite.bin"
MetaSprite_18_561f_END::
MetaSprite_18_563e::
    INCBIN "gfx/unknown/metasprite_18/563e.sprite.bin"
MetaSprite_18_563e_END::
MetaSprite_18_5658::
    INCBIN "gfx/unknown/metasprite_18/5658.sprite.bin"
MetaSprite_18_5658_END::
MetaSprite_18_5672::
    INCBIN "gfx/unknown/metasprite_18/5672.sprite.bin"
MetaSprite_18_5672_END::
MetaSprite_18_568c::
    INCBIN "gfx/unknown/metasprite_18/568c.sprite.bin"
MetaSprite_18_568c_END::
MetaSprite_18_56a1::
    INCBIN "gfx/unknown/metasprite_18/56a1.sprite.bin"
MetaSprite_18_56a1_END::
MetaSprite_18_56c0::
    INCBIN "gfx/unknown/metasprite_18/56c0.sprite.bin"
MetaSprite_18_56c0_END::
MetaSprite_18_56e9::
    INCBIN "gfx/unknown/metasprite_18/56e9.sprite.bin"
MetaSprite_18_56e9_END::
MetaSprite_18_5712::
    INCBIN "gfx/unknown/metasprite_18/5712.sprite.bin"
MetaSprite_18_5712_END::
MetaSprite_18_5745::
    INCBIN "gfx/unknown/metasprite_18/5745.sprite.bin"
MetaSprite_18_5745_END::
MetaSprite_18_5764::
    INCBIN "gfx/unknown/metasprite_18/5764.sprite.bin"
MetaSprite_18_5764_END::
MetaSprite_18_577e::
    INCBIN "gfx/unknown/metasprite_18/577e.sprite.bin"
MetaSprite_18_577e_END::
MetaSprite_18_5798::
    INCBIN "gfx/unknown/metasprite_18/5798.sprite.bin"
MetaSprite_18_5798_END::
MetaSprite_18_57b2::
    INCBIN "gfx/unknown/metasprite_18/57b2.sprite.bin"
MetaSprite_18_57b2_END::
MetaSprite_18_57db::
    INCBIN "gfx/unknown/metasprite_18/57db.sprite.bin"
MetaSprite_18_57db_END::
MetaSprite_18_580e::
    INCBIN "gfx/unknown/metasprite_18/580e.sprite.bin"
MetaSprite_18_580e_END::
MetaSprite_18_582d::
    INCBIN "gfx/unknown/metasprite_18/582d.sprite.bin"
MetaSprite_18_582d_END::
MetaSprite_18_5838::
    INCBIN "gfx/unknown/metasprite_18/5838.sprite.bin"
MetaSprite_18_5838_END::
MetaSprite_18_584d::
    INCBIN "gfx/unknown/metasprite_18/584d.sprite.bin"
MetaSprite_18_584d_END::
MetaSprite_18_586c::
    INCBIN "gfx/unknown/metasprite_18/586c.sprite.bin"
MetaSprite_18_586c_END::
MetaSprite_18_5895::
    INCBIN "gfx/unknown/metasprite_18/5895.sprite.bin"
MetaSprite_18_5895_END::
MetaSprite_18_58c8::
    INCBIN "gfx/unknown/metasprite_18/58c8.sprite.bin"
MetaSprite_18_58c8_END::
MetaSprite_18_5905::
    INCBIN "gfx/unknown/metasprite_18/5905.sprite.bin"
MetaSprite_18_5905_END::
MetaSprite_18_5938::
    INCBIN "gfx/unknown/metasprite_18/5938.sprite.bin"
MetaSprite_18_5938_END::
MetaSprite_18_5961::
    INCBIN "gfx/unknown/metasprite_18/5961.sprite.bin"
MetaSprite_18_5961_END::
MetaSprite_18_5980::
    INCBIN "gfx/unknown/metasprite_18/5980.sprite.bin"
MetaSprite_18_5980_END::
MetaSprite_18_5995::
    INCBIN "gfx/unknown/metasprite_18/5995.sprite.bin"
MetaSprite_18_5995_END::
MetaSprite_18_59a0::
    INCBIN "gfx/unknown/metasprite_18/59a0.sprite.bin"
MetaSprite_18_59a0_END::
MetaSprite_18_59c9::
    INCBIN "gfx/unknown/metasprite_18/59c9.sprite.bin"
MetaSprite_18_59c9_END::
MetaSprite_18_59e8::
    INCBIN "gfx/unknown/metasprite_18/59e8.sprite.bin"
MetaSprite_18_59e8_END::
MetaSprite_18_59fd::
    INCBIN "gfx/unknown/metasprite_18/59fd.sprite.bin"
MetaSprite_18_59fd_END::
MetaSprite_18_5a08::
    INCBIN "gfx/unknown/metasprite_18/5a08.sprite.bin"
MetaSprite_18_5a08_END::
MetaSprite_18_5a0e::
    INCBIN "gfx/unknown/metasprite_18/5a0e.sprite.bin"
MetaSprite_18_5a0e_END::
MetaSprite_18_5a19::
    INCBIN "gfx/unknown/metasprite_18/5a19.sprite.bin"
MetaSprite_18_5a19_END::
MetaSprite_18_5a29::
    INCBIN "gfx/unknown/metasprite_18/5a29.sprite.bin"
MetaSprite_18_5a29_END::
MetaSprite_18_5a3e::
    INCBIN "gfx/unknown/metasprite_18/5a3e.sprite.bin"
MetaSprite_18_5a3e_END::
MetaSprite_18_5a58::
    INCBIN "gfx/unknown/metasprite_18/5a58.sprite.bin"
MetaSprite_18_5a58_END::
MetaSprite_18_5a77::
    INCBIN "gfx/unknown/metasprite_18/5a77.sprite.bin"
MetaSprite_18_5a77_END::
MetaSprite_18_5a91::
    INCBIN "gfx/unknown/metasprite_18/5a91.sprite.bin"
MetaSprite_18_5a91_END::
MetaSprite_18_5aa6::
    INCBIN "gfx/unknown/metasprite_18/5aa6.sprite.bin"
MetaSprite_18_5aa6_END::
MetaSprite_18_5ab6::
    INCBIN "gfx/unknown/metasprite_18/5ab6.sprite.bin"
MetaSprite_18_5ab6_END::
MetaSprite_18_5ac1::
    INCBIN "gfx/unknown/metasprite_18/5ac1.sprite.bin"
MetaSprite_18_5ac1_END::
MetaSprite_18_5ac7::
    INCBIN "gfx/unknown/metasprite_18/5ac7.sprite.bin"
MetaSprite_18_5ac7_END::
MetaSprite_18_5adc::
    INCBIN "gfx/unknown/metasprite_18/5adc.sprite.bin"
MetaSprite_18_5adc_END::
MetaSprite_18_5aec::
    INCBIN "gfx/unknown/metasprite_18/5aec.sprite.bin"
MetaSprite_18_5aec_END::
MetaSprite_18_5af7::
    INCBIN "gfx/unknown/metasprite_18/5af7.sprite.bin"
MetaSprite_18_5af7_END::

SECTION "MetaSprite_19", ROMX[$4000], BANK[$19]
MetaSprite_19::
    dw MetaSprite_19_4162
    dw MetaSprite_19_4168
    dw MetaSprite_19_417d
    dw MetaSprite_19_41a1
    dw MetaSprite_19_41b6
    dw MetaSprite_19_41e4
    dw MetaSprite_19_420d
    dw MetaSprite_19_424a
    dw MetaSprite_19_429b
    dw MetaSprite_19_4300
    dw MetaSprite_19_4365
    dw MetaSprite_19_43b6
    dw MetaSprite_19_43f3
    dw MetaSprite_19_441c
    dw MetaSprite_19_4445
    dw MetaSprite_19_4482
    dw MetaSprite_19_44d3
    dw MetaSprite_19_4538
    dw MetaSprite_19_459d
    dw MetaSprite_19_45ee
    dw MetaSprite_19_462b
    dw MetaSprite_19_4654
    dw MetaSprite_19_467d
    dw MetaSprite_19_46ba
    dw MetaSprite_19_470b
    dw MetaSprite_19_4770
    dw MetaSprite_19_47d5
    dw MetaSprite_19_4826
    dw MetaSprite_19_4863
    dw MetaSprite_19_488c
    dw MetaSprite_19_4897
    dw MetaSprite_19_48c0
    dw MetaSprite_19_48e9
    dw MetaSprite_19_4962
    dw MetaSprite_19_49db
    dw MetaSprite_19_49e6
    dw MetaSprite_19_4a0f
    dw MetaSprite_19_4a38
    dw MetaSprite_19_4a6b
    dw MetaSprite_19_4a9e
    dw MetaSprite_19_4ab3
    dw MetaSprite_19_4ac8
    dw MetaSprite_19_4add
    dw MetaSprite_19_4af2
    dw MetaSprite_19_4b07
    dw MetaSprite_19_4b3a
    dw MetaSprite_19_4b6d
    dw MetaSprite_19_4b82
    dw MetaSprite_19_4b97
    dw MetaSprite_19_4bac
    dw MetaSprite_19_4bb7
    dw MetaSprite_19_4be0
    dw MetaSprite_19_4c09
    dw MetaSprite_19_4c3c
    dw MetaSprite_19_4c6f
    dw MetaSprite_19_4c84
    dw MetaSprite_19_4cad
    dw MetaSprite_19_4cd6
    dw MetaSprite_19_4cff
    dw MetaSprite_19_4d28
    dw MetaSprite_19_4d2e
    dw MetaSprite_19_4d43
    dw MetaSprite_19_4d58
    dw MetaSprite_19_4d6d
    dw MetaSprite_19_4d96
    dw MetaSprite_19_4dab
    dw MetaSprite_19_4dc0
    dw MetaSprite_19_4dd5
    dw MetaSprite_19_4dea
    dw MetaSprite_19_4e13
    dw MetaSprite_19_4e19
    dw MetaSprite_19_4e2e
    dw MetaSprite_19_4e43
    dw MetaSprite_19_4e6c
    dw MetaSprite_19_4e9f
    dw MetaSprite_19_4ed2
    dw MetaSprite_19_4ee7
    dw MetaSprite_19_4efc
    dw MetaSprite_19_4f07
    dw MetaSprite_19_4f0d
    dw MetaSprite_19_4f1d
    dw MetaSprite_19_4f50
    dw MetaSprite_19_4f5b
    dw MetaSprite_19_4f7a
    dw MetaSprite_19_4fad
    dw MetaSprite_19_4fe0
    dw MetaSprite_19_5013
    dw MetaSprite_19_5028
    dw MetaSprite_19_503d
    dw MetaSprite_19_5052
    dw MetaSprite_19_5067
    dw MetaSprite_19_509a
    dw MetaSprite_19_50cd
    dw MetaSprite_19_50d3
    dw MetaSprite_19_5106
    dw MetaSprite_19_5139
    dw MetaSprite_19_5162
    dw MetaSprite_19_519f
    dw MetaSprite_19_51f0
    dw MetaSprite_19_5255
    dw MetaSprite_19_52ba
    dw MetaSprite_19_530b
    dw MetaSprite_19_5348
    dw MetaSprite_19_5371
    dw MetaSprite_19_5386
    dw MetaSprite_19_539b
    dw MetaSprite_19_53b0
    dw MetaSprite_19_53c5
    dw MetaSprite_19_53ee
    dw MetaSprite_19_542b
    dw MetaSprite_19_547c
    dw MetaSprite_19_54e1
    dw MetaSprite_19_5546
    dw MetaSprite_19_5597
    dw MetaSprite_19_55d4
    dw MetaSprite_19_55fd
    dw MetaSprite_19_5612
    dw MetaSprite_19_563b
    dw MetaSprite_19_5664
    dw MetaSprite_19_568d
    dw MetaSprite_19_56a2
    dw MetaSprite_19_571b
    dw MetaSprite_19_5794
    dw MetaSprite_19_57c7
    dw MetaSprite_19_57dc
    dw MetaSprite_19_57f1
    dw MetaSprite_19_5806
    dw MetaSprite_19_581b
    dw MetaSprite_19_5867
    dw MetaSprite_19_58e0
    dw MetaSprite_19_5959
    dw MetaSprite_19_596e
    dw MetaSprite_19_5983
    dw MetaSprite_19_59fc
    dw MetaSprite_19_5a75
    dw MetaSprite_19_5a8a
    dw MetaSprite_19_5b03
    dw MetaSprite_19_5b7c
    dw MetaSprite_19_5b91
    dw MetaSprite_19_5bba
    dw MetaSprite_19_5be3
    dw MetaSprite_19_5c0c
    dw MetaSprite_19_5c35
    dw MetaSprite_19_5c5e
    dw MetaSprite_19_5c9b
    dw MetaSprite_19_5cec
    dw MetaSprite_19_5d51
    dw MetaSprite_19_5db6
    dw MetaSprite_19_5e07
    dw MetaSprite_19_5e44
    dw MetaSprite_19_5e6d
    dw MetaSprite_19_5e82
    dw MetaSprite_19_5e97
    dw MetaSprite_19_5eb6
    dw MetaSprite_19_5efd
    dw MetaSprite_19_5f03
    dw MetaSprite_19_5f0e
    dw MetaSprite_19_5f1e
    dw MetaSprite_19_5f33
    dw MetaSprite_19_5f4d
    dw MetaSprite_19_5f53
    dw MetaSprite_19_5f72
    dw MetaSprite_19_5f78
    dw MetaSprite_19_5f8d
    dw MetaSprite_19_5fa2
    dw MetaSprite_19_5fc6
    dw MetaSprite_19_5fcc
    dw MetaSprite_19_5fd2
    dw MetaSprite_19_5fd8
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5fde
    dw MetaSprite_19_5ff3
    dw MetaSprite_19_6008
    dw MetaSprite_zukan_denjuu_name

MetaSprite_19_4162::
    INCBIN "gfx/unknown/metasprite_19/4162.sprite.bin"
MetaSprite_19_4162_END::
MetaSprite_19_4168::
    INCBIN "gfx/unknown/metasprite_19/4168.sprite.bin"
MetaSprite_19_4168_END::
MetaSprite_19_417d::
    INCBIN "gfx/unknown/metasprite_19/417d.sprite.bin"
MetaSprite_19_417d_END::
MetaSprite_19_41a1::
    INCBIN "gfx/unknown/metasprite_19/41a1.sprite.bin"
MetaSprite_19_41a1_END::
MetaSprite_19_41b6::
    INCBIN "gfx/unknown/metasprite_19/41b6.sprite.bin"
MetaSprite_19_41b6_END::
MetaSprite_19_41e4::
    INCBIN "gfx/unknown/metasprite_19/41e4.sprite.bin"
MetaSprite_19_41e4_END::
MetaSprite_19_420d::
    INCBIN "gfx/unknown/metasprite_19/420d.sprite.bin"
MetaSprite_19_420d_END::
MetaSprite_19_424a::
    INCBIN "gfx/unknown/metasprite_19/424a.sprite.bin"
MetaSprite_19_424a_END::
MetaSprite_19_429b::
    INCBIN "gfx/unknown/metasprite_19/429b.sprite.bin"
MetaSprite_19_429b_END::
MetaSprite_19_4300::
    INCBIN "gfx/unknown/metasprite_19/4300.sprite.bin"
MetaSprite_19_4300_END::
MetaSprite_19_4365::
    INCBIN "gfx/unknown/metasprite_19/4365.sprite.bin"
MetaSprite_19_4365_END::
MetaSprite_19_43b6::
    INCBIN "gfx/unknown/metasprite_19/43b6.sprite.bin"
MetaSprite_19_43b6_END::
MetaSprite_19_43f3::
    INCBIN "gfx/unknown/metasprite_19/43f3.sprite.bin"
MetaSprite_19_43f3_END::
MetaSprite_19_441c::
    INCBIN "gfx/unknown/metasprite_19/441c.sprite.bin"
MetaSprite_19_441c_END::
MetaSprite_19_4445::
    INCBIN "gfx/unknown/metasprite_19/4445.sprite.bin"
MetaSprite_19_4445_END::
MetaSprite_19_4482::
    INCBIN "gfx/unknown/metasprite_19/4482.sprite.bin"
MetaSprite_19_4482_END::
MetaSprite_19_44d3::
    INCBIN "gfx/unknown/metasprite_19/44d3.sprite.bin"
MetaSprite_19_44d3_END::
MetaSprite_19_4538::
    INCBIN "gfx/unknown/metasprite_19/4538.sprite.bin"
MetaSprite_19_4538_END::
MetaSprite_19_459d::
    INCBIN "gfx/unknown/metasprite_19/459d.sprite.bin"
MetaSprite_19_459d_END::
MetaSprite_19_45ee::
    INCBIN "gfx/unknown/metasprite_19/45ee.sprite.bin"
MetaSprite_19_45ee_END::
MetaSprite_19_462b::
    INCBIN "gfx/unknown/metasprite_19/462b.sprite.bin"
MetaSprite_19_462b_END::
MetaSprite_19_4654::
    INCBIN "gfx/unknown/metasprite_19/4654.sprite.bin"
MetaSprite_19_4654_END::
MetaSprite_19_467d::
    INCBIN "gfx/unknown/metasprite_19/467d.sprite.bin"
MetaSprite_19_467d_END::
MetaSprite_19_46ba::
    INCBIN "gfx/unknown/metasprite_19/46ba.sprite.bin"
MetaSprite_19_46ba_END::
MetaSprite_19_470b::
    INCBIN "gfx/unknown/metasprite_19/470b.sprite.bin"
MetaSprite_19_470b_END::
MetaSprite_19_4770::
    INCBIN "gfx/unknown/metasprite_19/4770.sprite.bin"
MetaSprite_19_4770_END::
MetaSprite_19_47d5::
    INCBIN "gfx/unknown/metasprite_19/47d5.sprite.bin"
MetaSprite_19_47d5_END::
MetaSprite_19_4826::
    INCBIN "gfx/unknown/metasprite_19/4826.sprite.bin"
MetaSprite_19_4826_END::
MetaSprite_19_4863::
    INCBIN "gfx/unknown/metasprite_19/4863.sprite.bin"
MetaSprite_19_4863_END::
MetaSprite_19_488c::
    INCBIN "gfx/unknown/metasprite_19/488c.sprite.bin"
MetaSprite_19_488c_END::
MetaSprite_19_4897::
    INCBIN "gfx/unknown/metasprite_19/4897.sprite.bin"
MetaSprite_19_4897_END::
MetaSprite_19_48c0::
    INCBIN "gfx/unknown/metasprite_19/48c0.sprite.bin"
MetaSprite_19_48c0_END::
MetaSprite_19_48e9::
    INCBIN "gfx/unknown/metasprite_19/48e9.sprite.bin"
MetaSprite_19_48e9_END::
MetaSprite_19_4962::
    INCBIN "gfx/unknown/metasprite_19/4962.sprite.bin"
MetaSprite_19_4962_END::
MetaSprite_19_49db::
    INCBIN "gfx/unknown/metasprite_19/49db.sprite.bin"
MetaSprite_19_49db_END::
MetaSprite_19_49e6::
    INCBIN "gfx/unknown/metasprite_19/49e6.sprite.bin"
MetaSprite_19_49e6_END::
MetaSprite_19_4a0f::
    INCBIN "gfx/unknown/metasprite_19/4a0f.sprite.bin"
MetaSprite_19_4a0f_END::
MetaSprite_19_4a38::
    INCBIN "gfx/unknown/metasprite_19/4a38.sprite.bin"
MetaSprite_19_4a38_END::
MetaSprite_19_4a6b::
    INCBIN "gfx/unknown/metasprite_19/4a6b.sprite.bin"
MetaSprite_19_4a6b_END::
MetaSprite_19_4a9e::
    INCBIN "gfx/unknown/metasprite_19/4a9e.sprite.bin"
MetaSprite_19_4a9e_END::
MetaSprite_19_4ab3::
    INCBIN "gfx/unknown/metasprite_19/4ab3.sprite.bin"
MetaSprite_19_4ab3_END::
MetaSprite_19_4ac8::
    INCBIN "gfx/unknown/metasprite_19/4ac8.sprite.bin"
MetaSprite_19_4ac8_END::
MetaSprite_19_4add::
    INCBIN "gfx/unknown/metasprite_19/4add.sprite.bin"
MetaSprite_19_4add_END::
MetaSprite_19_4af2::
    INCBIN "gfx/unknown/metasprite_19/4af2.sprite.bin"
MetaSprite_19_4af2_END::
MetaSprite_19_4b07::
    INCBIN "gfx/unknown/metasprite_19/4b07.sprite.bin"
MetaSprite_19_4b07_END::
MetaSprite_19_4b3a::
    INCBIN "gfx/unknown/metasprite_19/4b3a.sprite.bin"
MetaSprite_19_4b3a_END::
MetaSprite_19_4b6d::
    INCBIN "gfx/unknown/metasprite_19/4b6d.sprite.bin"
MetaSprite_19_4b6d_END::
MetaSprite_19_4b82::
    INCBIN "gfx/unknown/metasprite_19/4b82.sprite.bin"
MetaSprite_19_4b82_END::
MetaSprite_19_4b97::
    INCBIN "gfx/unknown/metasprite_19/4b97.sprite.bin"
MetaSprite_19_4b97_END::
MetaSprite_19_4bac::
    INCBIN "gfx/unknown/metasprite_19/4bac.sprite.bin"
MetaSprite_19_4bac_END::
MetaSprite_19_4bb7::
    INCBIN "gfx/unknown/metasprite_19/4bb7.sprite.bin"
MetaSprite_19_4bb7_END::
MetaSprite_19_4be0::
    INCBIN "gfx/unknown/metasprite_19/4be0.sprite.bin"
MetaSprite_19_4be0_END::
MetaSprite_19_4c09::
    INCBIN "gfx/unknown/metasprite_19/4c09.sprite.bin"
MetaSprite_19_4c09_END::
MetaSprite_19_4c3c::
    INCBIN "gfx/unknown/metasprite_19/4c3c.sprite.bin"
MetaSprite_19_4c3c_END::
MetaSprite_19_4c6f::
    INCBIN "gfx/unknown/metasprite_19/4c6f.sprite.bin"
MetaSprite_19_4c6f_END::
MetaSprite_19_4c84::
    INCBIN "gfx/unknown/metasprite_19/4c84.sprite.bin"
MetaSprite_19_4c84_END::
MetaSprite_19_4cad::
    INCBIN "gfx/unknown/metasprite_19/4cad.sprite.bin"
MetaSprite_19_4cad_END::
MetaSprite_19_4cd6::
    INCBIN "gfx/unknown/metasprite_19/4cd6.sprite.bin"
MetaSprite_19_4cd6_END::
MetaSprite_19_4cff::
    INCBIN "gfx/unknown/metasprite_19/4cff.sprite.bin"
MetaSprite_19_4cff_END::
MetaSprite_19_4d28::
    INCBIN "gfx/unknown/metasprite_19/4d28.sprite.bin"
MetaSprite_19_4d28_END::
MetaSprite_19_4d2e::
    INCBIN "gfx/unknown/metasprite_19/4d2e.sprite.bin"
MetaSprite_19_4d2e_END::
MetaSprite_19_4d43::
    INCBIN "gfx/unknown/metasprite_19/4d43.sprite.bin"
MetaSprite_19_4d43_END::
MetaSprite_19_4d58::
    INCBIN "gfx/unknown/metasprite_19/4d58.sprite.bin"
MetaSprite_19_4d58_END::
MetaSprite_19_4d6d::
    INCBIN "gfx/unknown/metasprite_19/4d6d.sprite.bin"
MetaSprite_19_4d6d_END::
MetaSprite_19_4d96::
    INCBIN "gfx/unknown/metasprite_19/4d96.sprite.bin"
MetaSprite_19_4d96_END::
MetaSprite_19_4dab::
    INCBIN "gfx/unknown/metasprite_19/4dab.sprite.bin"
MetaSprite_19_4dab_END::
MetaSprite_19_4dc0::
    INCBIN "gfx/unknown/metasprite_19/4dc0.sprite.bin"
MetaSprite_19_4dc0_END::
MetaSprite_19_4dd5::
    INCBIN "gfx/unknown/metasprite_19/4dd5.sprite.bin"
MetaSprite_19_4dd5_END::
MetaSprite_19_4dea::
    INCBIN "gfx/unknown/metasprite_19/4dea.sprite.bin"
MetaSprite_19_4dea_END::
MetaSprite_19_4e13::
    INCBIN "gfx/unknown/metasprite_19/4e13.sprite.bin"
MetaSprite_19_4e13_END::
MetaSprite_19_4e19::
    INCBIN "gfx/unknown/metasprite_19/4e19.sprite.bin"
MetaSprite_19_4e19_END::
MetaSprite_19_4e2e::
    INCBIN "gfx/unknown/metasprite_19/4e2e.sprite.bin"
MetaSprite_19_4e2e_END::
MetaSprite_19_4e43::
    INCBIN "gfx/unknown/metasprite_19/4e43.sprite.bin"
MetaSprite_19_4e43_END::
MetaSprite_19_4e6c::
    INCBIN "gfx/unknown/metasprite_19/4e6c.sprite.bin"
MetaSprite_19_4e6c_END::
MetaSprite_19_4e9f::
    INCBIN "gfx/unknown/metasprite_19/4e9f.sprite.bin"
MetaSprite_19_4e9f_END::
MetaSprite_19_4ed2::
    INCBIN "gfx/unknown/metasprite_19/4ed2.sprite.bin"
MetaSprite_19_4ed2_END::
MetaSprite_19_4ee7::
    INCBIN "gfx/unknown/metasprite_19/4ee7.sprite.bin"
MetaSprite_19_4ee7_END::
MetaSprite_19_4efc::
    INCBIN "gfx/unknown/metasprite_19/4efc.sprite.bin"
MetaSprite_19_4efc_END::
MetaSprite_19_4f07::
    INCBIN "gfx/unknown/metasprite_19/4f07.sprite.bin"
MetaSprite_19_4f07_END::
MetaSprite_19_4f0d::
    INCBIN "gfx/unknown/metasprite_19/4f0d.sprite.bin"
MetaSprite_19_4f0d_END::
MetaSprite_19_4f1d::
    INCBIN "gfx/unknown/metasprite_19/4f1d.sprite.bin"
MetaSprite_19_4f1d_END::
MetaSprite_19_4f50::
    INCBIN "gfx/unknown/metasprite_19/4f50.sprite.bin"
MetaSprite_19_4f50_END::
MetaSprite_19_4f5b::
    INCBIN "gfx/unknown/metasprite_19/4f5b.sprite.bin"
MetaSprite_19_4f5b_END::
MetaSprite_19_4f7a::
    INCBIN "gfx/unknown/metasprite_19/4f7a.sprite.bin"
MetaSprite_19_4f7a_END::
MetaSprite_19_4fad::
    INCBIN "gfx/unknown/metasprite_19/4fad.sprite.bin"
MetaSprite_19_4fad_END::
MetaSprite_19_4fe0::
    INCBIN "gfx/unknown/metasprite_19/4fe0.sprite.bin"
MetaSprite_19_4fe0_END::
MetaSprite_19_5013::
    INCBIN "gfx/unknown/metasprite_19/5013.sprite.bin"
MetaSprite_19_5013_END::
MetaSprite_19_5028::
    INCBIN "gfx/unknown/metasprite_19/5028.sprite.bin"
MetaSprite_19_5028_END::
MetaSprite_19_503d::
    INCBIN "gfx/unknown/metasprite_19/503d.sprite.bin"
MetaSprite_19_503d_END::
MetaSprite_19_5052::
    INCBIN "gfx/unknown/metasprite_19/5052.sprite.bin"
MetaSprite_19_5052_END::
MetaSprite_19_5067::
    INCBIN "gfx/unknown/metasprite_19/5067.sprite.bin"
MetaSprite_19_5067_END::
MetaSprite_19_509a::
    INCBIN "gfx/unknown/metasprite_19/509a.sprite.bin"
MetaSprite_19_509a_END::
MetaSprite_19_50cd::
    INCBIN "gfx/unknown/metasprite_19/50cd.sprite.bin"
MetaSprite_19_50cd_END::
MetaSprite_19_50d3::
    INCBIN "gfx/unknown/metasprite_19/50d3.sprite.bin"
MetaSprite_19_50d3_END::
MetaSprite_19_5106::
    INCBIN "gfx/unknown/metasprite_19/5106.sprite.bin"
MetaSprite_19_5106_END::
MetaSprite_19_5139::
    INCBIN "gfx/unknown/metasprite_19/5139.sprite.bin"
MetaSprite_19_5139_END::
MetaSprite_19_5162::
    INCBIN "gfx/unknown/metasprite_19/5162.sprite.bin"
MetaSprite_19_5162_END::
MetaSprite_19_519f::
    INCBIN "gfx/unknown/metasprite_19/519f.sprite.bin"
MetaSprite_19_519f_END::
MetaSprite_19_51f0::
    INCBIN "gfx/unknown/metasprite_19/51f0.sprite.bin"
MetaSprite_19_51f0_END::
MetaSprite_19_5255::
    INCBIN "gfx/unknown/metasprite_19/5255.sprite.bin"
MetaSprite_19_5255_END::
MetaSprite_19_52ba::
    INCBIN "gfx/unknown/metasprite_19/52ba.sprite.bin"
MetaSprite_19_52ba_END::
MetaSprite_19_530b::
    INCBIN "gfx/unknown/metasprite_19/530b.sprite.bin"
MetaSprite_19_530b_END::
MetaSprite_19_5348::
    INCBIN "gfx/unknown/metasprite_19/5348.sprite.bin"
MetaSprite_19_5348_END::
MetaSprite_19_5371::
    INCBIN "gfx/unknown/metasprite_19/5371.sprite.bin"
MetaSprite_19_5371_END::
MetaSprite_19_5386::
    INCBIN "gfx/unknown/metasprite_19/5386.sprite.bin"
MetaSprite_19_5386_END::
MetaSprite_19_539b::
    INCBIN "gfx/unknown/metasprite_19/539b.sprite.bin"
MetaSprite_19_539b_END::
MetaSprite_19_53b0::
    INCBIN "gfx/unknown/metasprite_19/53b0.sprite.bin"
MetaSprite_19_53b0_END::
MetaSprite_19_53c5::
    INCBIN "gfx/unknown/metasprite_19/53c5.sprite.bin"
MetaSprite_19_53c5_END::
MetaSprite_19_53ee::
    INCBIN "gfx/unknown/metasprite_19/53ee.sprite.bin"
MetaSprite_19_53ee_END::
MetaSprite_19_542b::
    INCBIN "gfx/unknown/metasprite_19/542b.sprite.bin"
MetaSprite_19_542b_END::
MetaSprite_19_547c::
    INCBIN "gfx/unknown/metasprite_19/547c.sprite.bin"
MetaSprite_19_547c_END::
MetaSprite_19_54e1::
    INCBIN "gfx/unknown/metasprite_19/54e1.sprite.bin"
MetaSprite_19_54e1_END::
MetaSprite_19_5546::
    INCBIN "gfx/unknown/metasprite_19/5546.sprite.bin"
MetaSprite_19_5546_END::
MetaSprite_19_5597::
    INCBIN "gfx/unknown/metasprite_19/5597.sprite.bin"
MetaSprite_19_5597_END::
MetaSprite_19_55d4::
    INCBIN "gfx/unknown/metasprite_19/55d4.sprite.bin"
MetaSprite_19_55d4_END::
MetaSprite_19_55fd::
    INCBIN "gfx/unknown/metasprite_19/55fd.sprite.bin"
MetaSprite_19_55fd_END::
MetaSprite_19_5612::
    INCBIN "gfx/unknown/metasprite_19/5612.sprite.bin"
MetaSprite_19_5612_END::
MetaSprite_19_563b::
    INCBIN "gfx/unknown/metasprite_19/563b.sprite.bin"
MetaSprite_19_563b_END::
MetaSprite_19_5664::
    INCBIN "gfx/unknown/metasprite_19/5664.sprite.bin"
MetaSprite_19_5664_END::
MetaSprite_19_568d::
    INCBIN "gfx/unknown/metasprite_19/568d.sprite.bin"
MetaSprite_19_568d_END::
MetaSprite_19_56a2::
    INCBIN "gfx/unknown/metasprite_19/56a2.sprite.bin"
MetaSprite_19_56a2_END::
MetaSprite_19_571b::
    INCBIN "gfx/unknown/metasprite_19/571b.sprite.bin"
MetaSprite_19_571b_END::
MetaSprite_19_5794::
    INCBIN "gfx/unknown/metasprite_19/5794.sprite.bin"
MetaSprite_19_5794_END::
MetaSprite_19_57c7::
    INCBIN "gfx/unknown/metasprite_19/57c7.sprite.bin"
MetaSprite_19_57c7_END::
MetaSprite_19_57dc::
    INCBIN "gfx/unknown/metasprite_19/57dc.sprite.bin"
MetaSprite_19_57dc_END::
MetaSprite_19_57f1::
    INCBIN "gfx/unknown/metasprite_19/57f1.sprite.bin"
MetaSprite_19_57f1_END::
MetaSprite_19_5806::
    INCBIN "gfx/unknown/metasprite_19/5806.sprite.bin"
MetaSprite_19_5806_END::
MetaSprite_19_581b::
    INCBIN "gfx/unknown/metasprite_19/581b.sprite.bin"
MetaSprite_19_581b_END::
MetaSprite_19_5867::
    INCBIN "gfx/unknown/metasprite_19/5867.sprite.bin"
MetaSprite_19_5867_END::
MetaSprite_19_58e0::
    INCBIN "gfx/unknown/metasprite_19/58e0.sprite.bin"
MetaSprite_19_58e0_END::
MetaSprite_19_5959::
    INCBIN "gfx/unknown/metasprite_19/5959.sprite.bin"
MetaSprite_19_5959_END::
MetaSprite_19_596e::
    INCBIN "gfx/unknown/metasprite_19/596e.sprite.bin"
MetaSprite_19_596e_END::
MetaSprite_19_5983::
    INCBIN "gfx/unknown/metasprite_19/5983.sprite.bin"
MetaSprite_19_5983_END::
MetaSprite_19_59fc::
    INCBIN "gfx/unknown/metasprite_19/59fc.sprite.bin"
MetaSprite_19_59fc_END::
MetaSprite_19_5a75::
    INCBIN "gfx/unknown/metasprite_19/5a75.sprite.bin"
MetaSprite_19_5a75_END::
MetaSprite_19_5a8a::
    INCBIN "gfx/unknown/metasprite_19/5a8a.sprite.bin"
MetaSprite_19_5a8a_END::
MetaSprite_19_5b03::
    INCBIN "gfx/unknown/metasprite_19/5b03.sprite.bin"
MetaSprite_19_5b03_END::
MetaSprite_19_5b7c::
    INCBIN "gfx/unknown/metasprite_19/5b7c.sprite.bin"
MetaSprite_19_5b7c_END::
MetaSprite_19_5b91::
    INCBIN "gfx/unknown/metasprite_19/5b91.sprite.bin"
MetaSprite_19_5b91_END::
MetaSprite_19_5bba::
    INCBIN "gfx/unknown/metasprite_19/5bba.sprite.bin"
MetaSprite_19_5bba_END::
MetaSprite_19_5be3::
    INCBIN "gfx/unknown/metasprite_19/5be3.sprite.bin"
MetaSprite_19_5be3_END::
MetaSprite_19_5c0c::
    INCBIN "gfx/unknown/metasprite_19/5c0c.sprite.bin"
MetaSprite_19_5c0c_END::
MetaSprite_19_5c35::
    INCBIN "gfx/unknown/metasprite_19/5c35.sprite.bin"
MetaSprite_19_5c35_END::
MetaSprite_19_5c5e::
    INCBIN "gfx/unknown/metasprite_19/5c5e.sprite.bin"
MetaSprite_19_5c5e_END::
MetaSprite_19_5c9b::
    INCBIN "gfx/unknown/metasprite_19/5c9b.sprite.bin"
MetaSprite_19_5c9b_END::
MetaSprite_19_5cec::
    INCBIN "gfx/unknown/metasprite_19/5cec.sprite.bin"
MetaSprite_19_5cec_END::
MetaSprite_19_5d51::
    INCBIN "gfx/unknown/metasprite_19/5d51.sprite.bin"
MetaSprite_19_5d51_END::
MetaSprite_19_5db6::
    INCBIN "gfx/unknown/metasprite_19/5db6.sprite.bin"
MetaSprite_19_5db6_END::
MetaSprite_19_5e07::
    INCBIN "gfx/unknown/metasprite_19/5e07.sprite.bin"
MetaSprite_19_5e07_END::
MetaSprite_19_5e44::
    INCBIN "gfx/unknown/metasprite_19/5e44.sprite.bin"
MetaSprite_19_5e44_END::
MetaSprite_19_5e6d::
    INCBIN "gfx/unknown/metasprite_19/5e6d.sprite.bin"
MetaSprite_19_5e6d_END::
MetaSprite_19_5e82::
    INCBIN "gfx/unknown/metasprite_19/5e82.sprite.bin"
MetaSprite_19_5e82_END::
MetaSprite_19_5e97::
    INCBIN "gfx/unknown/metasprite_19/5e97.sprite.bin"
MetaSprite_19_5e97_END::
MetaSprite_19_5eb6::
    INCBIN "gfx/unknown/metasprite_19/5eb6.sprite.bin"
MetaSprite_19_5eb6_END::
MetaSprite_19_5efd::
    INCBIN "gfx/unknown/metasprite_19/5efd.sprite.bin"
MetaSprite_19_5efd_END::
MetaSprite_19_5f03::
    INCBIN "gfx/unknown/metasprite_19/5f03.sprite.bin"
MetaSprite_19_5f03_END::
MetaSprite_19_5f0e::
    INCBIN "gfx/unknown/metasprite_19/5f0e.sprite.bin"
MetaSprite_19_5f0e_END::
MetaSprite_19_5f1e::
    INCBIN "gfx/unknown/metasprite_19/5f1e.sprite.bin"
MetaSprite_19_5f1e_END::
MetaSprite_19_5f33::
    INCBIN "gfx/unknown/metasprite_19/5f33.sprite.bin"
MetaSprite_19_5f33_END::
MetaSprite_19_5f4d::
    INCBIN "gfx/unknown/metasprite_19/5f4d.sprite.bin"
MetaSprite_19_5f4d_END::
MetaSprite_19_5f53::
    INCBIN "gfx/unknown/metasprite_19/5f53.sprite.bin"
MetaSprite_19_5f53_END::
MetaSprite_19_5f72::
    INCBIN "gfx/unknown/metasprite_19/5f72.sprite.bin"
MetaSprite_19_5f72_END::
MetaSprite_19_5f78::
    INCBIN "gfx/unknown/metasprite_19/5f78.sprite.bin"
MetaSprite_19_5f78_END::
MetaSprite_19_5f8d::
    INCBIN "gfx/unknown/metasprite_19/5f8d.sprite.bin"
MetaSprite_19_5f8d_END::
MetaSprite_19_5fa2::
    INCBIN "gfx/unknown/metasprite_19/5fa2.sprite.bin"
MetaSprite_19_5fa2_END::
MetaSprite_19_5fc6::
    INCBIN "gfx/unknown/metasprite_19/5fc6.sprite.bin"
MetaSprite_19_5fc6_END::
MetaSprite_19_5fcc::
    INCBIN "gfx/unknown/metasprite_19/5fcc.sprite.bin"
MetaSprite_19_5fcc_END::
MetaSprite_19_5fd2::
    INCBIN "gfx/unknown/metasprite_19/5fd2.sprite.bin"
MetaSprite_19_5fd2_END::
MetaSprite_19_5fd8::
    INCBIN "gfx/unknown/metasprite_19/5fd8.sprite.bin"
MetaSprite_19_5fd8_END::
MetaSprite_19_5fde::
    INCBIN "gfx/unknown/metasprite_19/5fde.sprite.bin"
MetaSprite_19_5fde_END::
MetaSprite_19_5ff3::
    INCBIN "gfx/unknown/metasprite_19/5ff3.sprite.bin"
MetaSprite_19_5ff3_END::
MetaSprite_19_6008::
    INCBIN "gfx/unknown/metasprite_19/6008.sprite.bin"
MetaSprite_19_6008_END::
MetaSprite_zukan_denjuu_name::
    INCBIN "components/zukan/denjuu_name.sprite.bin"
MetaSprite_zukan_denjuu_name_END::
