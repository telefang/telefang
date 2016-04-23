;The Telefang gameloop runs on a three-level state machine.
;Each state indexes a jump table that I haven't imported just yet.
SECTION "StateMachine WRAM", WRAM0[$C3E0]
W_SystemState:: ds 1
W_SystemSubState:: ds 1
W_SystemSubSubState:: ds 1