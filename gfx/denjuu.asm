INCLUDE "telefang.inc"

SECTION "Denjuu Palettes", ROMX[$4800], BANK[$0D]
DenjuuPalettes::
;Hardcoding Denjuu palettes because rgbgfx broke shit again.
;Palette 100
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 3, 1, 1
;Palette 101
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 8, 4, 6
;Palette 102
    dcolor 31, 31, 31
    dcolor 30, 19, 16
    dcolor 26, 12, 10
    dcolor 10, 4, 3
;Palette 103
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 6, 9, 6
;Palette 104
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 105
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 2, 6, 6
;Palette 106
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 5, 4, 3
;Palette 107
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 9, 4, 4
;Palette 108
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 8, 1, 3
;Palette 109
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 6, 4, 6
;Palette 10A
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 3, 5, 9
;Palette 10B
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 23, 1, 8
;Palette 10C
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 7, 3, 3
;Palette 10D
    dcolor 31, 31, 31
    dcolor 15, 17, 25
    dcolor 31, 4, 4
    dcolor 8, 6, 5
;Palette 10E
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 8, 5, 6
;Palette 10F
    dcolor 31, 31, 31
    dcolor 8, 22, 19
    dcolor 28, 6, 8
    dcolor 12, 3, 4
;Palette 110
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 4, 5, 9
;Palette 111
    dcolor 31, 31, 31
    dcolor 10, 21, 18
    dcolor 18, 7, 9
    dcolor 7, 4, 5
;Palette 112
    dcolor 31, 31, 31
    dcolor 18, 16, 31
    dcolor 20, 0, 7
    dcolor 6, 3, 6
;Palette 113
    dcolor 31, 31, 31
    dcolor 29, 16, 10
    dcolor 25, 9, 7
    dcolor 15, 2, 5
;Palette 114
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 5, 8, 10
;Palette 115
    dcolor 31, 31, 31
    dcolor 29, 20, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 116
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 117
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 9, 10, 9
;Palette 118
    dcolor 31, 31, 31
    dcolor 16, 21, 22
    dcolor 4, 11, 14
    dcolor 3, 4, 6
;Palette 119
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 28, 10, 9
    dcolor 7, 5, 5
;Palette 11A
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 16, 15, 21
    dcolor 6, 6, 7
;Palette 11B
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 17, 25, 30
    dcolor 12, 3, 11
;Palette 11C
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 14, 6, 14
    dcolor 2, 8, 10
;Palette 11D
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 3, 7, 5
;Palette 11E
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 6, 7, 6
;Palette 11F
    dcolor 31, 31, 31
    dcolor 29, 19, 5
    dcolor 21, 11, 10
    dcolor 9, 6, 7
;Palette 120
    dcolor 31, 31, 31
    dcolor 18, 16, 22
    dcolor 8, 13, 15
    dcolor 4, 5, 6
;Palette 121
    dcolor 31, 31, 31
    dcolor 20, 26, 19
    dcolor 7, 22, 14
    dcolor 2, 5, 1
;Palette 122
    dcolor 31, 31, 31
    dcolor 31, 27, 15
    dcolor 19, 9, 10
    dcolor 11, 7, 8
;Palette 123
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 23, 1, 8
;Palette 124
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 8, 4, 6
;Palette 125
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 6, 2, 2
;Palette 126
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 6, 9, 6
;Palette 127
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 128
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 2, 6, 6
;Palette 129
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 5, 4, 3
;Palette 12A
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 9, 4, 4
;Palette 12B
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 8, 1, 3
;Palette 12C
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 6, 4, 6
;Palette 12D
    dcolor 31, 31, 31
    dcolor 20, 22, 27
    dcolor 15, 17, 24
    dcolor 3, 3, 6
;Palette 12E
    dcolor 31, 31, 31
    dcolor 30, 19, 10
    dcolor 28, 13, 9
    dcolor 10, 4, 7
;Palette 12F
    dcolor 31, 31, 31
    dcolor 16, 23, 13
    dcolor 3, 11, 5
    dcolor 2, 5, 2
