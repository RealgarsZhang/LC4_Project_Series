;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File:    USER_HW.ASM
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;  Define constants the user could set prior to running program
centerRow .CONST 62	; start at y=62
centerCol .CONST 64	; start at x=64
Col .const 61
Row .const 59
twoSeconds .uconst 2000

;;;  Define some colors
RED   .UCONST x7C00	; 0 11111 00000 00000
GREEN .UCONST x03E0	; 0 00000 11111 00000
BLUE  .UCONST x001F	; 0 00000 00000 11111
WHITE .UCONST x7FFF	; 0 11111 11111 11111

.data
.addr x2200
wordsForCross

.fill x0010
.fill x0010      ;the words to draw the cross
.fill x0010
.fill x00FE
.fill x0010
.fill x0010
.fill x0010
.fill 0
wordsForClear
.fill x00FF
.fill x00FF
.fill x00FF
.fill x00FF
.fill x00FF
.fill x00FF
.fill x00FF
.fill x00FF
           ; words to clear the cross
allDone
.fill x0041
.fill x004C
.fill x004C
.fill 32
.fill 68
.fill 79
.fill 78
.fill 69
.fill 0
whichKeyPressed .fill 0 ; where to store the ASCII information from the key
currentCol .fill 61
currentRow .fill 59 ;; these two currents saves the current position of the cross
currentCenterCol .fill 64
currentCenterRow .fill 62
.CODE
.ADDR x0000

lc r0,Col
lc r1,Row
lc r2,RED
lea r3,wordsForCross

trap x06       ; initialize the cross

const r0,1
const r1,1
lc r2,centerCol
lc r3,centerRow
lc r4,GREEN
trap x05




userLoop
lc r0, twoSeconds
trap x08          ;DEBUG here

lea r1,whichKeyPressed
str r0,r1,0              ;store the key ASCII into dmem





cmpiu r0,10   ;debug here
brz print

cmpiu r0, 0     ;debug here
brz moveCrossBack


lea r0,whichKeyPressed
ldr r0,r0,0
cmpiu r0,105
brz north

lea r0,whichKeyPressed
ldr r0,r0,0
cmpiu r0,107
brz south

lea r0,whichKeyPressed
ldr r0,r0,0
cmpiu r0,106
brz west

lea r0,whichKeyPressed
ldr r0,r0,0
cmpiu r0,108
brz east

jmp userLoop
END
jmp END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print
lea r0,allDone
trap 2
jmp END








moveCrossBack

;trap 9
lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0                     ;erase the cross
const r2,0
lea r3,wordsForClear
trap x06

const r0,1
const r1,1
lea r2,currentCenterCol
ldr r2,r2,0
lea r3,currentCenterRow   ;erase the line
ldr r3,r3,0
const r4,0
trap x05

lea r0,currentCenterRow
lc r1,centerRow
str r1,r0,0
lea r0,currentCenterCol ;update the position information of everything
lc r1,centerCol
str r1,r0,0

lea r0,currentCol
lc r1,Col
str r1,r0,0

lea r0,currentRow
lc r1,Row
str r1,r0,0

lc r0,Col
lc r1,Row
lc r2,RED
lea r3,wordsForCross

trap x06                      ;draw everything back

const r0,1
const r1,1
lc r2,centerCol
lc r3,centerRow
lc r4,GREEN
trap x05

jmp userLoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


north

;trap 9
;
lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0                     ;erase the cross
const r2,0
lea r3,wordsForClear
trap x06

const r0,1
const r1,1
lea r2,currentCenterCol
ldr r2,r2,0
lea r3,currentCenterRow   ;erase the line
ldr r3,r3,0
const r4,0
trap x05



lea r0,currentRow
ldr r0,r0,0
add r0,r0,-10
cmpi r0,0              ;get the new row,if out of the bound,move the cross back
brn moveCrossBack

