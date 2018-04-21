            XDEF  switch_input  
            XREF  resetpass,check,switch_f

;switch_inputs, checks switch port basically
;switches are constantly checked
;ANYTIME a change is made, user must enter
;username and password and it must be verified as correct
;else they must re_enter until it is correct


;push registers to save onto stack

switch_input:
      			pshd
      			pshx
      			pshy
      
      ;need to store switch value into memory and compare each loop
      ;to see if any changes have been made to the switches
      ;if change has been made, then a separate label will be used
      ;to prompt user to enter their username and pw
      			ldaa  port_t      ;load in switch values
      			cmpa  check       ;check if switches have been changed
      			bne   change      ;branch if switch values have changed    
      			bita  #%00000001  ;check switch 1
      			brset gen1        ;branch if on
      			bita  #%00000010  ;check switch 2
      			brset gen2        ;branch if on
      			bita  #%00000100  ;check switch 3
      			brset gen3        ;branch if on
      			;bita #%10000000 ;switch 8 checked later

;anytime switch is pressed, user must enter username and pw      
change:			staa  check				;store new switch value	
		     	movb  #1,switch_f       ;indicates a switch has been flipped
		     	jsr	  re_admin_u		;display default re_enterPW
		     	jsr	  Re_Username		;Username Inputs
		     	
		     	
            	;jsr   resetpass        ;reset pass variables to enter again
 ;need to create separate username variables to compare      

      
gen1: 


gen2:


gen3:




      			puly
      			pulx
      			puld 
      			rts