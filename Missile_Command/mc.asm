		.DATA
trajIncoming 		.FILL #0
		.BLKW 299
		.BLKW 300
		.BLKW 1200
		.DATA
trajOutgoing 		.FILL #0
		.BLKW 299
		.BLKW 300
		.DATA
trajIncomingSplit 		.FILL #0
		.BLKW 299
		.BLKW 300
		.BLKW 1200
		.DATA
outgoingPusher 		.FILL #0
		.DATA
incomingPusher 		.FILL #0
		.BLKW 2
		.DATA
incomingSplitPusher 		.FILL #0
		.BLKW 2
		.DATA
keyInput 		.FILL #0
		.DATA
incomingsLeft 		.FILL #8
		.DATA
HIT_RADIUS 		.FILL #6
		.DATA
currentScore 		.FILL #0
		.DATA
cursorImage 		.FILL #0
		.FILL #0
		.FILL #24
		.FILL #60
		.FILL #60
		.FILL #24
		.FILL #0
		.FILL #0
		.DATA
safeCityImage 		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
destroyedCityImage 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
safeLauncherImage 		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.DATA
scoreImages 		.FILL #255
		.FILL #193
		.FILL #161
		.FILL #145
		.FILL #137
		.FILL #133
		.FILL #131
		.FILL #255
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #255
		.FILL #128
		.FILL #128
		.FILL #128
		.FILL #255
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #255
		.FILL #136
		.FILL #136
		.FILL #136
		.FILL #255
		.FILL #8
		.FILL #8
		.FILL #8
		.FILL #8
		.FILL #255
		.FILL #128
		.FILL #128
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #255
		.FILL #128
		.FILL #128
		.FILL #128
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #255
		.FILL #129
		.FILL #129
		.FILL #255
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #1
		.FILL #143
		.FILL #137
		.FILL #137
		.FILL #137
		.FILL #137
		.FILL #137
		.FILL #137
		.FILL #143
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #132
		.FILL #143
		.FILL #129
		.FILL #129
		.FILL #143
		.FILL #136
		.FILL #136
		.FILL #136
		.FILL #143
		.FILL #143
		.FILL #129
		.FILL #129
		.FILL #143
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #143
		.FILL #138
		.FILL #138
		.FILL #138
		.FILL #143
		.FILL #130
		.FILL #130
		.FILL #130
		.FILL #130
		.FILL #143
		.FILL #136
		.FILL #136
		.FILL #143
		.FILL #129
		.FILL #129
		.FILL #129
		.FILL #143
		.FILL #136
		.FILL #136
		.FILL #136
		.FILL #143
		.FILL #137
		.FILL #137
		.FILL #137
		.FILL #143
;;;;;;;;;;;;;;;;;;;;;;;;;;;;max;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
max
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LDR R3, R5, #4
	CMP R7, R3
	BRnz L2_mc
	LDR R7, R5, #3
	JMP L1_mc
L2_mc
	LDR R7, R5, #4
L1_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L10_mc
	LEA R7, L12_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L9_mc
L10_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L14_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L15_mc
L14_mc
	LDR R7, R5, #3
	STR R7, R5, #-13
L15_mc
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L16_mc
	LEA R7, L18_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L9_mc
L16_mc
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L20_mc
L19_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L20_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L19_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L22_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L22_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L9_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L25_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L24_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;abs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
abs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L27_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	JMP L26_mc
L27_mc
	LDR R7, R5, #3
L26_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L29_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawScoreTracker;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawScoreTracker
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, currentScore
	LDR R7, R7, #0
	SLL R7, R7, #3
	LEA R3, scoreImages
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #62
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L30_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCursor;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCursor
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, cursorImage
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, cursor
	LDR R3, R7, #1
	ADD R3, R3, #-2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R7, R7, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L31_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
L33_mc 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawMissileLauncher;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawMissileLauncher
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-10	;; allocate stack space for local variables
	;; function body
	ADD R1, R5, #-10
	LEA R0, L33_mc
;ASGNB
	ADD R6, R6, #-1
	STR R2, R6, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
;blkloop!!!!
	AND R3, R3, #0
	ADD R3, R3, #8
L37
	LDR R2, R0, #0
	STR R2, R1, #0
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R3, R3, #-1
BRnp L37
	LDR R3, R6, #0
	ADD R6, R6, #1
	LDR R2, R6, #0
	ADD R6, R6, #1
	LEA R7, missileLauncher
	LDR R7, R7, #1
	STR R7, R5, #-1
	CONST R7, #7
	STR R7, R5, #-2
	JMP L35_mc
L34_mc
	LDR R7, R5, #-2
	ADD R3, R5, #-10
	ADD R7, R7, R3
	CONST R3, #255
	STR R3, R7, #0
	LDR R7, R5, #-1
	ADD R7, R7, #-1
	STR R7, R5, #-1
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
L35_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRp L34_mc
	ADD R7, R5, #-10
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, missileLauncher
	LDR R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L32_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCities;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCities
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, cities
	ADD R3, R7, #12
	ADD R6, R6, #-1
	STR R3, R6, #0
	CONST R3, #0
	HICONST R3, #124
	ADD R6, R6, #-1
	STR R3, R6, #0
	CONST R3, #116
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #11
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LEA R7, cities
	ADD R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	CONST R3, #0
	HICONST R3, #124
	ADD R6, R6, #-1
	STR R3, R6, #0
	CONST R3, #116
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L38_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawIncoming;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawIncoming
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-1
L40_mc
	LDR R7, R5, #-1
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L44_mc
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L44_mc
L41_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L40_mc
L39_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawOutgoing;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawOutgoing
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-1
L47_mc
	LDR R7, R5, #-1
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L51_mc
	CONST R7, #0
	HICONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, outgoingLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L51_mc
