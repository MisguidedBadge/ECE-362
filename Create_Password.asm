        XDEF    PW_Creation
        XREF    Password_start,PW_String,disp,display_string
        XREF    enter_f,cursor,scan

PW_Creation:          jsr	    scan		   		    ;check keypad input
			    jsr	    Password_start 		    ;manipulates keypad input and provides a PW output
			    jsr	    PW_String			    ;store input into variables
			    ldd	    #disp
			    jsr	    display_string		    ;display input (password)
			    BRCLR   enter_f, #1,PW_Creation ;branch away when f is pressed
			    movb    #0,enter_f		        ;reset f flag
			    movw    #0,cursor	            ;reset cursor location
			    rts