;Palette 130
    dcolor 31, 31, 31
    dcolor 29, 26, 16
    dcolor 23, 16, 8
    dcolor 8, 6, 4
;Palette 131
    dcolor 31, 31, 31
    dcolor 18, 14, 3
    dcolor 6, 4, 3
    dcolor 2, 1, 1
;Palette 132
    dcolor 31, 31, 31
    dcolor 3, 21, 28
    dcolor 19, 13, 7
    dcolor 6, 4, 1
;Palette 133
    dcolor 31, 31, 31
    dcolor 30, 20, 10
    dcolor 20, 22, 17
    dcolor 8, 7, 5
;Palette 134
    dcolor 31, 31, 31
    dcolor 31, 6, 6
    dcolor 9, 12, 19
    dcolor 4, 5, 7
;Palette 135
    dcolor 31, 31, 31
    dcolor 29, 20, 12
    dcolor 29, 14, 9
    dcolor 13, 5, 4
;Palette 136
    dcolor 31, 31, 31
    dcolor 29, 19, 10
    dcolor 5, 22, 21
    dcolor 2, 6, 5
;Palette 137
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 3, 1, 1
;Palette 138
    dcolor 31, 31, 31
    dcolor 26, 24, 26
    dcolor 20, 19, 21
    dcolor 8, 4, 6
;Palette 139
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 6, 2, 2
;Palette 13A
    dcolor 31, 31, 31
    dcolor 17, 21, 17
    dcolor 13, 16, 13
    dcolor 6, 9, 6
;Palette 13B
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 13C
    dcolor 31, 31, 31
    dcolor 3, 21, 22
    dcolor 0, 15, 15
    dcolor 2, 6, 6
;Palette 13D
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 5, 4, 3
;Palette 13E
    dcolor 31, 31, 31
    dcolor 30, 19, 18
    dcolor 27, 6, 5
    dcolor 9, 4, 4
;Palette 13F
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 8, 1, 3
;Palette 140
    dcolor 31, 31, 31
    dcolor 26, 20, 24
    dcolor 19, 11, 19
    dcolor 6, 4, 6
;Palette 141
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 3, 5, 9
;Palette 142
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 28, 17, 6
    dcolor 23, 1, 8
;Palette 143
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 7, 3, 3
;Palette 144
    dcolor 31, 31, 31
    dcolor 31, 7, 7
    dcolor 10, 13, 21
    dcolor 8, 6, 5
;Palette 145
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 8, 5, 6
;Palette 146
    dcolor 31, 31, 31
    dcolor 8, 22, 19
    dcolor 28, 6, 8
    dcolor 12, 3, 4
;Palette 147
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 4, 5, 9
;Palette 148
    dcolor 31, 31, 31
    dcolor 10, 21, 18
    dcolor 18, 7, 9
    dcolor 7, 4, 5
;Palette 149
    dcolor 31, 31, 31
    dcolor 26, 18, 22
    dcolor 20, 0, 7
    dcolor 6, 3, 6
;Palette 14A
    dcolor 31, 31, 31
    dcolor 29, 16, 10
    dcolor 25, 9, 7
    dcolor 15, 2, 5
;Palette 14B
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 5, 8, 10
;Palette 14C
    dcolor 31, 31, 31
    dcolor 29, 20, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 14D
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 14E
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 9, 10, 9
;Palette 14F
    dcolor 31, 31, 31
    dcolor 16, 21, 22
    dcolor 4, 11, 14
    dcolor 3, 4, 6
;Palette 150
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 28, 10, 9
    dcolor 7, 5, 5
;Palette 151
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 16, 15, 21
    dcolor 6, 6, 7
;Palette 152
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 7, 23, 29
    dcolor 12, 3, 11
;Palette 153
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 0, 21, 23
    dcolor 1, 12, 13
;Palette 154
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 3, 7, 5
;Palette 155
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 6, 7, 6
;Palette 156
    dcolor 31, 31, 31
    dcolor 29, 19, 5
    dcolor 21, 11, 10
    dcolor 9, 6, 7