L48_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L47_mc
L46_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawIncomingSplit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawIncomingSplit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-1
L54_mc
	LDR R7, R5, #-1
	LEA R3, incomingSplit
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L58_mc
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L58_mc
L55_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L54_mc
L53_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L60_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;Redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
Redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawScoreTracker
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCursor
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCities
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawOutgoing
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawIncoming
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawIncomingSplit
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L61_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
L63_mc 		.FILL #0
		.BLKW 299
		.BLKW 300
;;;;;;;;;;;;;;;;;;;;;;;;;;;;flipArray;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
flipArray
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	CONST R7, #91
	HICONST R7, #2
	SUB R6, R6, R7	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
;spilling -602
	STR R4, R6, #-1
	ADD R4, R5, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	STR R7, R4, #-10
	LDR R4, R6, #-1
	ADD R1, R5, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-9
	LEA R0, L63_mc
;ASGNB
	ADD R6, R6, #-1
	STR R2, R6, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
;blkloop!!!!
	AND R3, R3, #0
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
L74
	LDR R2, R0, #0
	STR R2, R1, #0
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R3, R3, #-1
BRnp L74
	LDR R3, R6, #0
	ADD R6, R6, #1
	LDR R2, R6, #0
	ADD R6, R6, #1
	CONST R7, #0
	STR R7, R5, #-1
L64_mc
	LDR R7, R5, #-1
	ADD R3, R5, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-9
	ADD R3, R7, R3
	LDR R2, R5, #3
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
	LDR R7, R5, #-1
	CONST R3, #44
	HICONST R3, #1
	ADD R2, R5, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-9
	ADD R2, R2, R3
	ADD R2, R7, R2
	LDR R1, R5, #3
	ADD R3, R1, R3
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
	LDR R7, R5, #-1
;spilling -603
	STR R4, R6, #-1
	ADD R4, R5, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	STR R7, R4, #-11
	LDR R4, R6, #-1
	LDR R3, R5, #3
	CONST R2, #0
	ADD R1, R7, R3
	LDR R1, R1, #0
	CMP R1, R2
	BRnp L68_mc
	CONST R7, #44
	HICONST R7, #1
	ADD R7, R3, R7
	ADD R3, R5, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-11
	LDR R3, R3, #0
	ADD R7, R3, R7
	LDR R7, R7, #0
	CMP R7, R2
	BRnp L68_mc
	LDR R7, R5, #-1
;spilling -602
	STR R4, R6, #-1
	ADD R4, R5, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	STR R7, R4, #-10
	LDR R4, R6, #-1
	JMP L66_mc
L68_mc
L65_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #44
	HICONST R3, #1
	CMP R7, R3
	BRn L64_mc
L66_mc
	CONST R7, #0
	STR R7, R5, #-1
	JMP L73_mc
L70_mc
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R3, R7, R3
	ADD R2, R5, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-10
	LDR R2, R2, #0
	SUB R7, R2, R7
	ADD R2, R5, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	ADD R2, R2, #-9
	ADD R2, R2, #-1
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
	LDR R7, R5, #-1
	CONST R3, #44
	HICONST R3, #1
	LDR R2, R5, #3
	ADD R2, R2, R3
	ADD R2, R7, R2
	ADD R1, R5, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-10
	LDR R1, R1, #0
	SUB R7, R1, R7
	ADD R7, R7, #-1
	ADD R1, R5, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-9
	ADD R3, R1, R3
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
L71_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L73_mc
	LDR R7, R5, #-1
	ADD R3, R5, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-10
	LDR R3, R3, #0
	CMP R7, R3
	BRn L70_mc
L62_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkTraj;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkTraj
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #5
	STR R7, R5, #-1
	LDR R3, R7, #0
	LDR R2, R5, #3
	CMP R3, R2
	BRnp L78_mc
	CONST R7, #44
	HICONST R7, #1
	LDR R3, R5, #-1
	ADD R7, R3, R7
	LDR R7, R7, #0
	LDR R3, R5, #4
	CMP R7, R3
	BRz L76_mc
L78_mc
	LDR R7, R5, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR flipArray
	ADD R6, R6, #1	;; free space for arguments
L76_mc
L75_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
L80_mc 		.FILL #0
		.BLKW 299
		.BLKW 300
;;;;;;;;;;;;;;;;;;;;;;;;;;;;getTrajectory;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
getTrajectory
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	CONST R7, #100
	HICONST R7, #2
	SUB R6, R6, R7	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	STR R7, R5, #-10
	LDR R7, R5, #4
	STR R7, R5, #-11
	ADD R1, R5, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-16
	ADD R1, R1, #-3
	LEA R0, L80_mc
;ASGNB
	ADD R6, R6, #-1
	STR R2, R6, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
