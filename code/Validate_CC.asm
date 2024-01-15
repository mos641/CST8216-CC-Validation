; Validate_CC.asm
; Author(s): Mostapha A
;
; Purpose:              Adds the sum of odd and even and validates
;
; Preconditions:        The sums of the odd and even number stored in Sums, Sums+1
;
; Notes:                Does not take anything from stack
;
; Postcondition:        Increments ValidResul and InvalidResult depending on calculations
;

Validate_CC

        ; body of subroutine
        
; a and b contain sum from add even and add odd
        ldaa    sums
        ldab    sums+1

        aba             	; add together
        ldab    $0
        exg     a,b
        ldx     #10     	; divide by 10 for remainder
        idiv
        
        cpd     $0      	; check remainder
        beq     Valid   	; if no remainder add to valid results
        ldaa    #1
        ldab    InvalidResult
        aba             	; load current count in InvalidResult and increment
        staa    InvalidResult
        bra     Return
Valid   ldaa    #1
        ldab    ValidResult
        aba                     ; load current count in ValidResult and increment
        staa    ValidResult
        
Return  rts

        end

; ---------------------------------
;        END of Validate_CC.asm -
;----------------------------------