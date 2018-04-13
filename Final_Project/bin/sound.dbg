    XDEF Door_Song, Door_Song_Start       

    XREF SendsChr     

MY_EXTENDED_ROM: SECTION
song1:    dc.b    $45, $97, $01, $50, 0

MY_EXTENDED_RAM: SECTION
place:    ds.b    1


Door_Song_Start:      
;            jsr Start
            ldx #song1  ;load the address of song 1
            stx place
             
Door_Song:  
            
            ldx place
            ldaa 1, x+
            cmpa 0
            beq  Door_Song_Start
            
            psha  ; note
            pshd  ; Dummy            
            CALL SendsChr

            leas +3, sp ;compensate for the stack
            
            inx
            stx  place
            
            bra DONE
            

;Start:      
            ;pshx
            ;pshy
            ;pshd

DONE:     RTS


