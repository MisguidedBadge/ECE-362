        XDEF    user_chng2
        XREF    scan,Username_start2,admin_u2,disp,User_name2
        XREF    display_string,enter_f,cursor,Re_Username

user_chng2:     jsr     scan		    		;check keypad input	
                jsr     Re_Username  			;manipulates keypad input and provides an output value
                jsr	    User_name2	    		;displays user inputs (from Username_start)
                ldd	    #disp		    		;load string address				    
                jsr	    display_string  		;display the string	
                BRCLR   enter_f, #1,user_chng2	;Skip this instruction when f is pressed
	            movb	#0,enter_f	    		;reset f flag	
		        movw	#0,cursor	    		;reset cursor location
		        rts