;blkloop!!!!
	AND R3, R3, #0
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
L97
	LDR R2, R0, #0
	STR R2, R1, #0
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R3, R3, #-1
BRnp L97
	LDR R3, R6, #0
	ADD R6, R6, #1
	LDR R2, R6, #0
	ADD R6, R6, #1
	LDR R7, R5, #6
	LDR R3, R5, #4
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
;spilling -612
	STR R4, R6, #-1
	ADD R4, R5, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	ADD R4, R4, #-16
	STR R7, R4, #-4
	LDR R4, R6, #-1
	LDR R3, R5, #5
	LDR R2, R5, #3
	SUB R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	ADD R3, R5, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-4
	LDR R3, R3, #0
	CMP R3, R7
	BRnz L81_mc
	CONST R7, #1
	STR R7, R5, #-6
	JMP L82_mc
L81_mc
	CONST R7, #0
	STR R7, R5, #-6
L82_mc
	LDR R7, R5, #-6
	CONST R3, #1
	CMP R7, R3
	BRnp L83_mc
	LDR R7, R5, #3
	STR R7, R5, #-9
	LDR R7, R5, #4
	STR R7, R5, #3
	LDR R7, R5, #-9
	STR R7, R5, #4
	LDR R7, R5, #5
	STR R7, R5, #-9
	LDR R7, R5, #6
	STR R7, R5, #5
	LDR R7, R5, #-9
	STR R7, R5, #6
L83_mc
	LDR R7, R5, #3
	LDR R3, R5, #5
	CMP R7, R3
	BRnz L85_mc
	LDR R7, R5, #3
	STR R7, R5, #-9
	LDR R7, R5, #5
	STR R7, R5, #3
	LDR R7, R5, #-9
	STR R7, R5, #5
	LDR R7, R5, #6
	STR R7, R5, #-9
	LDR R7, R5, #4
	STR R7, R5, #6
	LDR R7, R5, #-9
	STR R7, R5, #4
L85_mc
	LDR R7, R5, #5
	LDR R3, R5, #3
	SUB R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #6
	LDR R3, R5, #4
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-7
	CONST R7, #0
	STR R7, R5, #-1
	LDR R7, R5, #4
	STR R7, R5, #-4
	LDR R3, R5, #6
	CMP R7, R3
	BRzp L87_mc
	CONST R7, #1
	STR R7, R5, #-8
	JMP L88_mc
L87_mc
	CONST R7, #-1
	STR R7, R5, #-8
L88_mc
	LDR R7, R5, #3
	STR R7, R5, #-3
	CONST R7, #0
	STR R7, R5, #-2
	JMP L92_mc
L89_mc
	LDR R7, R5, #-6
	CONST R3, #1
	CMP R7, R3
	BRnp L93_mc
	LDR R7, R5, #-2
	LDR R3, R5, #7
	ADD R7, R7, R3
	LDR R3, R5, #-4
	STR R3, R7, #0
	LDR R7, R5, #-2
	LDR R3, R5, #7
	CONST R2, #44
	HICONST R2, #1
	ADD R3, R3, R2
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #0
	JMP L94_mc
L93_mc
	LDR R7, R5, #-2
	LDR R3, R5, #7
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #0
	LDR R7, R5, #-2
	LDR R3, R5, #7
	CONST R2, #44
	HICONST R2, #1
	ADD R3, R3, R2
	ADD R7, R7, R3
	LDR R3, R5, #-4
	STR R3, R7, #0
L94_mc
	LDR R7, R5, #-1
	LDR R3, R5, #-7
	ADD R7, R7, R3
	STR R7, R5, #-1
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LDR R3, R5, #-5
	CMP R7, R3
	BRn L95_mc
	LDR R7, R5, #-4
	LDR R3, R5, #-8
	ADD R7, R7, R3
	STR R7, R5, #-4
	LDR R7, R5, #-1
	LDR R3, R5, #-5
	SUB R7, R7, R3
	STR R7, R5, #-1
L95_mc
L90_mc
	LDR R7, R5, #-3
	ADD R7, R7, #1
	STR R7, R5, #-3
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
L92_mc
	LDR R7, R5, #-3
	LDR R3, R5, #5
	CMP R7, R3
	BRnz L89_mc
L79_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;nullifyArray;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
nullifyArray
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L99_mc
	LDR R7, R5, #-1
	LDR R3, R5, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	LDR R3, R5, #3
	CONST R2, #44
	HICONST R2, #1
	ADD R3, R3, R2
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L100_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #44
	HICONST R3, #1
	CMP R7, R3
	BRn L99_mc
