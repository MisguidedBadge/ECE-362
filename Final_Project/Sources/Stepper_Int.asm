  XDEF Stepper, StepperS1, StepperS2, StepperS3, Stepper, step_f, amount

  XREF stepper_it, stepper_num, stepper_r, stepper_c
  
  
  ROMSEC:
 
  
  RAM:
step_f	ds.b	1
amount	ds.w	1
  
  MY_CODE: Section


;----------------------Stepper Motor--------------------------------;
Stepper:
		
	;	BRSET stepper_full, #1, StepperS3
		
	
	
	
;-----------------------------Stepper Coal filling Start------------------------;		
	;	BRCLR stepper_it, #62260, StepperS1	;8 iterations before going up in value
		ldab stepper_it
		cmpb #20
		bne	 StepperS1
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
DONE_S:
        rts


StepperS2:
		
		ldy	amount
		cpy #0
		beq StepperS3
		dey
		sty amount
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
	 ldab stepper_it
	 cmpb #20
	 bne  SS3
	 ldx  stepper_num
	 cpx  #1000
	 beq  Step_Stop


SS3:

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

Step_Stop:
		   movb #1, step_f
			rts


    