;Palette 157
    dcolor 31, 31, 31
    dcolor 18, 16, 22
    dcolor 13, 10, 19
    dcolor 4, 5, 6
;Palette 158
    dcolor 31, 31, 31
    dcolor 20, 26, 19
    dcolor 7, 21, 14
    dcolor 2, 5, 1
;Palette 159
    dcolor 31, 31, 31
    dcolor 28, 14, 8
    dcolor 19, 9, 10
    dcolor 5, 3, 5
;Palette 15A
    dcolor 31, 31, 31
    dcolor 29, 21, 13
    dcolor 8, 22, 19
    dcolor 6, 7, 6
;Palette 15B
    dcolor 31, 31, 31
    dcolor 29, 12, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 15C
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 15D
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 9, 10, 9
;Palette 15E
    dcolor 31, 31, 31
    dcolor 31, 9, 7
    dcolor 4, 11, 14
    dcolor 3, 4, 6
;Palette 15F
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 10, 10, 19
    dcolor 7, 5, 5
;Palette 160
    dcolor 31, 31, 31
    dcolor 30, 22, 10
    dcolor 16, 15, 22
    dcolor 5, 5, 6
;Palette 161
    dcolor 31, 31, 31
    dcolor 23, 28, 31
    dcolor 7, 23, 29
    dcolor 12, 3, 11
;Palette 162
    dcolor 31, 31, 31
    dcolor 13, 24, 27
    dcolor 2, 10, 16
    dcolor 3, 4, 7
;Palette 163
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 3, 7, 5
;Palette 164
    dcolor 31, 31, 31
    dcolor 28, 24, 13
    dcolor 25, 19, 12
    dcolor 5, 4, 3
;Palette 165
    dcolor 31, 31, 31
    dcolor 18, 21, 30
    dcolor 18, 6, 14
    dcolor 5, 2, 3
;Palette 166
    dcolor 31, 31, 31
    dcolor 10, 14, 22
    dcolor 7, 10, 16
    dcolor 2, 3, 4
;Palette 167
    dcolor 31, 31, 31
    dcolor 17, 7, 11
    dcolor 9, 21, 7
    dcolor 2, 6, 5
;Palette 168
    dcolor 31, 31, 31
    dcolor 30, 25, 9
    dcolor 29, 14, 11
    dcolor 9, 7, 5
;Palette 169
    dcolor 31, 31, 31
    dcolor 13, 10, 13
    dcolor 8, 6, 8
    dcolor 4, 3, 4
;Palette 16A
    dcolor 31, 31, 31
    dcolor 28, 25, 14
    dcolor 18, 16, 10
    dcolor 9, 7, 6
;Palette 16B
    dcolor 31, 31, 31
    dcolor 30, 24, 8
    dcolor 23, 12, 3
    dcolor 8, 7, 5
;Palette 16C
    dcolor 31, 31, 31
    dcolor 22, 29, 30
    dcolor 14, 19, 24
    dcolor 6, 10, 18
;Palette 16D
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 5, 8, 10
;Palette 16E
    dcolor 31, 31, 31
    dcolor 17, 16, 17
    dcolor 12, 10, 14
    dcolor 7, 3, 5
;Palette 16F
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 6, 2, 2
;Palette 170
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 171
    dcolor 31, 31, 31
    dcolor 9, 12, 31
    dcolor 18, 11, 7
    dcolor 5, 4, 3
;Palette 172
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 8, 1, 3
;Palette 173
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 3, 5, 9
;Palette 174
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 19, 23
    dcolor 7, 3, 3
;Palette 175
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 8, 5, 6
;Palette 176
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 4, 5, 9
;Palette 177
    dcolor 31, 31, 31
    dcolor 5, 11, 22
    dcolor 20, 0, 7
    dcolor 6, 3, 6
;Palette 178
    dcolor 31, 31, 31
    dcolor 15, 12, 12
    dcolor 7, 4, 4
    dcolor 3, 1, 1
