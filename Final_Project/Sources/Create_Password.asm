        XDEF    PW_Creation
        XREF    Password_start,PW_String,disp,display_string,chng_pass_str
        XREF    enter_f,cursor,scan,syst_set_f,control_reset,command,go_home

PW_Creation:
              
          jsr	    scan		   		          ;check keypad input
			    jsr	    Password_start 		      ;manipulates keypad input and provides a PW output
			    brset   syst_set_f,#1,Chng_PW_Str           ;branch if system settings is open
			    jsr	    PW_String			          ;store input into variables
			    bra     skip                   ;skip changepassword screen
Chng_PW_Str:
          		jsr     chng_pass_str			;holds 'pass' variables to change them
skip:
			    ldd	    #disp
			    jsr	    display_string		      ;display input (password)
			    
;--------------check if a or b pressed or if go home flag is set-------------------------------------
			brset	go_home,#1,reset_pass_passv2
            	ldab  command             ;skip below code if a or b is pressed
            	cmpb  #10
            	beq   reset_pass_passv2
            	cmpb  #11
            	bne	  skip2
 
reset_pass_passv2:
				jsr		control_reset
				bra		skip3            	
skip2:			     		    			    
			    BRCLR   enter_f, #1,PW_Creation ;branch away when f is pressed
skip3:
			    movb    #0,enter_f		          ;reset f flag
			    movw    #0,cursor	              ;reset cursor location
			    brset   syst_set_f,#1,leave      ;check if in control menu, leave so command flag isn't reset
			    clr     command                 ;reset command so program doesn't keep going
			    			    
leave:			    
			    rts