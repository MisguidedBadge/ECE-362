        XDEF    compare_PW,compare_Admin,clearpassv,compare_PW2,control_reset
        XREF    cursor,pass,passv,equal_f,namev,name,passflag,passv2,syst_set_f,enter_f


;COMPARE PASSWORDS
compare_PW:		pshd
				pshx
				pshy
							
								
				ldx	    cursor			            ;load initial cursor location
compare_p:		ldab	pass,x	                ;load both password inputs
			    ldaa    passv,x
			    cba	
			    bne	    notequal_p		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				       	;check if at end of string
			    beq     clearpass		        ;strings must be equal
			    bra	    compare_p			    ;continue comparing
			
notequal_p:	    movb	#0,equal_f	            ;denotes not equal
		        clr		cursor	            	;reset cursor location
		    	brset	passflag,#1,skip	    ;skips clearing passv, because passv is used to verify the password that user enters.
		    		      
;REINITIALIZES PASSWORD ASCII VALUES TO SPACE ASCII VALUES (user entered different passwords)
clearpassv: 	ldab	#$20
 				ldx		#0
passv_res2:		stab	passv,x
 				inx
 				cpx		#16
 				bne		passv_res2
 				                      
skip:

			    ldab	#$20	        		;ascii space value
			    ldx	  	#0	          			;initialize x
pass_res2:	    stab	pass,x
			    inx
			    cpx   	#16
			    bne	  	pass_res2     			;branch until PW initialized to all spaces
			    ldx		#0						;reset x
			    
			    puly
			    pulx
			    puld
			    rts

;----------------NEED TO CLEAR PASS VARIABLES TO ENTER AGAIN LATER-------------------------			    
clearpass:	    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
pass_res3:	    stab	pass,x
			    inx
			    cpx     #16
			    bne	    pass_res3               ;branch until PW initialized to all spaces
			    movb	#1,passflag				;so we don't mess with passv variable again
				brset	syst_set_f,#1,swap		;branch if in control menu.				
			  	lbra		equal_p
;---------------NEED TO TRANSFER PASSV2 VARIABLES INTO PASSV, (PASSWORD WAS CHANGED IN CONTROL MENU)---------------------------			  	
swap:			ldx		#0						;start from beginning of passv2 string
transfer:		ldab	passv2,x				;passv2 to b
				stab	passv,x					;store into pass in memory
				inx
				cpx		#16
				beq		clearpassv23
				bra		transfer	
;---------------RESET PASSV2 AFTER CHANGING PASSWORD (SET PASSV)-----------------------------------------------			    
clearpassv23: 	ldab	#$20
 				ldx		#0
passv_resv2:	stab	passv2,x
 				inx
 				cpx		#16
 				bne		passv_resv2
 				lbra		equal_p			    
		        
;----------------------------------COMPARE USERNAMES-------------------------		
compare_Admin:  pshd
				pshx
				pshy					
				ldx	    cursor			        ;load initial cursor location
compare_a:		ldab	name,x	                ;load both password inputs
			    ldaa    namev,x
			    cba	
			    bne	    notequal_a		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				        ;check if at end of string
			    beq     clearnamev		        ;strings are equal so clear name variables to use them again
			    bra	    compare_a			    ;continue comparing
			
notequal_a:	    movb	#0,equal_f	            ;denotes not equal
		        clr		cursor		            ;reset cursor location


;--------REINITIALIZES USERNAME ASCII VALUES TO SPACE ASCII VALUES (user entered different usernames)----------

			
			    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
namev_res2:	    stab    namev,x             
			    inx
			    cpx     #16
			    bne	    namev_res2              ;branch until PW reinitialized to all spaces
			    
			    puly
			    pulx
			    puld		      	
		        rts
		        
;------------------NEED TO CLEAR NAMEV VARIABLES TO ENTER AGAIN LATER----------------------------------			    
clearnamev:	    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
name_res3:	    stab	namev,x
			    inx
			    cpx     #16
			    bne	    name_res3               ;branch until PW initialized to all spaces
				bra		equal_a

;----------------------------------COMPARE PASSWORDS WHEN CHANGING IN CONTROL MENU-----------------------------------------------
compare_PW2:  	pshd
				pshx
				pshy
							
								
				ldx	    cursor			        ;load initial cursor location
compare_p2:		ldab	pass,x	                ;load both password inputs
			    ldaa    passv2,x
			    cba	
			    bne	    notequal_p2		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				       	;check if at end of string
			    lbeq     clearpass		        ;strings must be equal so clear 'pass' variables
			    bra	    compare_p2			    ;continue comparing
			
notequal_p2:	movb	#0,equal_f	            ;denotes not equal
		        clr		cursor	            	;reset cursor location
				bra		skip2					

;------------------------RESET PASS AND PASSV2 BECAUSE A OR B WAS PRESSED IN CONTROL MENU------------------------------
control_reset:				
				pshd 							;Reset passv2 and pass if a or b is pressed.
				pshx
				pshy
;----------------------------------------------------------------------------------------------------------------------
skip2:				
clearpassv2: 	ldab	#$20
 				ldx		#0
passv_res3:		stab	passv2,x
 				inx
 			    cpx		#16
 				bne		passv_res3

 		 	    ldab	#$20	        		;ascii space value
			    ldx	  	#0	          			;initialize x
pass_res4:	    stab	pass,x
			    inx
			    cpx   	#16
			    bne	  	pass_res4     			;branch until PW initialized to all spaces
			    ldx		#0						;reset x
			    
			    puly
			    pulx
			    puld
			    rts						        
;-----------------------end comparepasswords2-------------------		        
;EQUAL PASSWORDS		      
equal_p:		movb    #1,equal_f	            ;denotes equal
	      	    clr		cursor 				    ;strings must be equal
	      	    puly
			    pulx
			    puld
	      	    rts
;EQUAL USERNAMES
equal_a			movb	#1,equal_f				;equal string flag
				clr		cursor
				puly
			  	pulx
			  	puld
				rts