L98_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;ResetGame;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
ResetGame
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	CONST R7, #0
	STR R7, R5, #-1
	JSR reset
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	LEA R3, keyInput
	STR R7, R3, #0
	LEA R3, currentScore
	STR R7, R3, #0
	LEA R3, outgoingPusher
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, incomingLine
	STR R7, R3, #0
	LEA R7, incomingLine
	CONST R3, #1
	STR R3, R7, #2
	LEA R7, incomingLine
	CONST R3, #61
	STR R3, R7, #1
	LEA R7, incomingLine
	CONST R3, #116
	STR R3, R7, #3
	LEA R7, targets
	CONST R3, #61
	STR R3, R7, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, incomingLine
	STR R7, R3, #4
	LEA R7, incomingLine
	CONST R3, #1
	STR R3, R7, #6
	LEA R7, incomingLine
	CONST R3, #90
	STR R3, R7, #5
	LEA R7, incomingLine
	CONST R3, #116
	STR R3, R7, #7
	LEA R7, targets
	CONST R3, #90
	STR R3, R7, #1
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, incomingLine
	STR R7, R3, #8
	LEA R7, incomingLine
	CONST R3, #1
	STR R3, R7, #10
	LEA R7, incomingLine
	CONST R3, #30
	STR R3, R7, #9
	LEA R7, incomingLine
	CONST R3, #116
	STR R3, R7, #11
	LEA R7, targets
	CONST R3, #30
	STR R3, R7, #2
	CONST R7, #0
	STR R7, R5, #-1
L104_mc
	LDR R7, R5, #-1
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #-1
	LEA R3, incomingPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, trajIncoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, trajIncomingSplit
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncoming
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR getTrajectory
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #-1
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncoming
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR checkTraj
	ADD R6, R6, #3	;; free space for arguments
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncoming
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #1
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncoming
	ADD R7, R7, R2
	CONST R2, #44
	HICONST R2, #1
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #3
	LDR R7, R5, #-1
	LEA R3, incomingSplit
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	LEA R3, incomingSplitPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L105_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L104_mc
	LEA R7, incomingsLeft
	CONST R3, #5
	STR R3, R7, #0
	LEA R7, cities
	CONST R3, #30
	STR R3, R7, #1
	LEA R7, cities
	CONST R3, #90
	STR R3, R7, #11
	LEA R7, cities
	CONST R3, #0
	STR R3, R7, #0
	STR R3, R7, #10
	CONST R7, #0
	STR R7, R5, #-1
L108_mc
	LDR R7, R5, #-1
	LEA R3, cities
	ADD R3, R3, #2
	ADD R3, R7, R3
	LEA R2, safeCityImage
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
	LDR R7, R5, #-1
	LEA R3, cities
	ADD R3, R3, #12
	ADD R3, R7, R3
	LEA R2, safeCityImage
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
	LDR R7, R5, #-1
	LEA R3, missileLauncher
	ADD R3, R3, #3
	ADD R3, R7, R3
	LEA R2, safeLauncherImage
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
L109_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRnz L108_mc
	LEA R7, missileLauncher
	CONST R3, #8
	STR R3, R7, #1
	LEA R7, missileLauncher
	CONST R3, #61
	STR R3, R7, #2
	CONST R7, #0
	LEA R3, missileLauncher
	STR R7, R3, #0
	STR R7, R5, #-1
L112_mc
	LDR R7, R5, #-1
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L113_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L112_mc
	LEA R7, trajOutgoing
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, cursor
	CONST R3, #15
	STR R3, R7, #0
	STR R3, R7, #1
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L103_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;initializeOutgoing;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
initializeOutgoing
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #1
	LEA R3, outgoing
	STR R7, R3, #0
	LEA R7, missileLauncher
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LEA R7, outgoingLine
	CONST R3, #61
	STR R3, R7, #0
	CONST R3, #116
	STR R3, R7, #2
	LEA R7, outgoingLine
	LEA R3, cursor
	LDR R3, R3, #0
	STR R3, R7, #1
	LEA R7, outgoingLine
	LEA R3, cursor
	LDR R3, R3, #1
	STR R3, R7, #3
	LEA R7, trajOutgoing
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, trajOutgoing
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, outgoingLine
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR getTrajectory
	ADD R6, R6, #5	;; free space for arguments
	LEA R7, trajOutgoing
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, outgoingLine
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR checkTraj
	ADD R6, R6, #3	;; free space for arguments
	LEA R7, outgoingLine
	LEA R3, trajOutgoing
	LDR R3, R3, #0
	STR R3, R7, #1
	LEA R7, outgoingLine
	LEA R3, trajOutgoing
	CONST R2, #44
	HICONST R2, #1
	ADD R3, R3, R2
	LDR R3, R3, #0
	STR R3, R7, #3
L116_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkKeyInput;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkKeyInput
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LEA R7, keyInput
	LDR R7, R7, #0
	CONST R3, #97
	CMP R7, R3
	BRnp L118_mc
	LEA R7, cursor
	LDR R7, R7, #0
	CONST R3, #5
	CMP R7, R3
	BRnz L118_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #-3
	STR R3, R7, #0
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L118_mc
	LEA R7, keyInput
	LDR R7, R7, #0
	CONST R3, #100
	CMP R7, R3
	BRnp L120_mc
	LEA R7, cursor
	LDR R7, R7, #0
	CONST R3, #122
	CMP R7, R3
	BRzp L120_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #3
	STR R3, R7, #0
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L120_mc
	LEA R7, keyInput
	LDR R7, R7, #0
	CONST R3, #119
	CMP R7, R3
	BRnp L122_mc
	LEA R7, cursor
	LDR R7, R7, #1
	CONST R3, #5
	CMP R7, R3
	BRnz L122_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-3
	STR R3, R7, #0
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L122_mc
	LEA R7, keyInput
	LDR R7, R7, #0
	CONST R3, #115
	CMP R7, R3
	BRnp L124_mc
	LEA R7, cursor
	LDR R7, R7, #1
	CONST R3, #108
	CMP R7, R3
	BRzp L124_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #3
	STR R3, R7, #0
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L124_mc
	LEA R7, keyInput
	LDR R7, R7, #0
	CONST R3, #114
	CMP R7, R3
	BRnp L126_mc
	CONST R7, #0
	STR R7, R5, #-1
	LEA R3, outgoing
	LDR R3, R3, #0
	CMP R3, R7
	BRnp L126_mc
	LEA R7, missileLauncher
	STR R7, R5, #-2
	LDR R3, R7, #1
	LDR R2, R5, #-1
	CMP R3, R2
	BRnz L126_mc
	LDR R7, R5, #-2
	LDR R7, R7, #0
	LDR R3, R5, #-1
	CMP R7, R3
	BRnp L126_mc
	JSR initializeOutgoing
	ADD R6, R6, #0	;; free space for arguments
