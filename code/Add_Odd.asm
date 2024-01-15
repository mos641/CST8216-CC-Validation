; Add_Odd.assm
; Author(s): Mostapha A
;
; Purpose:              Adds the odd placed numbers in a credit card number
;
; Preconditions:        An array of even numbers called TempOdds must have odd numbers
;                       Address of end of odd numbers defined in EndOdds
;
; Notes:                Does not take anything from stack
;
; Postcondition:        Stores the total in a at memory address Sums+1
;                       all registers are destroyed
;

Add_Odd
; body of subroutine
        ldaa    #0
        staa    Sums+1
        
; x contains array of odd values
        ldx     #TempOdds

Cont    ldaa       1,x+         ; store first value for calculations in a
        lsla                    ; multiply by two
        
        cmpa       #9           ; check if cross sum is needed
        ble        Add
        suba       #9           ; subtract 9 to get cross sum
        
Add     ldab    Sums+1          ; load previous odd number and cross sums
        aba                     ; add to total stored in a
        
        staa    Sums+1          ; store a back at sums location
        
        cpx     #EndOdds        ; see if we reached the end
        blt     Cont

        rts

        end

; ---------------------------------
;        END of Add_Odd.asm -
;----------------------------------