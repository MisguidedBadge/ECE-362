        XDEF    user_chng
        XREF    scan,Username_start,admin_u,disp
        XREF    display_string,enter_f,cursor

user_chng:      jsr     scan		    		;check keypad input	
                jsr     Username_start  		;manipulates keypad input and provides an output value
                jsr	    admin_u	    		    ;displays user inputs (from Username_start)
                ldd	    #disp		    		;load string address				    
                jsr	    display_string  		;display the string	
                BRCLR   enter_f, #1,user_chng	;Skip this instruction when f is pressed
	            movb	#0,enter_f	    		;reset f flag	
		        movw	#0,cursor	    		;reset cursor location
		        rts