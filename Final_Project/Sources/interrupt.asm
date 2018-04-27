
 	Xdef    start_c, RTI_ISR,sound_c, stepper_c, stepper_it, stepper_num
	
	
  XREF  on_off, Use_Coal, SOUND_RT, EM_SOUND, Stepper, PotRead
  Xref	SECOND, start_f, date_f, PlayTone, sound_f,sound_rdy,repass, em_v, EM_Song, stepper_r, stepper_s
  XREF  syst_set_f, enter_f,LCD_timer2,LCD_timer1,go_home, blink_label, blink_flag
 


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
;----------------------AUSTIN TIMERS-------------------;
	brclr	syst_set_f,#1,skip			;skip code below if not in control menu
	brclr	enter_f,#1,count				;start count if f isn't entered
	movw	#0,LCD_timer1				;clear counters if f is entered
	movw	#0,LCD_timer2	
count:	
	ldx	LCD_timer1
	cpx	#65000
	beq	count_y
	inx	
	stx	LCD_timer1
	bra	skip
count_y:
	ldy	LCD_timer2
	cpy	#13125
	beq	leave_control_menu
      iny	
      sty	LCD_timer2
      bra	skip
      
leave_control_menu:
	ldx	#0
	stx	LCD_timer1
	stx	LCD_timer2
	movb	#1,go_home			;set go_home flag so that control menu goes to homescreen
;----------------------AUSTIN TIMERS-------------------;

	     
    
skip:
    
    BRSET blink_flag,#1,Blink_label    
    BRSET em_v, #1, EM_SOUNDc        
    BRSET start_f, #1, MIDDLE		;branch after 3 seconds
	Ldx	start_c						;load count to x
		inx								;increment count
		Cpx	#23438		                ;see if equal to 3 seconds 
		Bne	exit_start_ISR				;
		BSET start_f, #1				;if 3 seconds then 
		Ldx	#0		                  	;reset to 0 if 3 seconds
		bra exit_start_ISR
    
   ; jsr EM_SOUND 


		

	



;----------------------MIDDLE SEQUENCE------------------------------------;

	
MIDDLE: 
    
    
    BRCLR on_off, #7, DONE_COAL
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

					
Blink_label:
    ldx start_c
    inx
    cpx #3906               ;check if at .5 seconds
		Bne	exit_start_ISR			;keep looping if not	
		BSET start_f, #1			  
		Ldx	#0		               
		bra exit_start_ISR 


EM_SOUNDc:
		jsr EM_SOUND
;--------------------EXIT Interrupt---------------------------------------;		
exit_start_ISR:
    stx start_c
    bset $37, #$80    
       
	  rti
		
		
exit_ISR:   
    bset $37, #$80
		rti
		
