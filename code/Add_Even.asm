; Add_Even.asm
; Author(s): Mostapha A
;
; Purpose:              Adds the even placed numbers in a credit card number
;
; Preconditions:        An array of even numbers called TempEven must have even numbers
;                       Address of end of even numbers defined in EndEven
;
; Notes:                Does not take anything from stack
;
; Postcondition:        Stores the total in a at memory address Sums
;                       all registers are destroyed
;
;

Add_Even

        ; body of subroutine
        
; x has values
        ldx     #TempEven       ; load array of even numbers
        ldaa    0
        
Even    ldab    1,x+            ; add to total
        aba
        
        cpx     #EndEven        ; check if we are at the end
        blt     Even
        
        staa    Sums		; store total in b

        rts                     ; Sum of Even Digits returned

        end

; ---------------------------------
;        END of Add_Even.asm -
;----------------------------------