L126_mc
L117_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;pushIncomingsForward;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
pushIncomingsForward
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-1
L129_mc
	LDR R7, R5, #-1
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L133_mc
	LDR R7, R5, #-1
	LEA R3, incomingPusher
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	LEA R2, incomingPusher
	ADD R2, R7, R2
	LDR R2, R2, #0
	CONST R1, #88
	HICONST R1, #2
	MUL R7, R1, R7
	LEA R1, trajIncoming
	ADD R7, R7, R1
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R3, #1
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	LEA R2, incomingPusher
	ADD R2, R7, R2
	LDR R2, R2, #0
	CONST R1, #88
	HICONST R1, #2
	MUL R7, R1, R7
	LEA R1, trajIncoming
	ADD R7, R7, R1
	CONST R1, #44
	HICONST R1, #1
	ADD R7, R7, R1
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R3, #3
L133_mc
L130_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L129_mc
L128_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;pushOutgoingForward;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
pushOutgoingForward
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, outgoing
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L136_mc
	LEA R7, outgoingPusher
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LEA R3, outgoingLine
	LDR R7, R7, #0
	LEA R2, trajOutgoing
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #1
	LEA R7, outgoingLine
	LEA R3, outgoingPusher
	LDR R3, R3, #0
	LEA R2, trajOutgoing
	CONST R1, #44
	HICONST R1, #1
	ADD R2, R2, R1
	ADD R3, R3, R2
	LDR R3, R3, #0
	STR R3, R7, #3
L136_mc
L135_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;resetOutgoing;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
resetOutgoing
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, outgoing
	CONST R3, #0
	STR R3, R7, #0
	LEA R7, outgoingLine
	CONST R3, #61
	STR R3, R7, #0
	CONST R3, #116
	STR R3, R7, #2
	LEA R7, outgoingLine
	CONST R3, #61
	STR R3, R7, #1
	LEA R7, outgoingLine
	CONST R3, #116
	STR R3, R7, #3
	LEA R7, trajOutgoing
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, outgoingPusher
	CONST R3, #0
	STR R3, R7, #0
L138_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkIfOutgoingSelfExplode;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkIfOutgoingSelfExplode
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-1
	LEA R3, outgoing
	LDR R3, R3, #0
	CMP R3, R7
	BRnp L140_mc
	LEA R7, outgoingPusher
	LDR R7, R7, #0
	STR R7, R5, #-2
	LEA R3, trajOutgoing
	CONST R2, #0
	ADD R1, R3, #1
	ADD R1, R7, R1
	LDR R1, R1, #0
	CMP R1, R2
	BRnp L140_mc
	CONST R7, #44
	HICONST R7, #1
	LDR R1, R5, #-1
	ADD R7, R1, R7
	ADD R7, R3, R7
	LDR R3, R5, #-2
	ADD R7, R3, R7
	LDR R7, R7, #0
	CMP R7, R2
	BRnp L140_mc
	JSR resetOutgoing
	ADD R6, R6, #0	;; free space for arguments
L140_mc
L139_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkIfIncomingsGetHit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkIfIncomingsGetHit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-2
	LEA R7, outgoing
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L143_mc
	CONST R7, #0
	STR R7, R5, #-1
L145_mc
	LEA R7, outgoingLine
	LDR R7, R7, #1
	LDR R3, R5, #-1
	SLL R3, R3, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	LDR R3, R3, #1
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, HIT_RADIUS
	LDR R3, R3, #0
	CMP R7, R3
	BRzp L149_mc
	LEA R7, outgoingLine
	LDR R7, R7, #3
	LDR R3, R5, #-1
	SLL R3, R3, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	LDR R3, R3, #3
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, HIT_RADIUS
	LDR R3, R3, #0
	CMP R7, R3
	BRzp L149_mc
	LDR R7, R5, #-1
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #1
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, trajIncoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	LEA R3, incomingPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	LEA R3, targets
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-2
	LEA R7, currentScore
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L149_mc
L146_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L145_mc
	CONST R7, #0
	STR R7, R5, #-1
