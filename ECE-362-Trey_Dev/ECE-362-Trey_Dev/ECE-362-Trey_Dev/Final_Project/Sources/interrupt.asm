 	Xdef    start_c, RTI_ISR,sound_c, stepper_c, stepper_it, stepper_num
	
	
	XREF  gens1_coal, gens2_coal, gens3_coal, on_off, gc11, gc12, gc21, gc22, gc31, gc32
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
    
    BRSET em_v, #1, EM_SOUND
        
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
    

    BRCLR on_off, #7, Use_Coal
		
;----------------------SOUND CHECK------------------------------------;
;Check if sound is ready to play from sound.asm
;
;			
		BRSET sound_rdy, #1, SOUND_RT				;Sound routine to run if flag set

DONE_SOUND:


;----------------------STEPPER CHECK------------------------------------;
;Check if stepper motor is ready to go from CoalFill.asm
;
;			
		BRSET stepper_s, #1,Stepper					;Stepper routine to run if flag set

DONE_STEPPER:
		
		
 
		lbra exit_ISR
 ;----------------------END MIDDLE SEQUENCE-------------------------------;
 


;----------------------EMERGENCY SOUND ROUTINE---------------------------------;
EM_SOUND:
		jsr EM_Song	 		;play the emergency song (Needs interrupt because password reset)
		bra SOUND_RT
 

;----------------------SOUND COUNTER CHECK----------------------------;
;Check if sound count ("delay") is done
;If not then continue playing same note
;
SOUND_RT:
		ldx sound_c						;load sound count ("delay")
		cpx #0							;If 0 then sound is done playing
		beq done_sound					;
		dex								;Decrement sound count 
		stx sound_c						;Store into sound count variable
		jsr PlayTone					;jump to playtone
		bra DONE_SOUND					;exit ISR
		
;----------------------SOUND DONE PATH--------------------------------;
;Check if sound is ready to play from sound.asm
;
;
done_sound:		
		MOVB #0, sound_rdy				;Reset sound flag to let sound.asm play new note
		bra DONE_SOUND					;Exit ISR
					
;----------------------Coal Use---------------------------------------;

Use_Coal:
         BRCLR on_off, #%001, Coal2

         
         ldx gc11
         cpx 0
         beq Coal12
         dex
         bra Coal2
Coal12:
         ldx gc12
         cpx 0
         ldaa gens1_coal
         inca
         staa gens1_coal
                    

Coal2:
         BRCLR on_off, #%010, Coal3
         
         ldx gc21
         cpx 0
         beq Coal22
         dex
         bra Coal3
Coal22:
         ldx gc22
         cpx 0
         ldaa gens2_coal
         inca
         staa gens2_coal


Coal3:


Coal32:

		

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
		bra DONE_STEPPER
;----------------------------Stepper Coal Filling Finish------------------------;
		BRCLR stepper_it, #8, StepperS2
	;	ldx 		
		

;-----------------------------Filling Process Start------------------------------;		
StepperS1:
		BRSET stepper_r, #1, DONE_STEPPER
		Ldx	stepper_c						        ;load count to x
		inx									            ;increment count
		stx stepper_c 
		Cpx	stepper_num		              ;decrements down to 30 ms
		Bne	DONE_STEPPER					      ;
		Ldx	#0		                  		;reset to 0 if 30ms
		ldaa stepper_it
		inca
		staa stepper_it
		MOVB #1, stepper_r
		MOVW #0, stepper_c
		
		lbra	 DONE_STEPPER
		
;------------------------------Middle of the Process------------------------------;
StepperS2:
		BRSET stepper_r, #1, DONE_STEPPER 
		Ldx	stepper_c					      	;load count to x
		inx									          ;increment count
		stx stepper_c 
		Cpx	#0234		                	;see if equal to 30ms
		Bne	DONE_STEPPER					    ;
		Ldx	#0		                  	;reset to 0 if 30ms
		MOVB #1, stepper_r
		MOVW #0, stepper_c
		
		lbra	 DONE_STEPPER

;------------------------------End of the Fill Process---------------------------;
StepperS3:
    ldaa stepper_r
    cmpa #1
    lbeq  DONE_STEPPER 
		Ldx	stepper_c						      ;load count to x
		inx									          ;increment count
		stx stepper_c 
		Cpx	stepper_num		            ;see if equal to 30ms
		lBne	DONE_STEPPER					    ;
		Ldx	#0		                    ;reset to 0 if 30ms
		ldaa stepper_it
		inca
		staa stepper_it
		MOVB #1, stepper_r
		MOVW #0, stepper_c

;--------------------EXIT Interrupt---------------------------------------;		
exit_start_ISR:
    stx start_c
    bset $37, #$80    
       
	  rti
		
		
exit_ISR:   
    bset $37, #$80
		rti