lea r1,currentRow
str r0,r1,0
lea r0,currentCenterRow
ldr r0,r0,0
add r0,r0,-10              ;update currentCenterRow and currentRow
lea r1,currentCenterRow
str r0,r1,0



lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0
lc r2,RED
lea r3,wordsForCross
trap x06                     ;Draw the corresponding stuff

const r0,1
const r1,1
lea r2,currentCol
ldr r2,r2,0
add r2,r2,3
lea r3,currentRow
ldr r3,r3,0
add r3,r3,3
lc r4,GREEN
trap x05

jmp userLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
south

;trap 9

lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0                     ;erase the cross
const r2,0
lea r3,wordsForClear
trap x06

const r0,1
const r1,1
lea r2,currentCenterCol
ldr r2,r2,0
lea r3,currentCenterRow   ;erase the line
ldr r3,r3,0
const r4,0
trap x05



lea r0,currentRow
ldr r0,r0,0
add r0,r0,10
cmpiu r0,116            ;get the new row,if out of the bound,move the cross back
brp moveCrossBack

lea r1,currentRow
str r0,r1,0
lea r0,currentCenterRow
ldr r0,r0,0
add r0,r0,10              ;update currentCenterRow and currentRow
lea r1,currentCenterRow
str r0,r1,0



lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0
lc r2,RED
lea r3,wordsForCross
trap x06                     ;Draw the corresponding stuff

const r0,1
const r1,1
lea r2,currentCol
ldr r2,r2,0
add r2,r2,3
lea r3,currentRow
ldr r3,r3,0
add r3,r3,3
lc r4,GREEN
trap x05

jmp userLoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveCrossBack1
jmp moveCrossBack
west

;trap 9

lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0                     ;erase the cross
const r2,0
lea r3,wordsForClear
trap x06

const r0,1
const r1,1
lea r2,currentCenterCol
ldr r2,r2,0
lea r3,currentCenterRow   ;erase the line
ldr r3,r3,0
const r4,0
trap x05




lea r0,currentCol
ldr r0,r0,0
add r0,r0,-10
cmpi r0,0              ;get the new col,if out of the bound,move the cross back
brn moveCrossBack

lea r1,currentCol
str r0,r1,0
lea r0,currentCenterCol
ldr r0,r0,0
add r0,r0,-10              ;update currentCenterCol and currentCol
lea r1,currentCenterCol
str r0,r1,0



lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0
lc r2,RED
lea r3,wordsForCross
trap x06                     ;Draw the corresponding stuff

const r0,1
const r1,1
lea r2,currentCol
ldr r2,r2,0
add r2,r2,3
lea r3,currentRow
ldr r3,r3,0
add r3,r3,3
lc r4,GREEN
trap x05

jmp userLoop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

east

;trap 9

lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0                     ;erase the cross
const r2,0
lea r3,wordsForClear
trap x06

const r0,1
const r1,1
lea r2,currentCenterCol
ldr r2,r2,0
lea r3,currentCenterRow   ;erase the line
ldr r3,r3,0
const r4,0
trap x05


lea r0,currentCol
ldr r0,r0,0
add r0,r0,10
cmpiu r0,120           ;get the new col,if out of the bound,move the cross back
brp moveCrossBack1

lea r1,currentCol
str r0,r1,0
lea r0,currentCenterCol
ldr r0,r0,0
add r0,r0,10              ;update currentCenterCol and currentCol
lea r1,currentCenterCol
str r0,r1,0



lea r0,currentCol
ldr r0,r0,0
lea r1,currentRow
ldr r1,r1,0
lc r2,RED
lea r3,wordsForCross
trap x06                     ;Draw the corresponding stuff

const r0,1
const r1,1
lea r2,currentCol
ldr r2,r2,0
add r2,r2,3
lea r3,currentRow
ldr r3,r3,0
add r3,r3,3
lc r4,GREEN
trap x05

jmp userLoop