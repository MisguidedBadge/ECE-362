     XDEF  Change_date_time
    XREF  date_str,disp,display_string,seloff,Date_Change,clearv
    XREF  Time_Change            

 Change_date_time:
;Show default Date and TIme			
				    jsr 	date_str				;show the default time
				    ldd 	#disp									     
				    jsr 	display_string
;User changes date and time				
				    MOVW 	#0, seloff			
				    jsr 	Date_Change	     		;jump to date change subroutine
      		  MOVB 	#0, clearv
			  	  jsr 	Time_Change				;jump to time change subroutine
      	    MOVB 	#0, clearv