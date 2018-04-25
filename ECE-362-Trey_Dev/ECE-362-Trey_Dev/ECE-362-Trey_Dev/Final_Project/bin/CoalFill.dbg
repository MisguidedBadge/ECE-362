	XDEF  Fill_Coal,Coal_S
	
	XREF  port_p, stepper_r, stepper_c, stepper_s, stepper_num, stepper_it
	
	
MY_EXTENDED_ROM: SECTION
array:	dc.b	$0A, $12, $14, $0C, 0

MY_EXTENDED_RAM: SECTION
coal_place	ds.w	1

Coal:	Section


		
		

Coal_S:       
			  ;reset stepper values and ready interupt
			  movb	#0, stepper_r
			  movb	#1, stepper_s
			  movw	#0, stepper_c
			  movw	#500, stepper_num
			  movb  #0, stepper_it
			  rts
Fill_Coal_S:
			  LDX  #array 				;load with the first element address
			  stx  coal_place
			  rts
Fill_Coal:    
			
			  LDX	coal_place
			  LDAA 1,X+   				;load value of element and increment x
              
              CMPA 0 					;check and see if it went past the array
              BEQ  Fill_Coal_S  		;if it is then go back
              
              STAA port_p 				;store for stepper output
              STX  coal_place
              movb #0, stepper_r
              BRA  DONE
              

Coal_F:
			  ;Set values to unuseable state for ignoring interupt
			  movb	#0, stepper_s
              movb	#1, stepper_r 
DONE:      
               rts
