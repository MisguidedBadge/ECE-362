  XDEF Use_Coal, Coal12, Coal2, Coal22, Coal3, Coal32
  
  XREF on_off, gc11, gc12, gc21, gc22, gc31, gc32, gens1_coal, gens2_coal, gens3_coal
  XREF PowScale


;----------------------Coal Use---------------------------------------;

Use_Coal:
         BRCLR on_off, #%001, Coal2
                              ;if switch 1 is off then skip
         ldd gc11             ;load lower nibble coal (starts with 6500)
         cpd 0                ; if zero then decrement upper counter
         bls Coal12           ; branch if lower 
         subd PowScale        ; subtract D by a power scal of 1-100
         std gc11
         bra Coal2            ; Branch to next generator
Coal12:
         ldx gc12             ;Load the higher nibble
         MOVW #65000, gc11    ;Reset the lower nibble
         dex                  ;decrement value
         stx  gc12            ;Store the value back (reset if not)
         cpx  0               ; if zero then add a percent
         bne  Coal2
         ldaa gens1_coal      ;load the coal percentage
         BRCLR gens1_coal, #$FF, c1zero
         suba #5
         deca
         staa gens1_coal      ;add 1 percent
c1zero:         
         MOVW #1,    gc12
                    

Coal2:
         BRCLR on_off, #%010, Coal3
         
         ldd gc21             ; Load D with the lower of gen 2 coal
         cpd 0
         bls Coal22           ; Branch if lower
         subd PowScale        ; subtract PowScale 
         std gc21
         bra Coal3            ; branch to Generator 3
Coal22:
         ldx gc22             ; Load with the upper nibble
         MOVW #65000, gc21    ; reset gen2 lower coal
         dex
         stx gc22
         cpx 0
         bne Coal3
         ldaa gens2_coal
         BRCLR gens2_coal, #$FF, c2zero
         suba #3
         deca
         staa gens2_coal
c2zero:
         MOVW #1,    gc22

Coal3:

         BRCLR on_off, #%100, DONE_COAL
         
         ldd gc31
         cpd 0
         bls Coal32
         subd PowScale
         std  gc31
         bra DONE_COAL


Coal32:
         ldx gc32
         MOVW #65000, gc31
         dex
         stx gc32
         cpx 0
         lbne DONE_COAL
         ldaa gens3_coal
         BRCLR gens3_coal, #$FF, c3zero
         suba  #1
         staa gens3_coal
         MOVW #1, gc32
         bra DONE_COAL
c3zero:
         MOVW #1, gc32 
		
DONE_COAL:

		     
		     
		     rts