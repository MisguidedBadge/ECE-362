		XDEF	Date_Change
		XREF	scan,Date_Start,date_str,disp,display_string
		XREF	enter_f,seloff	

Date_Change:

	    		jsr scan				 ;keyboard scan inputs
            	jsr Date_Start			 ;Date changing subroutine
            	jsr date_str			 ;use the date string which includes date and time var
            	ldd #disp				 ;load string
            	jsr display_string
            	BRCLR enter_f, #1, Date_Change ;branch away when done
           	      ldx #0
            	stx enter_f
			stx seloff				 ;reset the offset value
            
            	rts