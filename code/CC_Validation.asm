; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
;
; Author(s): Mostapha A
;
; Purpose:      Credit Card Number Validation by calling subroutines and calculating based on specifications

; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                    ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                    ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed
NUMODDNEVEN     equ     2

; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay

                org         STORAGE1                ; Note: a Label cannot be placed
Cards                                           ; on same line as org statement
#include        Sec_302_CC_Numbers.txt          ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org          FINALRESULTS
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
; end of do not change
TempEven        ds      NUMODDNEVEN             ; add storage for even and odd numbers
EndEven
TempOdds        ds      NUMODDNEVEN
EndOdds                                         ; storage for the sums of each
Sums            ds      2

                org     ProgramStart
                lds     #ProgramStart           ; Stack used to protect values




; --------------------------------------------
; --- Note: the positioning of the columns change for some reason whenever I open the files, they are aligned when I first write them

                ldx     #Cards                  ; use x to go through card numbers
                ldy     #TempEven               ; for storage of odds and even
                
Storage         ldd        2,x+                 ; will store odd in a and even in b
                staa    NUMODDNEVEN,y           ; store odds first
                stab    1,y+                    ; store even, increment to next position
                
                cpy     #TempOdds               ; check if we are at end of card numbers
                blt     Storage                 ; if not branch back to storage

; find odd and even sums
Subroutines     pshx                            ; store x
                jsr     Add_Odd
                jsr     Add_Even

; calculate validity
                jsr     Validate_CC

                pulx                            ; bring back x
                
; check if we reached end of cards
Check           ldy     #TempEven               ; reset temp storage
                cpx     #EndCards               ; check if we reached end
                blt     Storage
; --------------------------------------------




; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0             ; Select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3             ; Select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Eelay for DELAY_VALUE milliseconds
                bra     Display                 ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include Hex_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************