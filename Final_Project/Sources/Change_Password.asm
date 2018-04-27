		XDEF	Change_pass
		XREF	Default_PW,Default_RE_PW,PW_Creation,Pass_wordV2,PW_Verify,compare_PW2,chng_pass_display				
		XREF	equal_f,Pass_changed,password_changed_display,command,PW_Verify2,control_reset,go_home			
Change_pass:
            	pshd
				jsr		chng_pass_display		;default change password display				
				bra 	skip            		;skip the re_enter password subroutine				
no_match:		jsr 	Default_RE_PW   		;show default "re_enter password" screen			
skip:		  	jsr 	PW_Creation	    		;Display users password inputs

;---------------check if a or b was pressed in PW_Creation so it doesn't try and verify password
;pass and passv2 variables should have been cleared if a or be was pressed
				brset	go_home,#1,leave
				ldab	command
				cmpb	#11
				beq		leave	  				  ;B was entered so leave
				cmpb	#10
				beq		leave					  ;A was entered so leave
	                                    											
				jsr 	Pass_wordV2				  ;default verify password screen			
				jsr 	PW_Verify2				  ;Re_type password to verify
;---------------check if a or b was pressed in PW_Verify2 so it doesn't try and verify password
;pass and passv2 variables should have been cleared if a or be was pressed
				ldab	command
				cmpb	#11
				beq		leave	  				  ;B was entered so leave
				cmpb	#10
				beq		leave					  ;A was entered so leave
								
				jsr 	compare_PW2			
			  	brclr 	equal_f,#1, no_match
            	jsr   	password_changed_display  ;display 'password changed succesfully'

			
				    

leave:
				puld
			    rts