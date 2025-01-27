    XDEF Door_Song, Door_Song_Start, sound_rdy         

    XREF SendsChr, PlayTone, sound_c

MY_EXTENDED_ROM: SECTION
;;-------------------------NOTES LOOKUP TABLE-------------------;
C3		equ	 60
C3s		equ	 56
D3		equ	 53
D3s		equ	 50
E3		equ	 47
F3		equ	 45
F3s		equ	 42
G3		equ	 40
G3s		equ	 38
A3		equ	 36
A3s		equ	 34
B3		equ	 32
C4		equ	 30
C4s		equ	 28
D4		equ	 27
D4s		equ	 25
E4		equ	 24
F4		equ	 22
F4s		equ	 21
G4		equ	 20
G4s		equ	 19
A4		equ	 18
A4s		equ	 17
B4		equ	 16
C5		equ	 15
C5s		equ	 14
D5		equ	 13
D5s		equ	 13
E5		equ	 12
F5		equ	 11
F5s		equ	 11
G5		equ	 10
G5s		equ	 9
A5		equ	 9
A5s		equ	 8
B5		equ	 8
C6		equ	 7
C6s		equ	 7
D6		equ	 7
D6s		equ	 6
E6		equ	 6
F6		equ	 6
F6s		equ	 5
G6		equ	 5
G6s		equ	 5
A6		equ	 4
A6s		equ	 4
B6		equ	 4
C7		equ	 4
C7s		equ	 4
D7		equ	 4
D7s		equ	 3
E7		equ	 3
F7		equ	 3
F7s		equ	 3
G7		equ	 3
G7s		equ	 2
A7		equ	 2
A7s		equ	 2
B7		equ	 2
;;-------------------------NOTES LOOKUP TABLE-------------------;

song1    dc.b    E5, E5, F5, G5, G5, E5, D5, C5, C5, D5, E5, E5, D5, D5,  0			; door open song
song2	 dc.b	 G5,A3, 0  															; emergency song

MY_EXTENDED_RAM: SECTION
place:    	ds.w    1
sound_rdy: 	ds.b	1

MY_SONG:	SECTION

Door_Song_Start:      

            ldx #0  				;Start at 0 place
            stx place				;
            rts 					;
Door_Song:  

            ldaa sound_rdy  		;load the ready signal (ISR finished note)
            cmpa #1		   			;if ready then coninue
            beq DONE
            
            ldx place   		 	;load current element used
            ldaa #0
            ldab song2, x	 		; increment to next element
            cmpb 0
            beq  Door_Song_Start  	; loop song if at the end (value is 0)
            
            inx						; increment place variable
            stx  place				; store place
            
            ldy #$0AFF				; load a "delay" plays notes this many times to get a stable sound
            sty sound_c				; store for use in ISR
            
            
            pshb  ; note
                    
            jsr SendsChr			; use send chrs to update the note

            leas +1, sp 			;compensate for the stack
 

            MOVB #1, sound_rdy		; ready sound for ISR
            
            bra DONE
            



DONE:     RTS


