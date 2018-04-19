 	Xdef    start_c, RTI_ISR,sound_c
	Xref	SECOND, start_f, date_f, PlayTone, sound_f,sound_rdy



MY_EXTENDED_RAM: section
start_c	ds.w	1
sound_c	ds.w	1

My_code:	section

	
RTI_ISR:

;----------------------Start Sequence------------------------------------;
;Starting sequence delay sequence Procs twice in the program
;
;	        
        
    	BRSET start_f, #1, MIDDLE		;branch after 3 seconds
		Ldx	start_c						;load count to x
		inx								;increment count
		Cpx	#3000		                ;see if equal to 3 seconds 
		Bne	exit_start_ISR				;
		BSET start_f, #1				;if 3 seconds then 
		Ldx	#0		                  	;reset to 0 if 3 seconds
		bra exit_start_ISR
		

;----------------------MIDDLE SEQUENCE------------------------------------;
	
MIDDLE: 
    
		
;----------------------SOUND CHECK------------------------------------;
;Check if sound is ready to play from sound.asm
;
;		
		;ldaa sound_rdy					;load with the sound flag
		;cmpa #1
		;bne	skip_sound					;skip sound if the flag isn't set
		BRSET sound_rdy, #1, SOUND_RT

		bra exit_ISR
 

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
		bra exit_ISR					;exit ISR
		
;----------------------SOUND DONE PATH--------------------------------;
;Check if sound is ready to play from sound.asm
;
;
done_sound:		
		MOVB #0, sound_rdy				;Reset sound flag to let sound.asm play new note
		bra exit_ISR					;Exit ISR
					

;----------------------END SOUND---------------------------------------;
		

		
exit_start_ISR:
            stx start_c
            bset $37, #$80    
       
		    rti
		
		
exit_ISR:	bset $37, #$80
			rti