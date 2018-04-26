  XDEF Use_Coal, Coal12, Coal2, Coal22, Coal3, Coal32
  
  XREF on_off, gc11, gc12, gc21, gc22, gc31, gc32, gens1_coal, gens2_coal, gens3_coal
  XREF PowScale


;----------------------Coal Use---------------------------------------;

Use_Coal:
         BRCLR on_off, #%001, Coal2
                              ;if switch 1 is off then skip
         ldd gc11             ;load lower nibble coal (starts with 6500)
         cpd 0                ; if zero then decrement upper counter
         ble Coal12           ; branch if lower 
         subd PowScale        ; subtract D by a power scal of 1-100
         bra Coal2            ; Branch to next generator
Coal12:
         ldx gc12             ;Load the higher nibble
         MOVW #65000, gc11    ;Reset the lower nibble
         dex                  ;decrement value
         stx  gc12            ;Store the value back (reset if not)
         cpx  0               ; if zero then add a percent
         bne  Coal2
         ldaa gens1_coal      ;load the coal percentage
         deca
         staa gens1_coal      ;add 1 percent
         MOVW #7384,    gc12
                    

Coal2:
         BRCLR on_off, #%010, Coal3
         
         ldd gc21             ; Load D with the lower of gen 2 coal
         cpd 0
         ble Coal22           ; Branch if lower
         subd PowScale        ; subtract PowScale 
         bra Coal3            ; branch to Generator 3
Coal22:
         ldx gc22             ; Load with the upper nibble
         MOVW #65000, gc21    ; reset gen2 lower coal
         dex
         stx gc22
         cpx 0
         bne Coal3
         ldaa gens2_coal
         deca
         staa gens2_coal
         MOVW #14769,    gc22

Coal3:
         ldaa on_off
         cmpa #%100
         bne  DONE_COAL
         ;BRCLR on_off, #%100, DONE_COAL
         
         ldd gc31
         cpd 0
         ble Coal32
         subd PowScale
         lbra DONE_COAL


Coal32:
         ldx gc32
         MOVW #65000, gc32
         dex
         stx gc32
         cpx 0
         lbne DONE_COAL
         ldaa gens3_coal
         deca
         staa gens3_coal
         MOVW #22153, gc32 
		
DONE_COAL:
		     rts