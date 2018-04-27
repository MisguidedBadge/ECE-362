  XDEF  Push  
	
  XREF on_off, gens1, gens2, gens3,coalfill_f, Fill_Error1, Fill_Error2, Fill_Error3,disp, display_string, start_f
	
	
MY_EXTENDED_ROM: SECTION

MY_EXTENDED_RAM: SECTION

MY_CODE:        SECTION

Push:

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
    anda #%001         ; Check and see if switch one is pressed
    bne  warn1
    movb #1, coalfill_f
    bra  DONE
;set coal fill flag    

Generator2:

    ldaa on_off
    anda #%010         ; Check and see if switch two is pressed
    bne  warn2  
    movb #1, coalfill_f
    bra  DONE    

Generator3:
;If generator 2 the check if on
    ldaa on_off
    anda #%100
    bne  warn3
    movb #1, coalfill_f
    bra  DONE 		
	
				
warn1:
 	            jsr 	Fill_Error1             ;
				ldd 	#disp                   ;
				jsr 	display_string 			;display the date time string
      			MOVB 	#0, start_f   			;Reset the delay for 3 seconds
      
W1:	            BRCLR 	start_f, #1, W1    ;
			
			    bra     DONE

warn2:
                jsr 	Fill_Error2             ;
				ldd 	#disp                   ;
				jsr 	display_string 			;display the date time string
      			MOVB 	#0, start_f   			;Reset the delay for 3 seconds
      
W2:	            BRCLR 	start_f, #1, W2    ;
			
			    bra     DONE


warn3:		
		
 	            jsr 	Fill_Error3             ;
				ldd 	#disp                   ;
				jsr 	display_string 			;display the date time string
      			MOVB 	#0, start_f   			;Reset the delay for 3 seconds
      
W3:	            BRCLR 	start_f, #1, W3    ;
			
			    bra     DONE		
		
		
DONE:
		
        puly
        pulx
		rts