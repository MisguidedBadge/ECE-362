 	Xdef    start_c, RTI_ISR
	Xref	SECOND, start_f, date_f, PlayTone, sound_f,sound_rdy,tone_count



MY_EXTENDED_RAM: section
start_c	ds.w	1
;sound_c	ds.w	1
My_code:	section

	
RTI_ISR:
        
        
    	BRSET start_f, #1, MIDDLE
		Ldx	start_c
		inx
		Cpx	#3000		                ;see if equal to 3 seconds 
		Bne	exit_start_ISR
		BSET start_f, #1	
		Ldx	#0		                  ;reset to 0 if 3 seconds
		bra exit_start_ISR
		
MIDDLE: 
    
        ;BRSET date_f, #1, date_change   ; go to date change section 

		
		ldaa sound_rdy	; load with the sound flag
		cmpa #1
		bne	skip_sound	; skip sound if the flag isn't set
		jsr Sound  		; jump to sound function
			
skip_sound:
				


        bra exit_ISR
    
;date_change:
Sound:
		ldx	tone_count			  ; load the sound count
		jsr PlayTone		  ; play tone
		dex					  ; decrement the counter
		cpx #0				  ; see if 0
		bne sound_cont    	  ; if not then continue
		MOVB #0, sound_rdy	  ; if yes then sound flag goes off
		stx tone_count
		rti
		
		
sound_cont:		
		    dex
		    stx tone_count
			rti
		
		
exit_start_ISR:
            stx start_c
            bset $37, #$80    
       
		    rti
		
		
exit_ISR:	bset $37, #$80
			rti