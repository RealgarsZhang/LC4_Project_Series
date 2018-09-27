;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;   OS - TRAP VECTOR TABLE   ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.OS
.CODE
.ADDR x8000
  ; TRAP vector table
  JMP TRAP_GETC           ; x00
  JMP TRAP_PUTC           ; x01
  JMP TRAP_PUTS           ; x02
  JMP TRAP_VIDEO_COLOR    ; x03
  JMP TRAP_DRAW_PIXEL     ; x04
  JMP TRAP_DRAW_LINE      ; x05
  JMP TRAP_DRAW_SPRITE    ; x06
  JMP TRAP_TIMER          ; x07
  JMP TRAP_GETC_TIMER     ; x08
  JMP TRAP_CLEAR
  OS_KBSR_ADDR .UCONST xFE00  ; alias for keyboard status reg
  OS_KBDR_ADDR .UCONST xFE02  ; alias for keyboard data reg

  OS_ADSR_ADDR .UCONST xFE04  ; alias for display status register
  OS_ADDR_ADDR .UCONST xFE06  ; alias for display data register

  OS_TSR_ADDR .UCONST xFE08 ; alias for timer status register
  OS_TIR_ADDR .UCONST xFE0A ; alias for timer interval register

  OS_VIDEO_NUM_COLS .UCONST #128
  OS_VIDEO_NUM_ROWS .UCONST #124  
  maxCol .uconst 127
  maxRow .uconst 124
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
OS_GLOBALS_MEM .fill 0
st .fill 0
deltax .fill 0
deltay .fill 0
error .fill 0
y .fill 0
ystep .fill -1 ;important
xi0 .fill 0;x0 generates error. So I use xi
y0 .fill 0
xi1 .fill 0
y1  .fill 0
color .fill 0
xtempd .fill 0
ytempd .fill 0 ;store the difference of x and y coordinate when evaluating abs value

oscol .fill 0
osrow .fill 0
color1 .fill 0
startAddr .fill 0
shifter .fill 256

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000 
OS_VIDEO_MEM .BLKW x3E00 ;128x124 words


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;   OS & TRAP IMPLEMENTATION   ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x8200
.FALIGN
  ;; by default, return to usercode: PC=x0000
  CONST R7, #0   ; R7 = 0
  RTI            ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - none
;;; Outputs          - R0 = ASCII character from ASCII keyboard

.CODE
TRAP_GETC
    LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp TRAP_GETC       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a single character out to ASCII display
;;; Inputs           - R0 = ASCII character to write to ASCII display
;;; Outputs          - none

