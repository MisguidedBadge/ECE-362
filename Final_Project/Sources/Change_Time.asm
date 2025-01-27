		XDEF	Time_Change
		XREF	scan, Time_Start, date_str, disp, display_string
		XREF	seloff,enter_f

Time_Change:
	      	jsr scan				 ;keyboard scan inputs
	     	      jsr Time_Start			 ;time changing subroutine
	      	jsr date_str	     		 ;use the date string which includes date and time var
            	ldd #disp				 ;load string
            	jsr display_string
            	BRCLR enter_f, #1, Time_Change ;branch away when enter is pressed		
            	ldx #0
			stx seloff				 ;reset the offset value
            	stx enter_f
            
            	rts