;Palette 179
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 6, 2, 2
;Palette 17A
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 17B
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 5, 4, 3
;Palette 17C
    dcolor 31, 31, 31
    dcolor 30, 22, 21
    dcolor 24, 3, 8
    dcolor 8, 1, 3
;Palette 17D
    dcolor 31, 31, 31
    dcolor 31, 29, 26
    dcolor 4, 11, 20
    dcolor 3, 5, 9
;Palette 17E
    dcolor 31, 31, 31
    dcolor 30, 22, 11
    dcolor 18, 6, 7
    dcolor 7, 3, 3
;Palette 17F
    dcolor 31, 31, 31
    dcolor 30, 23, 21
    dcolor 27, 18, 17
    dcolor 8, 5, 6
;Palette 180
    dcolor 31, 31, 31
    dcolor 26, 20, 16
    dcolor 8, 11, 17
    dcolor 4, 5, 9
;Palette 181
    dcolor 31, 31, 31
    dcolor 13, 8, 23
    dcolor 20, 0, 7
    dcolor 6, 3, 6
;Palette 182
    dcolor 31, 31, 31
    dcolor 3, 16, 9
    dcolor 12, 10, 14
    dcolor 7, 3, 5
;Palette 183
    dcolor 31, 31, 31
    dcolor 30, 22, 13
    dcolor 29, 17, 8
    dcolor 11, 3, 3
;Palette 184
    dcolor 31, 31, 31
    dcolor 18, 18, 24
    dcolor 13, 12, 16
    dcolor 7, 4, 6
;Palette 185
    dcolor 31, 31, 31
    dcolor 31, 30, 19
    dcolor 21, 19, 11
    dcolor 8, 3, 5
;Palette 186
    dcolor 31, 31, 31
    dcolor 12, 21, 12
    dcolor 25, 12, 5
    dcolor 2, 3, 1
;Palette 187
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 5, 8, 10
;Palette 188
    dcolor 31, 31, 31
    dcolor 29, 12, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 189
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 18A
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 9, 10, 9
;Palette 18B
    dcolor 31, 31, 31
    dcolor 30, 15, 0
    dcolor 4, 11, 14
    dcolor 3, 4, 6
;Palette 18C
    dcolor 31, 31, 31
    dcolor 26, 24, 22
    dcolor 20, 0, 6
    dcolor 3, 2, 2
;Palette 18D
    dcolor 31, 31, 31
    dcolor 23, 20, 24
    dcolor 0, 16, 14
    dcolor 6, 6, 7
;Palette 18E
    dcolor 31, 31, 31
    dcolor 22, 27, 31
    dcolor 20, 3, 12
    dcolor 2, 5, 12
;Palette 18F
    dcolor 31, 31, 31
    dcolor 13, 24, 28
    dcolor 1, 21, 24
    dcolor 6, 8, 11
;Palette 190
    dcolor 31, 31, 31
    dcolor 30, 23, 8
    dcolor 0, 17, 10
    dcolor 3, 7, 5
;Palette 191
    dcolor 31, 31, 31
    dcolor 31, 28, 19
    dcolor 5, 20, 13
    dcolor 7, 7, 5
;Palette 192
    dcolor 31, 31, 31
    dcolor 10, 19, 26
    dcolor 6, 11, 17
    dcolor 3, 4, 9
;Palette 193
    dcolor 31, 31, 31
    dcolor 24, 26, 25
    dcolor 10, 20, 20
    dcolor 4, 7, 7
;Palette 194
    dcolor 31, 31, 31
    dcolor 17, 16, 21
    dcolor 11, 11, 15
    dcolor 6, 5, 6
;Palette 195
    dcolor 31, 31, 31
    dcolor 0, 22, 19
    dcolor 0, 16, 13
    dcolor 1, 7, 5
;Palette 196
    dcolor 31, 31, 31
    dcolor 13, 16, 17
    dcolor 8, 10, 26
    dcolor 5, 8, 10
;Palette 197
    dcolor 31, 31, 31
    dcolor 29, 23, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 198
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 199
    dcolor 31, 31, 31
    dcolor 22, 16, 21
    dcolor 1, 21, 23
    dcolor 3, 4, 7
