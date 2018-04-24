        XDEF    compare_PW,compare_Admin 
        XREF    cursor,pass,passv,equal_f,namev,name

;COMPARE PASSWORDS
compare_PW:		ldx	    cursor			        ;load initial cursor location
compare_p:		ldab	pass,x	                ;load both password inputs
			    ldaa    passv,x
			    cba	
			    bne	    notequal_p		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				        ;check if at end of string
			    beq     equal_p		            ;strings must be equal
			    bra	    compare_p			        ;continue comparing
			
notequal_p:	    movb	#0,equal_f	            ;denotes not equal
		        movw	#0,cursor	            ;reset cursor location
		    		      
;REINITIALIZES PASSWORD ASCII VALUES TO SPACE ASCII VALUES (user entered different passwords)
			    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
pass_res2:	    stab	pass,x
			    inx
			    cpx     #16
			    bne	    pass_res2               ;branch until PW initialized to all spaces
			
			    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
passv_res2:	    stab    passv,x             
			    inx
			    cpx     #16
			    bne	    passv_res2              ;branch until PW reinitialized to all spaces		      	
		        rts
		        
;COMPARE USERNAMES		
compare_Admin:	ldx	    cursor			        ;load initial cursor location
compare_a:		ldab	name,x	                ;load both password inputs
			    ldaa    namev,x
			    cba	
			    bne	    notequal_a		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				        ;check if at end of string
			    beq     equal_a		            ;strings must be equal
			    bra	    compare_a			    ;continue comparing
			
notequal_a:	    movb	#0,equal_f	            ;denotes not equal
		        movw	#0,cursor	            ;reset cursor location


;REINITIALIZES USERNAME ASCII VALUES TO SPACE ASCII VALUES (user entered different passwords)
			    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
name_res2:	    stab	name,x
			    inx
			    cpx     #16
			    bne	    name_res2               ;branch until PW initialized to all spaces
			
			    ldab	#$20	                ;ascii space value
			    ldx	    #0	                    ;initialize x
namev_res2:	    stab    namev,x             
			    inx
			    cpx     #16
			    bne	    namev_res2              ;branch until PW reinitialized to all spaces		      	
		        rts
		        
;EQUAL PASSWORDS		      
equal_p:		movb    #1,equal_f	            ;denotes equal
	      	    nop 				            ;strings must be equal
	      	    rts
;EQUAL USERNAMES
equal_a			movb	#1,equal_f				;equal string flag
				nop
				rts