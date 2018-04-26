        XDEF    compare_string
        XREF    cursor,pass,passv,equal_f

compare_string:	ldx	    cursor			        ;load initial cursor location
compare:		ldab	pass,x	                ;load both password inputs
			    ldaa    passv,x
			    cba	
			    bne	    notequal		        ;strings aren't equal
			 		
			    inx
			    cpx	    #16				        ;check if at end of string
			    beq     equal		            ;strings must be equal
			    bra	    compare			        ;continue comparing
			
notequal:	    movb	#0,equal_f	            ;denotes not equal
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

;EQUAL PASSWORDS		      
equal:		    movb    #1,equal_f	            ;denotes equal
	      	    nop 				            ;strings must be equal
	      	    rts