;Palette 19A
    dcolor 31, 31, 31
    dcolor 10, 19, 26
    dcolor 27, 14, 3
    dcolor 3, 4, 9
;Palette 19B
    dcolor 31, 31, 31
    dcolor 31, 3, 3
    dcolor 8, 5, 4
    dcolor 3, 1, 1
;Palette 19C
    dcolor 31, 31, 31
    dcolor 30, 9, 3
    dcolor 0, 12, 10
    dcolor 6, 2, 2
;Palette 19D
    dcolor 31, 31, 31
    dcolor 31, 29, 16
    dcolor 30, 11, 6
    dcolor 5, 1, 1
;Palette 19E
    dcolor 31, 31, 31
    dcolor 26, 24, 19
    dcolor 20, 18, 13
    dcolor 5, 4, 3
;Palette 19F
    dcolor 31, 31, 31
    dcolor 29, 29, 28
    dcolor 14, 23, 28
    dcolor 2, 4, 7
;Palette 1A0
    dcolor 31, 31, 31
    dcolor 13, 16, 17
    dcolor 8, 10, 26
    dcolor 5, 8, 10
;Palette 1A1
    dcolor 31, 31, 31
    dcolor 29, 23, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 1A2
    dcolor 31, 31, 31
    dcolor 17, 25, 30
    dcolor 0, 20, 28
    dcolor 2, 7, 10
;Palette 1A3
    dcolor 31, 31, 31
    dcolor 23, 28, 30
    dcolor 18, 21, 23
    dcolor 9, 10, 9
;Palette 1A4
    dcolor 31, 31, 31
    dcolor 31, 27, 13
    dcolor 26, 16, 5
    dcolor 11, 6, 2
;Palette 1A5
    dcolor 31, 31, 31
    dcolor 24, 24, 27
    dcolor 13, 19, 26
    dcolor 6, 1, 2
;Palette 1A6
    dcolor 31, 31, 31
    dcolor 26, 14, 9
    dcolor 19, 7, 5
    dcolor 6, 3, 2
;Palette 1A7
    dcolor 31, 31, 31
    dcolor 29, 19, 8
    dcolor 24, 9, 6
    dcolor 20, 0, 5
;Palette 1A8
    dcolor 31, 31, 31
    dcolor 19, 14, 12
    dcolor 25, 1, 5
    dcolor 6, 3, 3
;Palette 1A9
    dcolor 31, 31, 31
    dcolor 23, 24, 26
    dcolor 13, 16, 17
    dcolor 5, 8, 10
;Palette 1AA
    dcolor 31, 31, 31
    dcolor 29, 21, 0
    dcolor 5, 9, 15
    dcolor 4, 4, 6
;Palette 1AB
    dcolor 31, 31, 31
    dcolor 20, 13, 10
    dcolor 25, 3, 5
    dcolor 12, 5, 5
;Palette 1AC
    dcolor 31, 31, 31
    dcolor 12, 23, 30
    dcolor 4, 10, 22
    dcolor 4, 4, 17
;Palette 1AD
    dcolor 31, 31, 31
    dcolor 31, 23, 0
    dcolor 27, 3, 2
    dcolor 5, 2, 2
;Palette 1AE
    dcolor 31, 31, 31
    dcolor 19, 25, 31
    dcolor 14, 16, 25
    dcolor 4, 4, 20

