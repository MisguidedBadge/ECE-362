		XDEF	User_name
		XREF	admin_u,disp,display_string

User_name:
            	jsr   admin_u         ;Display default admin username   
            	ldd   #disp           ;store effective address of admin display
           	  jsr   display_string  ;display admin display
           	      
           	      rts