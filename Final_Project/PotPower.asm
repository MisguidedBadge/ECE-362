
    XDEF  PowScale,PotRead
	
	XREF read_pot, pot_value
	
	
MY_EXTENDED_ROM: SECTION


MY_EXTENDED_RAM: SECTION
PowScale	ds.b	1

PotPow:	Section


PotRead:
			jsr read_pot    ; read potentiometer value
			
			ldd pot_value		; load into D the pot value from 0-255
		    ldaa #100			  ; load a with 100
			
			mul					    ; a*b = normalized value from 0 to 100 percent
			
			
			ldx #130				  ; divide by 255 to normalize
			
			idiv				    ; d/x x = value d = remaineder "dont care"
			
			xgdx				    ; exchange d with x
			

			stab PowScale		; store value into power scale
			
			rts