SECTION "Denjuu Sprites Bank 0", ROMX[$4000], BANK[$6B]
DenjuuSprites0::
    INCBIN "build/gfx/denjuu/0.2bpp"
    INCBIN "build/gfx/denjuu/1.2bpp"
    INCBIN "build/gfx/denjuu/2.2bpp"
    INCBIN "build/gfx/denjuu/3.2bpp"
    INCBIN "build/gfx/denjuu/4.2bpp"
    INCBIN "build/gfx/denjuu/5.2bpp"
    INCBIN "build/gfx/denjuu/6.2bpp"
    INCBIN "build/gfx/denjuu/7.2bpp"
    INCBIN "build/gfx/denjuu/8.2bpp"
    INCBIN "build/gfx/denjuu/9.2bpp"
    INCBIN "build/gfx/denjuu/10.2bpp"
    INCBIN "build/gfx/denjuu/11.2bpp"
    INCBIN "build/gfx/denjuu/12.2bpp"
    INCBIN "build/gfx/denjuu/13.2bpp"
    INCBIN "build/gfx/denjuu/14.2bpp"
    INCBIN "build/gfx/denjuu/15.2bpp"
    INCBIN "build/gfx/denjuu/16.2bpp"
    INCBIN "build/gfx/denjuu/17.2bpp"

SECTION "Denjuu Sprites Bank 1", ROMX[$4000], BANK[$6C]
DenjuuSprites1::
    INCBIN "build/gfx/denjuu/18.2bpp"
    INCBIN "build/gfx/denjuu/19.2bpp"
    INCBIN "build/gfx/denjuu/20.2bpp"
    INCBIN "build/gfx/denjuu/21.2bpp"
    INCBIN "build/gfx/denjuu/22.2bpp"
    INCBIN "build/gfx/denjuu/23.2bpp"
    INCBIN "build/gfx/denjuu/24.2bpp"
    INCBIN "build/gfx/denjuu/25.2bpp"
    INCBIN "build/gfx/denjuu/26.2bpp"
    INCBIN "build/gfx/denjuu/27.2bpp"
    INCBIN "build/gfx/denjuu/28.2bpp"
    INCBIN "build/gfx/denjuu/29.2bpp"
    INCBIN "build/gfx/denjuu/30.2bpp"
    INCBIN "build/gfx/denjuu/31.2bpp"
    INCBIN "build/gfx/denjuu/32.2bpp"
    INCBIN "build/gfx/denjuu/33.2bpp"
    INCBIN "build/gfx/denjuu/34.2bpp"
    INCBIN "build/gfx/denjuu/35.2bpp"

SECTION "Denjuu Sprites Bank 2", ROMX[$4000], BANK[$6D]
DenjuuSprites2::
    INCBIN "build/gfx/denjuu/36.2bpp"
    INCBIN "build/gfx/denjuu/37.2bpp"
    INCBIN "build/gfx/denjuu/38.2bpp"
    INCBIN "build/gfx/denjuu/39.2bpp"
    INCBIN "build/gfx/denjuu/40.2bpp"
    INCBIN "build/gfx/denjuu/41.2bpp"
    INCBIN "build/gfx/denjuu/42.2bpp"
    INCBIN "build/gfx/denjuu/43.2bpp"
    INCBIN "build/gfx/denjuu/44.2bpp"
    INCBIN "build/gfx/denjuu/45.2bpp"
    INCBIN "build/gfx/denjuu/46.2bpp"
    INCBIN "build/gfx/denjuu/47.2bpp"
    INCBIN "build/gfx/denjuu/48.2bpp"
    INCBIN "build/gfx/denjuu/49.2bpp"
    INCBIN "build/gfx/denjuu/50.2bpp"
    INCBIN "build/gfx/denjuu/51.2bpp"
    INCBIN "build/gfx/denjuu/52.2bpp"
    INCBIN "build/gfx/denjuu/53.2bpp"

SECTION "Denjuu Sprites Bank 3", ROMX[$4000], BANK[$6E]
DenjuuSprites3::
    INCBIN "build/gfx/denjuu/54.2bpp"
    INCBIN "build/gfx/denjuu/55.2bpp"
    INCBIN "build/gfx/denjuu/56.2bpp"
    INCBIN "build/gfx/denjuu/57.2bpp"
    INCBIN "build/gfx/denjuu/58.2bpp"
    INCBIN "build/gfx/denjuu/59.2bpp"
    INCBIN "build/gfx/denjuu/60.2bpp"
    INCBIN "build/gfx/denjuu/61.2bpp"
    INCBIN "build/gfx/denjuu/62.2bpp"
    INCBIN "build/gfx/denjuu/63.2bpp"
    INCBIN "build/gfx/denjuu/64.2bpp"
    INCBIN "build/gfx/denjuu/65.2bpp"
    INCBIN "build/gfx/denjuu/66.2bpp"
    INCBIN "build/gfx/denjuu/67.2bpp"
    INCBIN "build/gfx/denjuu/68.2bpp"
    INCBIN "build/gfx/denjuu/69.2bpp"
    INCBIN "build/gfx/denjuu/70.2bpp"
    INCBIN "build/gfx/denjuu/71.2bpp"