.CODE
TRAP_PUTC
  LC R1, OS_ADSR_ADDR 	; R1 = address of display status reg
  LDR R1, R1, #0    	; R1 = value of display status reg
  BRzp TRAP_PUTC    	; if R1[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R1, OS_ADDR_ADDR 	; R1 = address of display data reg
  STR R0, R1, #0    	; R1 = value of keyboard data reg (R0)
  RTI			; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a string of characters out to ASCII display
;;; Inputs           - R0 = Address for first character
;;; Outputs          - none

.CODE
TRAP_PUTS

  ;;
  ;; CIS 240 TO DO: complete this trap	
  ;;
  TRAP_PUTS_loop1
  ldr r1,r0,0   ; now r1 has the value stored in the address of r0
  cmpi r1,0
  brz TRAP_PUTS_RTI

  TRAP_PUTS_putc
  lc r3,OS_ADSR_ADDR
  ldr r3,r3,0
  cmpi r3,0
  brzp TRAP_PUTS_putc

  lc r3,OS_ADDR_ADDR  ;r3 has the value of OS_ADDR_ADDR
    
  str r1,r3,0
  add r0,r0,1
  jmp TRAP_PUTS_loop1


TRAP_PUTS_RTI
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_VIDEO_COLOR   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Set all pixels of VIDEO display to a certain color
;;; Inputs           - R0 = color to set all pixels to
;;; Outputs          - none

.CODE
TRAP_VIDEO_COLOR

endOfVideo .uconst xFDFF
 
  ;;
  ;; CIS 240 TO DO: complete this trap	
  ;;
   
  lea r1,OS_VIDEO_MEM   ;r1 is the propellant in the loop
  lc r2,endOfVideo



  TRAP_VIDEO_COLOR_loop
  str r0,r1,0
  add r1,r1,1
  cmp r1,r2
  brnz TRAP_VIDEO_COLOR_loop





  RTI       ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_PIXEL   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw point on video display
;;; Inputs           - R0 = row to draw on (y)
;;;                  - R1 = column to draw on (x)
;;;                  - R2 = color to draw with
;;; Outputs          - none

.CODE
TRAP_DRAW_PIXEL
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC  R4, OS_VIDEO_NUM_COLS  ; R4=number of columns
  
  CMPIU R1, #0    	     ; Checks if x coord from input is > 0
  BRn END_PIXEL
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_PIXEL
  CMPIU R0, #0    	     ; Checks if y coord from input is > 0
  BRn END_PIXEL
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_PIXEL
  
  MUL R4, R0, R4      	     ; R4= (row * NUM_COLS)
  ADD R4, R4, R1      	     ; R4= (row * NUM_COLS) + col
  ADD R4, R4, R3      	     ; Add the offset to the start of video memory
  STR R2, R4, #0      	     ; Fill in the pixel with color from user (R2)
  
END_PIXEL
  RTI       		     ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_LINE   ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draws line on the video screen
;;; Inputs           - R0 = x coordinate of start point
;;; Inputs           - R1 = y coordinate of start point
;;; Inputs           - R2 = x coordinate of the end point
;;; Inputs           - R3 = y coordinate of the end point
;;; Inputs           - R4 = color of line
;;; Outputs          - none

.CODE
TRAP_DRAW_LINE



  ;;
  ;; CIS 240 TO DO: complete this trap	
  ;;
  ;fist initialize all global variables. This bug cost me hours. Never use globals blindly again
  lea r5,st
  const r6,0
  str r6,r5,0

  lea r5,deltax
  const r6,0
  str r6,r5,0

  lea r5,deltay
  const r6,0
  str r6,r5,0

  lea r5,error
  const r6,0
  str r6,r5,0

  lea r5,y
  const r6,0
  str r6,r5,0

  lea r5,ystep
  const r6,-1
  str r6,r5,0

  lea r5,xi0
  const r6,0
  str r6,r5,0

  lea r5,y0
  const r6,0
  str r6,r5,0

  lea r5,xi1
  const r6,0
  str r6,r5,0

  lea r5,y1
  const r6,0
  str r6,r5,0

  lea r5,color
  const r6,0
  str r6,r5,0

lea r5,xtempd
  const r6,0
  str r6,r5,0

  lea r5,ytempd
  const r6,0
  str r6,r5,0

  ;Finally i finished initializing everything






  lea r5,color
  str r4,r5,0 ;store the color

  lea r4,xi0
  str r0,r4,0
  lea r4,y0
  str r1,r4,0
  lea r4,xi1
  str r2,r4,0
  lea r4,y1
  str r3,r4,0   ;save the input data into the corresponding dmem

  lea r4,xtempd
  sub r5,r2,r0
  str r5,r4,0
  lea r4,ytempd
  sub r5,r3,r1
  str r5,r4,0
  sub r4,r2,r0
  sub r5,r3,r1

  cmpi r4,0
  brn maker4pos
  back1

  cmpi r5,0
  brn maker5pos
  back2

  ;r4,r5 having the desired absolute value

  add r0,r4,0
  add r1,r5,0
  cmp r1,r0
  brp r1Larger
  back3

  lea r0,st
  ldr r0,r0,0;load st
  cmpi r0,1
  brz stIs1
  back4
  
  lea r0,xi0
  ldr r0,r0,0
  lea r1,xi1
  ldr r1,r1,0
  cmp r0,r1
  brp ifx0Larger
  back5

  lea r0,deltax ;r0 addr of deltas
  lea r1,xi1
  lea r2,xi0
  ldr r1,r1,0    ;r1 value of x1
  ldr r2,r2,0    ;r2 value of x0
  sub r1,r1,r2   ;r1 value of x1-x0
  str r1,r0,0    ;deltax=x1-x0

  lea r0,deltay
  lea r1,y1
  lea r2,y0
  ldr r1,r1,0;r1 holds y1
  ldr r2,r2,0;r2 holds y0
  sub r3,r1,r2
  cmpi r3,0
  brn ifDeltayNegative
  back6    ;now r3 holds abs(y0-y1)
  str r3,r0,0;store r3 into deltay

  lea r0,y0
  ldr r0,r0,0; r0 holds y0
  lea r1,y
  str r0,r1,0; let y=y0
  ;r0 still holds y0

  lea r1,y1
  ldr r1,r1,0; r1 holds y1
  cmp r0,r1
  brn ystepIf
  back7

  ;since here in the loop,r6 is x, propelling the loop
  lea r6,xi0
  ldr r6,r6,0

  TRAP_DRAW_LINE_loop
  lea r0,st
  ldr r0,r0,0
  cmpi r0,1
  brz ifStIs1
  back8

  lea r0,st
  ldr r0,r0,0
  cmpi r0,1
  brnp ifStNot1
  back9

  lea r0,deltay
  ldr r0,r0,0
  lea r1,error
  ldr r1,r1,0
  add r1,r0,r1
  lea r0,error
  str r1,r0,0; error=error+deltay

  lea r0,error
  ldr r0,r0,0
  add r0,r0,r0; r0=2error
  lea r1,deltax
  ldr r1,r1,0
  cmp r0,r1
  brzp twoError
  back10

  add r6,r6,1
  lea r0,xi1         ;update x and check whether to break the loop
  ldr r0,r0,0
  cmp r6,r0
  brnz TRAP_DRAW_LINE_loop
















  RTI       		; PC = R7 ; PSR[15]=0

  maker4pos
  sub r4,r0,r2
  jmp back1

  maker5pos
  sub r5,r1,r3
  jmp back2

  r1Larger
  lea r3,st
  const r4,1
  str r4,r3,0 ;let st=1
  jmp back3

  stIs1     ;swap is done here
  lea r0,xi0
  ldr r0,r0,0;r0 holds x0
  lea r1,y0
  ldr r1,r1,0 ;r1 holds y0
  lea r2,xi0 ;r2 holds the addr of x0
  str r1,r2,0 ;let x0=y0
  lea r2,y0; r2 holds the addr of y0
  str r0,r2,0

  lea r0,xi1
  ldr r0,r0,0;r0 holds x1
  lea r1,y1
  ldr r1,r1,0 ;r1 holds 1
  lea r2,xi1 ;r2 holds the addr of x1
  str r1,r2,0 ;let x1=y1
  lea r2,y1; r2 holds the addr of y1
  str r0,r2,0
  
  jmp back4

  ifx0Larger
  lea r0,xi0
  ldr r0,r0,0;r0 holds x0
  lea r1,xi1
  ldr r1,r1,0 ;r1 holds x1
  lea r2,xi0 ;r2 holds the addr of x0
  str r1,r2,0 ;let x0=xi1
  lea r2,xi1; r2 holds the addr of xi0
  str r0,r2,0

   lea r0,y1
  ldr r0,r0,0;r0 holds y1
  lea r1,y0
  ldr r1,r1,0 ;r1 holds y0
  lea r2,y1 ;r2 holds the addr of y1
  str r1,r2,0 ;let y1=y0
  lea r2,y0; r2 holds the addr of y0
  str r0,r2,0
  jmp back5

  ifDeltayNegative
  sub r3,r2,r1
  jmp back6

  ystepIf
  lea r0,ystep
  const r1,1
  str r1,r0,0
  jmp back7

  ifStIs1 ;plot(y,x)
  lea r5,y
  ldr r5,r5,0; r5 holds y,r6 holds x
  lc r0,OS_VIDEO_NUM_COLS
  lc r1,OS_VIDEO_NUM_ROWS
  lea r3,OS_VIDEO_MEM
  mul r0,r0,r6;r0=#col*x
  add r3,r3,r0
  add r3,r3,r5; finally the position to be drawn is found here ,in r3
  lea r0,color
  ldr r0,r0,0
  str r0,r3,0
  jmp back8

  ifStNot1 ;plot(x,y)

  lea r5,y
  ldr r5,r5,0; r5 holds y,r6 holds x
  lc r0,OS_VIDEO_NUM_COLS
  lc r1,OS_VIDEO_NUM_ROWS
  lea r3,OS_VIDEO_MEM
  mul r0,r0,r5;r0=#col*y
  add r3,r3,r0
  add r3,r3,r6; finally the position to be drawn is found here ,in r3
  lea r0,color
  ldr r0,r0,0
  str r0,r3,0


  jmp back9

  twoError
  lea r0,y
  ldr r0,r0,0            ;r0=y
  lea r1,ystep
  ldr r1,r1,0            ;r1=ystep
  add r0,r1,r0          ;r0=r0+r1
  lea r1,y
  str r0,r1,0
  lea r0,error
  ldr r0,r0,0
  lea r1,deltax
  ldr r1,r1,0
  sub r0,r0,r1   ;r0=r0-r1
  lea r1,error
  str r0,r1,0
  jmp back10










;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_SPRITE   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draws a sprite on the video screen at a specific loc.
;;; Inputs           - R0 = x coordinate of top left corner of sprite
;;; Inputs           - R1 = y coordinate of top left corner of sprite
;;; Inputs           - R2 = color of the sprite
;;; Inputs           - R3 = starting address in data memory of sprite pattern
;;; Outputs          - none

.CODE
TRAP_DRAW_SPRITE

  ;;
  ;; CIS 240 TO DO: complete this trap	
  ;;

  lea r4,oscol
  str r0,r4,0
  lea r4,osrow
  str r1,r4,0
  lea r4,color1
  str r2,r4,0
  lea r4,startAddr   ;load data into dmem
  str r3,r4,0

  const r0,0   ;important
TRAP_DRAW_SPRITE_loop1 ;since then,r0 is i, r2 is j,from 0 to 7,r1 is the word,will not be modified for other aims

   
  lea r1,startADDR
  ldr r1,r1,0 
  add r1,r0,r1
  ldr r1,r1,0   ;considering which row it is , load the word into r1
  hiconst r1,0
  lea r6,shifter;shifter is 256,1 0000 0000; r6 is not to be easily modified in future loop2
  ldr r6,r6,0

  const r2,0   ;important
TRAP_DRAW_SPRITE_loop2

  srl r6,r6,1
  and r4,r6,r1
  cmpi r4,0
  brnp toPlot                  ;debug code here
  TRAP_DRAW_SPRITE_back1
  add r2,r2,1
  cmpi r2,7
  brnz TRAP_DRAW_SPRITE_loop2

  TRAP_DRAW_SPRITE_back2
  add r0,r0,1
  cmpi r0,7
  brnz TRAP_DRAW_SPRITE_loop1




















  jieshu; This means "end" in Chinese. Used here to avoid label overload.
  RTI       ; PC = R7 ; PSR[15]=0

  toPlot

 
  lea r3,osrow
  ldr r3,r3,0
  lea r4,oscol
  ldr r4,r4,0
  add r4,r4,r2
  add r3,r3,r0

  cmpiu r3,123
  brp jieshu
  cmpiu r4,127
  brp TRAP_DRAW_SPRITE_back2
  


  lc r5,OS_VIDEO_NUM_COLS
  mul r5,r5,r3
  add r5,r5,r4
  lea r3,OS_VIDEO_MEM
  add r5,r3,r5; r5 stores the address to draw
  lea r3,color1
  ldr r3,r3,0
  str r3,r5,0


  
  ;plot(r4,r3)
  jmp TRAP_DRAW_SPRITE_back1


 





;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: 
;;; Inputs           - R0 = time to wait in milliseconds
;;; Outputs          - none

.CODE
TRAP_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0 
    
  RTI       		; PC = R7 ; PSR[15]=0
  
  
;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - R0 = time to wait
;;; Outputs          - R0 = ASCII character from keyboard (or NULL)

.CODE
TRAP_GETC_TIMER

  ;;
  ;; CIS 240 TO DO: complete this trap	
  ;;
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

TRAP_GETC_TIMER_loop
  
  LC R2,OS_KBSR_ADDR
  ldr r2,r2,0   ;load contents of KBSR in r2
  cmpi r2,0
  brn ifKeyIsPressed

  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  cmpi r1,0
  BRzp TRAP_GETC_TIMER_loop    	; If R1[15]=1, timer has gone off!
  const r0,0
  RTI


 ifKeyIsPressed
 lc r2,OS_KBDR_ADDR
 ldr r0,r2,0  ;load contents of KBDR in r0
 RTI
 
   











  RTI                  ; PC = R7 ; PSR[15]=0
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;TRAP_CLEAR;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  TRAP_CLEAR
  lc r0 ,OS_VIDEO_NUM_COLS
  lc r1,OS_VIDEO_NUM_ROWS
  mul r0,r0,r1



  lea r1,OS_VIDEO_MEM ;r1 is i
  add r3,r1,r0    ;r3 is upper bound for loop
  const r4,0
  clearLoop
  str r4,r1,0
  add r1,r1,1
  cmpu r1,r3
  brnz clearLoop

  RTI