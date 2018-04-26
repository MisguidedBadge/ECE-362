  XDEF Stepper, StepperS1, StepperS2, StepperS3, Stepper

  XREF stepper_it, stepper_num, stepper_r, stepper_c


;----------------------Stepper Motor--------------------------------;
Stepper:
		
	;	BRSET stepper_full, #1, StepperS3
;-----------------------------Stepper Coal filling Start------------------------;		
		BRCLR stepper_it, #8, StepperS1	;8 iterations before going up in value
		ldx stepper_num
		cpx #234
		beq StepperS2
		dex
		stx stepper_num
		rts
;----------------------------Stepper Coal Filling Finish------------------------;
		BRCLR stepper_it, #8, StepperS2
	;	ldx 		
		

;-----------------------------Filling Process Start------------------------------;		
StepperS1:
		BRSET stepper_r, #1, DONE_S
		Ldx	stepper_c						        ;load count to x
		inx									            ;increment count
		stx stepper_c 
		Cpx	stepper_num		              ;decrements down to 30 ms
		Bne	DONE_S					      ;
		Ldx	#0		                  		;reset to 0 if 30ms
		ldaa stepper_it
		inca
		staa stepper_it
		MOVB #1, stepper_r
		MOVW #0, stepper_c

		
		rts
		
;------------------------------Middle of the Process------------------------------;
StepperS2:
		BRSET stepper_r, #1, DONE_S 
		Ldx	stepper_c					      	;load count to x
		inx									          ;increment count
		stx stepper_c 
		Cpx	#0234		                	;see if equal to 30ms
		Bne	DONE_S					    ;
		Ldx	#0		                  	;reset to 0 if 30ms
		MOVB #1, stepper_r
		MOVW #0, stepper_c
		
		rts
		
;------------------------------End of the Fill Process---------------------------;
StepperS3:
    ldaa stepper_r
    cmpa #1
    beq  DONE_S 
		Ldx	stepper_c						      ;load count to x
		inx									          ;increment count
		stx stepper_c 
		Cpx	stepper_num		            ;see if equal to 30ms
		Bne	DONE_S					    ;
		Ldx	#0		                    ;reset to 0 if 30ms
		ldaa stepper_it
		inca
		staa stepper_it
		MOVB #1, stepper_r
		MOVW #0, stepper_c

    rts
    
DONE_S:
        rts