L151_mc
	LDR R7, R5, #-1
	STR R7, R5, #-3
	LEA R3, incomingSplit
	ADD R3, R7, R3
	LDR R3, R3, #0
	CONST R2, #1
	CMP R3, R2
	BRnp L155_mc
	LEA R7, outgoingLine
	LDR R7, R7, #1
	LDR R3, R5, #-3
	SLL R3, R3, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	LDR R3, R3, #1
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, HIT_RADIUS
	LDR R3, R3, #0
	CMP R7, R3
	BRzp L155_mc
	LEA R7, outgoingLine
	LDR R7, R7, #3
	LDR R3, R5, #-1
	SLL R3, R3, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	LDR R3, R3, #3
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, HIT_RADIUS
	LDR R3, R3, #0
	CMP R7, R3
	BRzp L155_mc
	LDR R7, R5, #-1
	LEA R3, incomingSplit
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #1
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, trajIncomingSplit
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	LEA R3, incomingSplitPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-2
	LEA R7, currentScore
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L155_mc
L152_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L151_mc
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L157_mc
	JSR resetOutgoing
	ADD R6, R6, #0	;; free space for arguments
L157_mc
L143_mc
L142_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reinitializeIncoming;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reinitializeIncoming
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	MOD R7, R7, R3
	STR R7, R5, #-1
	LDR R7, R5, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LDR R3, R5, #3
	SLL R3, R3, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	STR R7, R3, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #3
	LEA R7, targets
	CONST R3, #30
	LDR R2, R7, #0
	CMP R2, R3
	BRz L165_mc
	LDR R2, R7, #1
	CMP R2, R3
	BRz L165_mc
	LDR R7, R7, #2
	CMP R7, R3
	BRz L165_mc
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L162_mc
L165_mc
	LEA R7, missileLauncher
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L160_mc
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L160_mc
L162_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #30
	STR R3, R7, #1
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	CONST R3, #30
	STR R3, R7, #0
	JMP L161_mc
L160_mc
	LEA R7, targets
	CONST R3, #90
	LDR R2, R7, #0
	CMP R2, R3
	BRz L171_mc
	LDR R2, R7, #1
	CMP R2, R3
	BRz L171_mc
	LDR R7, R7, #2
	CMP R7, R3
	BRz L171_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRz L168_mc
L171_mc
	LEA R7, missileLauncher
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L166_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRnp L166_mc
L168_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #90
	STR R3, R7, #1
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	CONST R3, #90
	STR R3, R7, #0
	JMP L167_mc
L166_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #61
	STR R3, R7, #1
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	CONST R3, #61
	STR R3, R7, #0
L167_mc
L161_mc
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, trajIncoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncoming
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR getTrajectory
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #3
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncoming
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR checkTraj
	ADD R6, R6, #3	;; free space for arguments
	LDR R7, R5, #3
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncoming
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #1
	LDR R7, R5, #3
	SLL R3, R7, #2
	LEA R2, incomingLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncoming
	ADD R7, R7, R2
	CONST R2, #44
	HICONST R2, #1
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #3
	LDR R7, R5, #3
	LEA R3, incomingPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L159_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkIfNeedToReinitializeIncomings;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkIfNeedToReinitializeIncomings
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L173_mc
	CONST R7, #0
	STR R7, R5, #-2
	LDR R3, R5, #-1
	LEA R2, incoming
	ADD R3, R3, R2
	LDR R3, R3, #0
	CMP R3, R7
	BRnp L177_mc
	LEA R7, incomingsLeft
	LDR R7, R7, #0
	LDR R3, R5, #-2
	CMP R7, R3
	BRnz L177_mc
	LEA R7, incomingsLeft
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR reinitializeIncoming
	ADD R6, R6, #1	;; free space for arguments
L177_mc
L174_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L173_mc
L172_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;destroyCity;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
destroyCity
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #10
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	CONST R7, #0
	STR R7, R5, #-1
L180_mc
	LDR R7, R5, #-1
	CONST R3, #10
	LDR R2, R5, #3
	MUL R3, R3, R2
	LEA R2, cities
	ADD R3, R3, R2
	ADD R3, R3, #2
	ADD R3, R7, R3
	LEA R2, destroyedCityImage
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
L181_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRnz L180_mc
L179_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;destroyMissileLauncher;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
destroyMissileLauncher
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, missileLauncher
	CONST R3, #1
	STR R3, R7, #0
	CONST R3, #0
	STR R3, R7, #1
	CONST R7, #0
	STR R7, R5, #-1
L185_mc
	LDR R7, R5, #-1
	LEA R3, missileLauncher
	ADD R3, R3, #3
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L186_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L185_mc
L184_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;resetIncoming;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
resetIncoming
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #1
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, trajIncoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	LEA R3, incomingPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L189_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;resetIncomingSplit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
resetIncomingSplit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LEA R3, incomingSplit
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #1
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #2
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, trajIncomingSplit
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	LEA R3, incomingSplitPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L190_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkIfAnythingIsDestroyed;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkIfAnythingIsDestroyed
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L192_mc
	LDR R7, R5, #-1
	STR R7, R5, #-3
	CONST R3, #1
	LEA R2, incoming
	ADD R2, R7, R2
	LDR R2, R2, #0
	CMP R2, R3
	BRnp L196_mc
	LEA R7, incomingPusher
	LDR R2, R5, #-3
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R5, #-4
	CONST R2, #88
	HICONST R2, #2
	LDR R1, R5, #-3
	MUL R2, R2, R1
	LEA R1, trajIncoming
	ADD R2, R2, R1
	CONST R1, #0
	ADD R0, R7, #1
	ADD R0, R0, R2
	LDR R0, R0, #0
	CMP R0, R1
	BRnp L196_mc
	CONST R7, #44
	HICONST R7, #1
	ADD R7, R3, R7
	ADD R7, R2, R7
	LDR R3, R5, #-4
	ADD R7, R3, R7
	LDR R7, R7, #0
	CMP R7, R1
	BRnp L196_mc
	LDR R7, R5, #-1
	LEA R3, incomingPusher
	ADD R3, R7, R3
	LDR R3, R3, #0
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncoming
	ADD R7, R7, R2
	ADD R7, R3, R7
	LDR R7, R7, #0
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #30
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L198_mc
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR destroyCity
	ADD R6, R6, #1	;; free space for arguments