SECTION "Denjuu Sprites Bank 4", ROMX[$4000], BANK[$6F]
DenjuuSprites4::
    INCBIN "build/gfx/denjuu/72.2bpp"
    INCBIN "build/gfx/denjuu/73.2bpp"
    INCBIN "build/gfx/denjuu/74.2bpp"
    INCBIN "build/gfx/denjuu/75.2bpp"
    INCBIN "build/gfx/denjuu/76.2bpp"
    INCBIN "build/gfx/denjuu/77.2bpp"
    INCBIN "build/gfx/denjuu/78.2bpp"
    INCBIN "build/gfx/denjuu/79.2bpp"
    INCBIN "build/gfx/denjuu/80.2bpp"
    INCBIN "build/gfx/denjuu/81.2bpp"
    INCBIN "build/gfx/denjuu/82.2bpp"
    INCBIN "build/gfx/denjuu/83.2bpp"
    INCBIN "build/gfx/denjuu/84.2bpp"
    INCBIN "build/gfx/denjuu/85.2bpp"
    INCBIN "build/gfx/denjuu/86.2bpp"
    INCBIN "build/gfx/denjuu/87.2bpp"
    INCBIN "build/gfx/denjuu/88.2bpp"
    INCBIN "build/gfx/denjuu/89.2bpp"

SECTION "Denjuu Sprites Bank 5", ROMX[$4000], BANK[$70]
DenjuuSprites5::
    INCBIN "build/gfx/denjuu/90.2bpp"
    INCBIN "build/gfx/denjuu/91.2bpp"
    INCBIN "build/gfx/denjuu/92.2bpp"
    INCBIN "build/gfx/denjuu/93.2bpp"
    INCBIN "build/gfx/denjuu/94.2bpp"
    INCBIN "build/gfx/denjuu/95.2bpp"
    INCBIN "build/gfx/denjuu/96.2bpp"
    INCBIN "build/gfx/denjuu/97.2bpp"
    INCBIN "build/gfx/denjuu/98.2bpp"
    INCBIN "build/gfx/denjuu/99.2bpp"
    INCBIN "build/gfx/denjuu/100.2bpp"
    INCBIN "build/gfx/denjuu/101.2bpp"
    INCBIN "build/gfx/denjuu/102.2bpp"
    INCBIN "build/gfx/denjuu/103.2bpp"
    INCBIN "build/gfx/denjuu/104.2bpp"
    INCBIN "build/gfx/denjuu/105.2bpp"
    INCBIN "build/gfx/denjuu/106.2bpp"
    INCBIN "build/gfx/denjuu/107.2bpp"

SECTION "Denjuu Sprites Bank 6", ROMX[$4000], BANK[$71]
DenjuuSprites6::
    INCBIN "build/gfx/denjuu/108.2bpp"
    INCBIN "build/gfx/denjuu/109.2bpp"
    INCBIN "build/gfx/denjuu/110.2bpp"
    INCBIN "build/gfx/denjuu/111.2bpp"
    INCBIN "build/gfx/denjuu/112.2bpp"
    INCBIN "build/gfx/denjuu/113.2bpp"
    INCBIN "build/gfx/denjuu/114.2bpp"
    INCBIN "build/gfx/denjuu/115.2bpp"
    INCBIN "build/gfx/denjuu/116.2bpp"
    INCBIN "build/gfx/denjuu/117.2bpp"
    INCBIN "build/gfx/denjuu/118.2bpp"
    INCBIN "build/gfx/denjuu/119.2bpp"
    INCBIN "build/gfx/denjuu/120.2bpp"
    INCBIN "build/gfx/denjuu/121.2bpp"
    INCBIN "build/gfx/denjuu/122.2bpp"
    INCBIN "build/gfx/denjuu/123.2bpp"
    INCBIN "build/gfx/denjuu/124.2bpp"
    INCBIN "build/gfx/denjuu/125.2bpp"

