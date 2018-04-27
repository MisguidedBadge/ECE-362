	
	XDEF GenSel
	
	XREF command, seloff, enter_f, prev_val, gens1, gens2, gens3, clearv
MY_EXTENDED_ROM: SECTION
numbers:    dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9

;number options for the time


;letter options for the name

MY_EXTENDED_RAM: SECTION


Highlight_section: SECTION



;In control menu highlight the selected generator
;Use ASCII char
;----------------------GENERATORS SELECTION BELOW--------------------
GenSel:
            pshd
            pshx
            pshy


            ldab command    ;load the register with the value of command
            cmpb prev_val
            lbeq  DONE
            cmpb #6         ;Right
            lbeq  R_num
            cmpb #4         ;Left
            lbeq  L_num
            BRCLR clearv, #1, DONE
            cmpb #15
            lbeq  F_key  
            bra  DONE		    ;Jump to Done (No change) 

;-------------Shift Number Place Right--------------------------;
R_num:
            ldx seloff        ;load selection offset
            cpx #2            ;see if selection is at the furthest right
            beq r_res     	  ;if so then reset
            inx               ;increment the selection to the next right value if not
            stx seloff
            bra SEL           ;Change selection   
  
;-------------Shift Number Place Left--------------------------;
L_num:      
            ldx seloff        ;load selection offset
            cpx #0            ;see if selection is at the furthest right
            beq l_res     	  ;if so then reset
            dex               ;decrement the selection to the next right value if not
            stx seloff
            bra SEL
            
;-------------Exit the Sequence--------------------------------;             
F_key:      movb #1,enter_f   ;set zero flag for enter_f          
            bra DONE


l_res: 	ldx #2				  ;reset when too far left
        stx seloff			  
        bra SEL  

r_res: 	ldx #0				  ;reset when too far right
        stx seloff
        bra SEL  
            
            
SEL:						;Selection value change      
		;BRSET seloff, #$2,Sel2	 	;branch to selection 2
		;BRSET seloff, #$1,Sel1		;branch to selection 1
		cpx #2
		beq Sel2					;branch to selection 2
		cpx #1
		beq Sel1					;branch to selection 1
		
		bra	Sel0 					;branch to selection 0
		
Sel0:
	   	MOVB #$2D, 	gens1	   		; Set selection to generator 1
	   	MOVB #$20,	gens2			; reset the rest of generators
	   	MOVB #$20,	gens3
		bra	DONE

Sel1:
		MOVB #$2D, 	gens2			; Set selection to generator 2
		MOVB #$20,	gens1			; reset the rest of generators
		MOVB #$20,	gens3
		bra DONE
		
Sel2:
		MOVB #$2D, 	gens3			; Set selection to generator 3
		MOVB #$20,	gens1			; reset the rest of generators
		MOVB #$20,	gens2
		bra DONE
;--------------------------------END GENERATOR SELECTION----------------
					
DONE:		
		MOVB command, prev_val 
		;MOVB #0, command     ;I cleared this so we could detect a and b inputs
		
		
		puly
		pulx
		puld	
        rts