L198_mc
	LDR R7, R5, #-2
	CONST R3, #90
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L200_mc
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR destroyCity
	ADD R6, R6, #1	;; free space for arguments
L200_mc
	LDR R7, R5, #-2
	CONST R3, #61
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L202_mc
	JSR destroyMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
L202_mc
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR resetIncoming
	ADD R6, R6, #1	;; free space for arguments
L196_mc
L193_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L192_mc
	CONST R7, #0
	STR R7, R5, #-1
L204_mc
	LDR R7, R5, #-1
	STR R7, R5, #-3
	CONST R3, #1
	LEA R2, incomingSplit
	ADD R2, R7, R2
	LDR R2, R2, #0
	CMP R2, R3
	BRnp L208_mc
	LEA R7, incomingSplitPusher
	LDR R2, R5, #-3
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R5, #-4
	CONST R2, #88
	HICONST R2, #2
	LDR R1, R5, #-3
	MUL R2, R2, R1
	LEA R1, trajIncomingSplit
	ADD R2, R2, R1
	CONST R1, #0
	ADD R0, R7, #1
	ADD R0, R0, R2
	LDR R0, R0, #0
	CMP R0, R1
	BRnp L208_mc
	CONST R7, #44
	HICONST R7, #1
	ADD R7, R3, R7
	ADD R7, R2, R7
	LDR R3, R5, #-4
	ADD R7, R3, R7
	LDR R7, R7, #0
	CMP R7, R1
	BRnp L208_mc
	LDR R7, R5, #-1
	LEA R3, incomingSplitPusher
	ADD R3, R7, R3
	LDR R3, R3, #0
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncomingSplit
	ADD R7, R7, R2
	ADD R7, R3, R7
	LDR R7, R7, #0
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #30
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L210_mc
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR destroyCity
	ADD R6, R6, #1	;; free space for arguments
L210_mc
	LDR R7, R5, #-2
	CONST R3, #90
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L212_mc
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR destroyCity
	ADD R6, R6, #1	;; free space for arguments
L212_mc
	LDR R7, R5, #-2
	CONST R3, #61
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRzp L214_mc
	JSR destroyMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
L214_mc
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR resetIncomingSplit
	ADD R6, R6, #1	;; free space for arguments
L208_mc
L205_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L204_mc
L191_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;pushIncomingSplitsForward;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
pushIncomingSplitsForward
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-1
L217_mc
	LDR R7, R5, #-1
	LEA R3, incomingSplit
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L221_mc
	LDR R7, R5, #-1
	LEA R3, incomingSplitPusher
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	LEA R2, incomingSplitPusher
	ADD R2, R7, R2
	LDR R2, R2, #0
	CONST R1, #88
	HICONST R1, #2
	MUL R7, R1, R7
	LEA R1, trajIncomingSplit
	ADD R7, R7, R1
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R3, #1
	LDR R7, R5, #-1
	SLL R3, R7, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	LEA R2, incomingSplitPusher
	ADD R2, R7, R2
	LDR R2, R2, #0
	CONST R1, #88
	HICONST R1, #2
	MUL R7, R1, R7
	LEA R1, trajIncomingSplit
	ADD R7, R7, R1
	CONST R1, #44
	HICONST R1, #1
	ADD R7, R7, R1
	ADD R7, R2, R7
	LDR R7, R7, #0
	STR R7, R3, #3
L221_mc
L218_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L217_mc
L216_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;initializeIncomingSplit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
initializeIncomingSplit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LEA R3, incomingSplit
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R3, R7, R3
	LEA R2, incomingLine
	ADD R7, R7, R2
	LDR R7, R7, #1
	STR R7, R3, #0
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R3, R7, R3
	LEA R2, incomingLine
	ADD R7, R7, R2
	LDR R7, R7, #3
	STR R7, R3, #2
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #3
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #90
	CMP R7, R3
	BRnp L224_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #30
	STR R3, R7, #1
	JMP L225_mc
L224_mc
	LDR R7, R5, #3
	LEA R3, targets
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #30
	CMP R7, R3
	BRnp L226_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #61
	STR R3, R7, #1
	JMP L227_mc
L226_mc
	LDR R7, R5, #3
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	CONST R3, #90
	STR R3, R7, #1
