    XDEF Date_Change, Time_Change, SONG_TIME_START, Song, Cont_Men, MENU, CoalFiller
    
    
    XREF scan, Date_Start, date_str, disp, display_string, enter_f, seloff,Change_pass
    XREF Door_Song, Song_Start,menu_str, command, prev_val, GenSelStr, Fill_Coal,Change_date_time
    XREF GenSel, Time_Start,clearv,stepper_r,scan_switch,syst_set_f,clearpassv,screen_sel
                                              
    
    
;----------------------------DATE CHANGE SEQUENCE-----------------;
								
Date_Change:

	    	      jsr	scan						 	        ;keyboard scan inputs
            	jsr Date_Start			 			      	;Date changing subroutine
            	jsr date_str			 		  	        ;use the date string which includes date and time var
            	ldd #disp				 			        ;load string
            	jsr display_string
            	BRCLR enter_f, #1, Date_Change 				;branch away when done
            	ldx #0
            	stx enter_f
		          stx seloff				 			        ;reset the offset value
            
            	rts
            
;----------------------------TIME CHANGE--------------------------------;

Time_Change:
	          	jsr scan								    ;keyboard scan inputs
	          	jsr Time_Start						      	;time changing subroutine
	         	jsr date_str	     					    ;use the date string which includes date and time var
            	ldd #disp								    ;load string
           	 	jsr display_string
            	BRCLR enter_f, #1, Time_Change				;branch away when enter is pressed		
            	ldx #0
		        stx seloff				 			    ;reset the offset value
            	stx enter_f
            
            	rts
          
;----------------------------SONG TIME--------------------------------;               
; MODIFY THIS WHEN USE WITH OTHER STUFF
; SONGS DONE
;
SONG_TIME_START:

            	jsr Song_Start 						  		;Song start sequence
Song:
            	jsr Door_Song		  						;Song sequence
      
           		bra Song			  						;loop until done with someting

;----------------------------MAIN MENU--------------------------------;
; Use this with the main menu screen
; Done
;
MENU:
	          	;bset command, #0
	          	jsr scan									;look for the F key (enter key)
	          	jsr scan_switch								;looks for switches, MUST fip a switch first time routine is entered		
	          	jsr menu_str    							;display the menu string
	          	ldd #disp		
	          	jsr display_string						  	;If enter then exit loop if not then keep looping menu
	                                            			;Check to see if the enter_f command is set
	          	BRCLR   clearv, #1, MENU
	          	ldab    command
	          	cmpb    #15
	          	bne     MENU
	          	bset    enter_f, #1
	          	ldx     #0
	          	stx     enter_f 							;reset enter flag
	
	          	rts
;----------------------------

;----------------------------Control Menu--------------------------------;
; After main menu password
; WIP
;
Cont_Men:		movb  #0,command		
				movb  #1,syst_set_f							;flag that indicates if system settings menu has been accessed. This will start a 10 second timer in rti if a,b, or f aren't pressed on hex pad
	          	jsr   scan	   								;keyboard input scan
	          	jsr   GenSel								;generator selection subroutine
	          	jsr   GenSelStr								;generator selection String
	         	ldd   #disp
	          	jsr   display_string
;-------------------check if a or b pressed------------------------------------------------
	         	ldab	command
	          	cmpb	#11
	          	beq	  pass_screen							;go to change password screen if b
	         	cmpb	#10
	         	beq	  time_screen              				;go to change data and time screen if a
	         	bra	  skip
;go to change password screen.Will have to change passv variables (verify password variables) since pass is input and is compared to passv	         		
pass_screen:  movb  #0,command              ;clear command so it doesn't keep going
              jsr   Change_pass
              ldab  command
              cmpb  #10
              beq   Cont_Men                ;A pressed, goes back to generator display
              cmpb  #11
              beq   time_screen             ;B pressed, goes to change data and time screen
              bra   pass_screen             ;stay here until a or b is pressed
				
				;WORK ON A & B OPTIONS FIRST
				;if password is changed, the lcd will clear the 'pass' variables and stay on change pass screen until a or b are pressed 
				
;go to change date screen
time_screen:  ;movb  #0,command              ;clear command so it doesn't keep going
              jsr   Change_date_time        ;user inputs and changes date and time here
              ldab  command
              cmpb  #10
              beq   pass_screen             ;A pressed, goes back to pass_screen
              cmpb  #11
              beq   Cont_Men                ;B pressed, goes to generator display
              ;jsr   date and time changed successfully
              bra   time_screen             ;stay here until a or b is pressed		
	         		
skip:	         	
	          	BRCLR enter_f, #1, Cont_Men
	          	ldx   #0
          	    stx   seloff								  ;reset offset value
	          	stx   enter_f	 							  ;reset enter flag
				movb  #0,syst_set_f							;indicates left control menu (system settings menu) so rti doesn't pick up on it	
	          	rts
	          

	          
CoalFiller:		brclr	stepper_r, #1, CoalFiller2			;Branches away from filling for 30ms delay 
				jsr		Fill_Coal							;Fill coal subroutine
CoalFiller2:	jsr		Door_Song							;Play the door song
				rts		
	