SECTION "Denjuu Sprites Bank 7", ROMX[$4000], BANK[$72]
DenjuuSprites7::
    INCBIN "build/gfx/denjuu/126.2bpp"
    INCBIN "build/gfx/denjuu/127.2bpp"
    INCBIN "build/gfx/denjuu/128.2bpp"
    INCBIN "build/gfx/denjuu/129.2bpp"
    INCBIN "build/gfx/denjuu/130.2bpp"
    INCBIN "build/gfx/denjuu/131.2bpp"
    INCBIN "build/gfx/denjuu/132.2bpp"
    INCBIN "build/gfx/denjuu/133.2bpp"
    INCBIN "build/gfx/denjuu/134.2bpp"
    INCBIN "build/gfx/denjuu/135.2bpp"
    INCBIN "build/gfx/denjuu/136.2bpp"
    INCBIN "build/gfx/denjuu/137.2bpp"
    INCBIN "build/gfx/denjuu/138.2bpp"
    INCBIN "build/gfx/denjuu/139.2bpp"
    INCBIN "build/gfx/denjuu/140.2bpp"
    INCBIN "build/gfx/denjuu/141.2bpp"
    INCBIN "build/gfx/denjuu/142.2bpp"
    INCBIN "build/gfx/denjuu/143.2bpp"

SECTION "Denjuu Sprites Bank 8", ROMX[$4000], BANK[$73]
DenjuuSprites8::
    INCBIN "build/gfx/denjuu/144.2bpp"
    INCBIN "build/gfx/denjuu/145.2bpp"
    INCBIN "build/gfx/denjuu/146.2bpp"
    INCBIN "build/gfx/denjuu/147.2bpp"
    INCBIN "build/gfx/denjuu/148.2bpp"
    INCBIN "build/gfx/denjuu/149.2bpp"
    INCBIN "build/gfx/denjuu/150.2bpp"
    INCBIN "build/gfx/denjuu/151.2bpp"
    INCBIN "build/gfx/denjuu/152.2bpp"
    INCBIN "build/gfx/denjuu/153.2bpp"
    INCBIN "build/gfx/denjuu/154.2bpp"
    INCBIN "build/gfx/denjuu/155.2bpp"
    INCBIN "build/gfx/denjuu/156.2bpp"
    INCBIN "build/gfx/denjuu/157.2bpp"
    INCBIN "build/gfx/denjuu/158.2bpp"
    INCBIN "build/gfx/denjuu/159.2bpp"
    INCBIN "build/gfx/denjuu/160.2bpp"
    INCBIN "build/gfx/denjuu/161.2bpp"

SECTION "Denjuu Sprites Bank 9", ROMX[$4000], BANK[$74]
DenjuuSprites9::
    INCBIN "build/gfx/denjuu/162.2bpp"
    INCBIN "build/gfx/denjuu/163.2bpp"
    INCBIN "build/gfx/denjuu/164.2bpp"
    INCBIN "build/gfx/denjuu/165.2bpp"
    INCBIN "build/gfx/denjuu/166.2bpp"
    INCBIN "build/gfx/denjuu/167.2bpp"
    INCBIN "build/gfx/denjuu/168.2bpp"
    INCBIN "build/gfx/denjuu/169.2bpp"
    INCBIN "build/gfx/denjuu/170.2bpp"
    INCBIN "build/gfx/denjuu/171.2bpp"
    INCBIN "build/gfx/denjuu/172.2bpp"
    INCBIN "build/gfx/denjuu/173.2bpp"
    INCBIN "build/gfx/denjuu/174.2bpp"
