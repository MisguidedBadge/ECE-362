
  XDEF EM_SOUND, SOUND_RT
  
  XREF sound_c, PlayTone, sound_rdy, EM_Song                


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
		rts
		
;----------------------SOUND DONE PATH--------------------------------;
;Check if sound is ready to play from sound.asm
;
;
done_sound:		
		MOVB #0, sound_rdy				;Reset sound flag to let sound.asm play new note
	  rts