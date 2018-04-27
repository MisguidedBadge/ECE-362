 	Xdef    start_c, RTI_ISR,sound_c, stepper_c, stepper_num, stepper_it
	Xref	SECOND, start_f, date_f, PlayTone, sound_f,sound_rdy,repass, em_v, EM_Song, stepper_r, stepper_s, PowScale


MY_EXTENDED_RAM: section
start_c	ds.w	1
sound_c	ds.w	1
stepper_c ds.w	1
stepper_it	ds.b	1	;stepper iteration... this is to make the stepper slowly go up in value
stepper_num	ds.w	1	;stepper delay
coal1	ds.w	1		; overall 32 bit value since it takes 240 mil total counts from 1% to step 1%
coal2	ds.w	1		; 2.4 mill per percent at 100%
coal3	ds.w	1		; generator 2  480 mil total count from 1% to step 1%
coal4	ds.w	1		; 4.8 mill per percent at 100%
coal5	ds.w	1		; generator 3  	 720 million at 1% to step 1%
coal6	ds.w	1		; 

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
    
		
;----------------------SOUND CHECK------------------------------------;
;Check if sound is ready to play from sound.asm
;
;			
		BRSET sound_rdy, #1, DONE_SOUND				;Sound routine to run if flag set

DONE_SOUND:


;----------------------STEPPER CHECK------------------------------------;
;Check if stepper motor is ready to go from CoalFill.asm
;
;			
		BRCLR stepper_s, #1,DONE_STEPPER					;Stepper routine to run if flag set

DONE_STEPPER:
		
		
 
		bra exit_ISR
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
					



		

;----------------------Stepper Motor--------------------------------;
Stepper:
		
		
		
		

		
		ldab #1			;load coal step value
		ldaa PowScale   ;multiply by the power output (potentiometer)
		mul
		
		
		
;-----------------------------Stepper Coal filling Start------------------------;		
		BRCLR stepper_it, #1, StepperS1	;8 iterations before going up in value
		ldx stepper_num
		cpx #130
		beq StepperS2
		dex
		stx stepper_num
		MOVB #0, stepper_it
		bra StepperS1
;----------------------------Stepper Coal Filling Finish------------------------;	
		
		
StepperS1:
		BRSET stepper_r, #1, DONE_STEPPER
		Ldx	stepper_c						;load count to x
		inx									;increment count
		stx stepper_c 
		Cpx	stepper_num		                	;see if equal to 30ms
		ble	DONE_STEPPER					;
		Ldx	#0		                  		;reset to 0 if 30ms
		ldab stepper_it
		incb
		stab stepper_it
		MOVB #1, stepper_r
		MOVW #0, stepper_c
		
		lbra	 DONE_STEPPER
		

StepperS2:
		BRSET stepper_r, #1, DONE_STEPPER 
		Ldx	stepper_c						;load count to x
		inx									;increment count
		stx stepper_c 
		Cpx	#0130		                	;see if equal to 30ms
		Bne	DONE_STEPPER					;
		Ldx	#0		                  		;reset to 0 if 30ms
		MOVB #1, stepper_r
		MOVW #0, stepper_c
		
		lbra	 DONE_STEPPER



;--------------------EXIT Interrupt---------------------------------------;		
exit_start_ISR:
            stx start_c
            bset $37, #$80    
       
		    rti
		
		
exit_ISR:   bset $37, #$80
			rti