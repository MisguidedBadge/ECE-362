;XDEF  
	
  XREF on_off, gens1, gens2, gens3
	
	
MY_EXTENDED_ROM: SECTION

MY_EXTENDED_RAM: SECTION


Push:	Section

;Purpose of this is to check if the generator selected is one... if yes then
;warn the user if not the start the filling process by starting the stepper and incrementing a big counter

		pshx
		pshy
;---------------------Check if the generator is on----------------------;

		ldaa gens1
		cmpa #$2D 		; see if is the selected generator
		beq	 Generator1
		ldaa gens2
		cmpa #$2D
		beq  Generator2
		bra  Generator3
		
Generator1:
;If generator 1 then check if the generator switch is flipped
    ldaa on_off 
    anda %001         ; Check and see if switch one is pressed
    bne  

Generator2:

    ldaa on_off
    anda %010         ; Check and see if switch two is pressed
    bne  

Generator3:
		
				
		
		
		
		
		
DONE:
		
		pshy
		pshx