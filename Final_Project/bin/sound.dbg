    XDEF Door_Song, Door_Song_Start, sound_rdy         

    XREF SendsChr, PlayTone, tone_count  

MY_EXTENDED_ROM: SECTION
song1:    dc.b    120, 150, 10, 20, 0

MY_EXTENDED_RAM: SECTION
place:    	ds.w    1
sound_rdy: 	ds.b	1

MY_SONG:	SECTION

Door_Song_Start:      
;            jsr Start
            ldx #0  ;load the address of song 1
            stx place
            rts 
Door_Song:  
            
            ldy sound_rdy  ;see if the sound hit the right frequency
            cpy 1		   ;determined in the ISR
            beq DONE
            
            ldx place    ;load x with the place within the song
            ldaa #0
            ldab song1, x
            cmpb 0
            beq  Door_Song_Start  ; loop song if at the end
            
            inx
            stx  place
            
            std tone_count
            
            psha  ; note
            pshd  ; Dummy            
            jsr SendsChr

            leas +3, sp ;compensate for the stack
            

            MOVB #1, sound_rdy
            
            bra DONE
            

;Start:      
            ;pshx
            ;pshy
            ;pshd

DONE:     RTS


