mkdir gfx/statusbar

./rip.sh 0xE0418 0x60 gfx/statusbar/left_space.w24.2bpp
./rip.sh 0xE0478 0x60 gfx/statusbar/right_space.w24.2bpp
./rip.sh 0xE04D8 0x60 gfx/statusbar/no_signal.w24.2bpp
./rip.sh 0xE0538 0x60 gfx/statusbar/signal_1.w24.2bpp
./rip.sh 0xE0598 0x60 gfx/statusbar/signal_2.w24.2bpp
./rip.sh 0xE05F8 0x60 gfx/statusbar/signal_3.w24.2bpp
./rip.sh 0xE0658 0x60 gfx/statusbar/signal_4.w24.2bpp
./rip.sh 0xE06B8 0xC0 gfx/statusbar/startselect.w24.2bpp
./rip.sh 0xE0778 0x60 gfx/statusbar/blank_indicator.w24.2bpp
./rip.sh 0xE07D8 0x60 gfx/statusbar/call_indicator.w24.2bpp
./rip.sh 0xE0838 0x60 gfx/statusbar/mail_indicator.w24.2bpp
./rip.sh 0xE0898 0x40 gfx/statusbar/blank_signal.2bpp
./rip.sh 0xE08D8 0x40 gfx/statusbar/silenced_call_signal.2bpp
./rip.sh 0xE0918 0xC0 gfx/statusbar/startselect_disabled.w24.2bpp
./rip.sh 0xE09D8 0x10 gfx/statusbar/unk1.2bpp
./rip.sh 0xE09E8 0x120 gfx/statusbar/unk2.w72.2bpp