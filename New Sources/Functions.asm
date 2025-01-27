    XDEF Date_Change, Time_Change, SONG_TIME_START, Song, Cont_Men, MENU
    
    
    XREF scan, Date_Start, date_str, disp, display_string, enter_f, seloff
    XREF Door_Song, Door_Song_Start,menu_str, command, prev_val, GenSelStr
    XREF GenSel, Time_Start,clearv
                                              
    
    
;----------------------------DATE CHANGE SEQUENCE-----------------;
								
Date_Change:

	    	    jsr	scan						 	            ;keyboard scan inputs
            jsr Date_Start			 			        ;Date changing subroutine
            jsr date_str			 		  	        ;use the date string which includes date and time var
            ldd #disp				 			            ;load string
            jsr display_string
            BRCLR enter_f, #1, Date_Change 		;branch away when done
            ldx #0
            stx enter_f
		        stx seloff				 			          ;reset the offset value
            
            rts
            
;----------------------------TIME CHANGE--------------------------------;

Time_Change:
	          jsr scan								        ;keyboard scan inputs
	          jsr Time_Start						      ;time changing subroutine
	          jsr date_str	     					    ;use the date string which includes date and time var
            ldd #disp								        ;load string
            jsr display_string
            BRCLR enter_f, #1, Time_Change	;branch away when enter is pressed		
            ldx #0
		        stx seloff				 			        ;reset the offset value
            stx enter_f
            
            rts
          
;----------------------------SONG TIME--------------------------------;               
; MODIFY THIS WHEN USE WITH OTHER STUFF
; SONGS DONE
;
SONG_TIME_START:

            jsr Door_Song_Start 						;Song start sequence
Song:
            jsr Door_Song		  						  ;Song sequence
      
            bra Song			  						    ;loop until done with someting

;----------------------------MAIN MENU--------------------------------;
; Use this with the main menu screen
; Done
;
MENU:
	          ;bset command, #0
	          jsr scan									      ;look for the F key (enter key)
	          jsr menu_str    							  ;display the menu string
	          ldd #disp		
	          jsr display_string						  ;If enter then exit loop if not then keep looping menu
	                                          ;Check to see if the enter_f command is set
	          BRCLR   clearv, #1, MENU
	          ldab    command
	          cmpb    #15
	          bne     MENU
	          bset    enter_f, #1
	          ldx     #0
	          stx     enter_f 								    ;reset enter flag
	
	          rts
;----------------------------

;----------------------------Control Menu--------------------------------;
; After main menu password
; WIP
;
Cont_Men:
	          jsr   scan	   								;keyboard input scan
	          jsr   GenSel									;generator selection subroutine
	          jsr   GenSelStr								;generator selection String
	          ldd   #disp
	          jsr   display_string
	          BRCLR enter_f, #1, Cont_Men
	          ldx   #0
          	stx   seloff									;reset offset value
	          stx   enter_f	 								;reset enter flag
	
	          rts
	