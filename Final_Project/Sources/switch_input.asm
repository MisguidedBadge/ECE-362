            XDEF  scan_switch  
            XREF  resetpass,check,switch_f,Default_RE_Ad,compare_PW,start_f
			XREF  match_a,display_string,disp,PW_Creation,equal_f,Re_Username
			XREF  compare_Admin,port_t,Default_RE_PW,on_off,flag		
;switch_inputs, checks switch port basically
;switches are constantly checked
;ANYTIME a change is made, user must enter
;username and password and it must be verified as correct
;else they must re_enter until it is correct


;push registers to save onto stack

scan_switch:
      			pshd
      			pshx
      			pshy
      
;need to store switch value into memory and compare each loop
;to see if any changes have been made to the switches
;if change has been made, then a separate label will be used
;to prompt user to enter their username and pw
loop:      		ldaa  	port_t      				;load in switch values
      			cmpa  	check       				;check if switches have been changed
      			bne   	change      				;branch if switch values have changed
      			bita  	#%00000111  				;check all switches
      			brset 	port_t,#%00000111,gen123	;Turn on all generators
      			bita  	#%00000011  				;check switches 1 & 2
      			brset 	port_t,#%00000011,gen12  	;Turn on Generators 1 & 2
      			bita  	#%00000101  				;check switches 1 & 3 
      			brset 	port_t,#%00000101,gen13  	;Turn on Generators 1 & 3
				bita  	#%00000110  				;check switches 2 & 3
      			brset 	port_t,#%00000110,gen23  	;Turn on Generators 2 & 3	    			     	     			    
      			bita  	#%00000001  				;check switch 1
      			brset 	port_t,#%00000001,gen1  	;branch if on
      			bita  	#%00000010  				;check switch 2
      			brset 	port_t,#%00000010,gen2  	;branch if on
      			bita  	#%00000100  				;check switch 3
      			brset 	port_t,#%00000100,gen3  	;branch if on
      			;bita #%10000000 ;switch 8 checked later
;-------USER MUST FLIP A SWITCH AT SOME POINT, 'flag' FORCES USER TO DO THIS--------      			
      			ldab	flag
      			cmpb	#1
      			bne		gen0						;0 switches flipped
      			
      			bra		loop						;continue checking for an input
      						


;-------------------------ENTER ADMIN AND PW WHEN SWITCH PRESSED---------------------     
change:			staa	check						;store new switch value	
		     	movb  	#1,switch_f       			;indicates a switch has been flipped
no_match_a:		jsr	  	Default_RE_Ad				;display default re_enter admin
		     	jsr	  	Re_Username					;Username Inputs
		     	jsr	  	compare_Admin				;compare usernames
		     	brclr 	equal_f,#1, no_match_a		;re_enter username is no match
		     	
		     	jsr		match_a						;display that usernames match
		     	ldd		#disp
		     	jsr		display_string				
		        movb	#0,start_f
RSRTMSG3:	    brclr	start_f,#1,RSRTMSG3			;delay the message

;User must re_enter password
no_match_p:		jsr 	Default_RE_PW   			;show default "re_enter password" screen			
				jsr 	PW_Creation	    			;Display users password inputs
				jsr 	compare_PW					;checks if password is correct
				brclr 	equal_f,#1, no_match_p		;re_enter if no match
				
								
				nop									;username and pw match if reaches this point			     	
      
gen0:			movb	#0,on_off					;All Generators off
				bra		leave

gen123:		    movb	#7,on_off					;All generators on
				bra		leave
			
		
gen12:			movb	#3,on_off					;Generators 1 and 2 on
				bra		leave				
				

gen13:			movb	#5,on_off					;Generators 1 and 3 on
				bra		leave
				
				
gen23:			movb	#6,on_off					;Generators 2 and 3 on
				bra		leave
				

      
gen1:			movb	#1,on_off					;Generator 1 on
				bra		leave
	  			


gen2:			movb	#2,on_off					;Generator 2 on
				bra		leave
				


gen3:		    movb	#3,on_off					;Generator 3 on
				bra		leave
			



leave:
      			puly
      			pulx
      			puld 
      			rts