L227_mc
L225_mc
	CONST R7, #88
	HICONST R7, #2
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, trajIncomingSplit
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR nullifyArray
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #3
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncomingSplit
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR getTrajectory
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #3
	CONST R3, #88
	HICONST R3, #2
	MUL R3, R3, R7
	LEA R2, trajIncomingSplit
	ADD R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	SLL R7, R7, #2
	LEA R3, incomingSplitLine
	ADD R7, R7, R3
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR checkTraj
	ADD R6, R6, #3	;; free space for arguments
	LDR R7, R5, #3
	SLL R3, R7, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncomingSplit
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #1
	LDR R7, R5, #3
	SLL R3, R7, #2
	LEA R2, incomingSplitLine
	ADD R3, R3, R2
	CONST R2, #88
	HICONST R2, #2
	MUL R7, R2, R7
	LEA R2, trajIncomingSplit
	ADD R7, R7, R2
	CONST R2, #44
	HICONST R2, #1
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #3
	LDR R7, R5, #3
	LEA R3, incomingSplitPusher
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L223_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;checkIfSplit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
checkIfSplit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L229_mc
	LDR R7, R5, #-1
	STR R7, R5, #-2
	LEA R3, incomingSplit
	ADD R3, R7, R3
	LDR R3, R3, #0
	CONST R2, #0
	CMP R3, R2
	BRnp L233_mc
	LEA R7, incomingPusher
	LDR R3, R5, #-2
	ADD R7, R3, R7
	LDR R7, R7, #0
	CONST R3, #10
	CMP R7, R3
	BRnp L233_mc
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR initializeIncomingSplit
	ADD R6, R6, #1	;; free space for arguments
L233_mc
L230_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L229_mc
L228_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	CONST R7, #0
	STR R7, R5, #-1
	LEA R7, L236_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L237_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L238_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L240_mc
L239_mc
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRnp L242_mc
	JMP L241_mc
L242_mc
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
	JMP L245_mc
L244_mc
	CONST R7, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, keyInput
	STR R7, R3, #0
	JSR checkKeyInput
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, HIT_RADIUS
	LEA R3, incomingsLeft
	LDR R3, R3, #0
	ADD R3, R3, #10
	STR R3, R7, #0
	JSR pushOutgoingForward
	ADD R6, R6, #0	;; free space for arguments
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
	LDR R7, R5, #-1
	LEA R3, incomingsLeft
	LDR R3, R3, #0
	SLL R3, R3, #1
	CMP R7, R3
	BRn L247_mc
	CONST R7, #0
	STR R7, R5, #-1
	JSR pushIncomingsForward
	ADD R6, R6, #0	;; free space for arguments
	JSR pushIncomingSplitsForward
	ADD R6, R6, #0	;; free space for arguments
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
	JMP L248_mc
L247_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L248_mc
	JSR checkIfOutgoingSelfExplode
	ADD R6, R6, #0	;; free space for arguments
	JSR checkIfIncomingsGetHit
	ADD R6, R6, #0	;; free space for arguments
	JSR checkIfAnythingIsDestroyed
	ADD R6, R6, #0	;; free space for arguments
	JSR checkIfNeedToReinitializeIncomings
	ADD R6, R6, #0	;; free space for arguments
	JSR checkIfSplit
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, cities
	STR R7, R5, #-3
	CONST R3, #1
	LDR R2, R7, #0
	CMP R2, R3
	BRnp L249_mc
	LDR R7, R5, #-3
	LDR R7, R7, #10
	CMP R7, R3
	BRnp L249_mc
	CONST R7, #1
	STR R7, R5, #-2
	JMP L246_mc
L249_mc
	LEA R7, incoming
	STR R7, R5, #-4
	CONST R3, #0
	LDR R2, R7, #0
	CMP R2, R3
	BRnp L251_mc
	LDR R7, R5, #-4
	LDR R7, R7, #1
	CMP R7, R3
	BRnp L251_mc
	LDR R7, R5, #-4
	LDR R7, R7, #2
	CMP R7, R3
	BRnp L251_mc
	LEA R7, incomingsLeft
	LDR R7, R7, #0
	CMP R7, R3
	BRnp L251_mc
	JMP L246_mc
L251_mc
L245_mc
	JMP L244_mc
L246_mc
L240_mc
	JMP L239_mc
L241_mc
	LEA R7, L253_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
L235_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
incomingSplitLine 		.BLKW 12
		.DATA
outgoingLine 		.BLKW 4
		.DATA
incomingLine 		.BLKW 12
		.DATA
cursor 		.BLKW 2
		.DATA
incomingSplit 		.BLKW 3
		.DATA
incoming 		.BLKW 3
		.DATA
outgoing 		.BLKW 1
		.DATA
missileLauncher 		.BLKW 11
		.DATA
cities 		.BLKW 20
		.DATA
targets 		.BLKW 3
		.DATA
L253_mc 		.STRINGZ "You lose!\n"
		.DATA
L238_mc 		.STRINGZ "r for launching missiles\n"
		.DATA
L237_mc 		.STRINGZ "a,d,s,w for left,right,down,up\n"
		.DATA
L236_mc 		.STRINGZ "Welcome to Missile Command!\n"
		.DATA
L25_mc 		.STRINGZ "\n"
		.DATA
L18_mc 		.STRINGZ "-32768"
		.DATA
L12_mc 		.STRINGZ "0"
