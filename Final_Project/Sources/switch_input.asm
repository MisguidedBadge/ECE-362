            XDEF  scan_switch  
            XREF  resetpass,check,switch_f,Default_RE_Ad,compare_PW,start_f,enter_f,User_name2
			XREF  match_a,display_string,disp,PW_Creation,equal_f,Re_Username,re_admin_u,user_chng2
			XREF  compare_Admin,port_t,Default_RE_PW,on_off,flag,choose,Default_PW,scan,cursor,loading		
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
loop:      		ldaa  	check      					;load in previous values
      			cmpa  	port_t       				;check if switches have changed
      			lbne   	change      				;branch if switch values have changed
      			      			     			
      			brset 	port_t,#%00000111,gen123	;Turn on all generators
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change
      			brset 	port_t,#%00000011,gen12  	;Turn on Generators 1 & 2
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change
      			brset 	port_t,#%00000101,gen13  	;Turn on Generators 1 & 3
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change
      			brset 	port_t,#%00000110,gen23  	;Turn on Generators 2 & 3
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change      			    				    			     	     			    
      			brset 	port_t,#%00000001,gen1  	;Turn on Generator 1
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change      			
      			brset 	port_t,#%00000010,gen2  	;Turn on Generator 2
      			cmpa	port_t						;enter admin and pw if switch changes
      			lbne    change      			
      			brset 	port_t,#%00000100,gen3  	;Turn on Generator 3
      			;bita #%10000000 ;switch 8 checked later
;-------USER MUST FLIP A SWITCH AT SOME POINT, 'flag' FORCES USER TO DO THIS--------      			
      			ldab	flag						;flag initially set to 1
      			cmpb	#1
      			bne		gen0						;0 switches flipped     			
      			bra		loop						;continue checking for an input      						
;------------------------Turn Generators on----------------------------------      						      			
;No generator      			
gen0:					

cont0:			movb	#0,on_off					;All Generators off
				lbra	leave
;All generators
gen123:
		    
cont7:			movb	#7,on_off					;All generators on
				lbra	leave			
;Generators 1 and 2		
gen12:

cont3:			movb	#3,on_off					;Generators 1 and 2 on
				lbra	leave								
;Generators 1 and 3
gen13:

cont5:	     	movb	#5,on_off					;Generators 1 and 3 on
				lbra	leave				
;Generators 2 and 3				
gen23:
		
cont6:			movb	#6,on_off					;Generators 2 and 3 on
				lbra	leave				
;Generator 1      
gen1:

cont1:			movb	#1,on_off					;Generator 1 on
				lbra	leave	  			
;Generator 2
gen2:

cont2:			movb	#2,on_off					;Generator 2 on
				lbra	leave				
;Generator 3
gen3:
		    
cont4:			movb	#4,on_off					;Generator 3 on
				lbra	leave			
;-------------------------------ENTER ADMIN WHEN SWITCH PRESSED---------------------     
change:			staa	check						;store new switch value	
		     	movb  	#1,switch_f       			;indicates a switch has been flipped
back2:		    jsr		User_name2					;show default enter username screen						
		     	bra		skip2
;-------------------------------USER ENTERED WRONG USERNAME---------------------------		     	
no_match_a:		jsr	  	Default_RE_Ad				;display default re_enter admin
				bra		back2					
;--------------------------------------------------------------------------------------
skip2:			jsr		user_chng2					;display username inputs
				jsr		compare_Admin				
				
				brclr	equal_f,#1,no_match_a		;Re_enter if no match
		     
		     	
		     	jsr		match_a						;display that usernames match
		     	ldd		#disp
		     	jsr		display_string				
		        movb	#0,start_f
		        
RSRTMSG3:	    brclr	start_f,#1,RSRTMSG3			;delay the message

;----------------------------------ENTER PASS AFTER ADMIN------------------------
back:			jsr 	Default_PW   				;show enter password screen
				bra		skip						;skip "try again" message
;-------------------------------USER ENTERED WRONG PASSWORD----------------------------				
no_match_p:		jsr		Default_RE_PW				;show default "re_enter password" screen
RSRTMSG4:	    brclr	start_f,#1,RSRTMSG4			;delay the message
				bra		back
;--------------------------------------------------------------------------------															
skip:			jsr 	PW_Creation	    			;Display users password inputs
				jsr 	compare_PW					;checks if password is correct
				
				brclr 	equal_f,#1, no_match_p		;re_enter if no match
				;ldab	homeflag					;to skip load homescreen and display which generator i on isntead
				;cmpb	#0
				;beq		display_gen					;display which generator is turned on
				jsr		loading 					;display loading home screen
				;movb	#1,homeflag					;so loading screen isn't displayed anymore
;display_gen:	jsr		;A DISPLAY THAT DISPLAYS WHICH GENERATOR WAS FLIPPED ON 				
;branch back to the generator(s) that was/were previously flipped on
				movb	port_t,choose				;store switch value into choose				
				ldaa	choose
				cmpa	#0
				lbeq	cont0 
				cmpa	#1
				lbeq	cont1	
				cmpa	#2
				lbeq	cont2							     	
      			cmpa	#3
      			lbeq	cont3
      			cmpa	#4
      			lbeq	cont4	
      			cmpa	#5
      			lbeq	cont5
      			cmpa	#6
      			lbeq	cont6
      		    cmpa	#7	
      			lbeq	cont7


leave:			staa	check						;store previous switch value
				movb	#0,flag						;set flag to 0 after first time leaving
      			puly
      			pulx
      			puld 
      			rts