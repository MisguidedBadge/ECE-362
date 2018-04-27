 	Xdef    start_c, RTI_ISR,sound_c, stepper_c, stepper_it, stepper_num
	
	
  XREF  on_off, Use_Coal, SOUND_RT, EM_SOUND, Stepper
	Xref	SECOND, start_f, date_f, PlayTone, sound_f,sound_rdy,repass, em_v, EM_Song, stepper_r, stepper_s


MY_EXTENDED_RAM: section
start_c	ds.w	1
sound_c	ds.w	1
stepper_c ds.w	1
stepper_it	ds.b	1	;stepper iteration... this is to make the stepper slowly go up in value
stepper_num	ds.w	1	;stepper delay



My_code:	section

	
RTI_ISR:

;----------------------Start Sequence------------------------------------;
;Starting sequence delay sequence Procs twice in the program
;
;	        
    
    BRCLR em_v, #1, SKIP_EM
    
    jsr EM_SOUND 

SKIP_EM:
  
        
    BRSET start_f, #1, MIDDLE		;branch after 3 seconds
		Ldx	start_c						;load count to x
		inx								;increment count
		Cpx	#23438		                ;see if equal to 3 seconds 
		lBne	exit_start_ISR				;
		BSET start_f, #1				;if 3 seconds then 
		Ldx	#0		                  	;reset to 0 if 3 seconds
		lbra exit_start_ISR

		




;----------------------MIDDLE SEQUENCE------------------------------------;

	
MIDDLE: 
    

    BRSET on_off, #7, DONE_COAL
    jsr Use_Coal
    
DONE_COAL: 
		
;----------------------SOUND CHECK------------------------------------;
;Check if sound is ready to play from sound.asm
;
;			
		BRCLR sound_rdy, #1, DONE_SOUND				;Sound routine to run if flag set
		jsr SOUND_RT

DONE_SOUND:


;----------------------STEPPER CHECK------------------------------------;
;Check if stepper motor is ready to go from CoalFill.asm
;
;			
		ldaa stepper_s
		cmpa #1
		bne  DONE_STEPPER
		jsr  Stepper
		;BRSET stepper_s, #1,Stepper					;Stepper routine to run if flag set

DONE_STEPPER:
		
		
 
    bra exit_ISR
 ;----------------------END MIDDLE SEQUENCE-------------------------------;

					



;--------------------EXIT Interrupt---------------------------------------;		
exit_start_ISR:
    stx start_c
    bset $37, #$80    
       
	  rti
		
		
exit_ISR:   
    bset $37, #$80
		rti