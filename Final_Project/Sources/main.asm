;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, disp, start_f, pass, passv
            XDEF command
            XDEF port_u, delay
<<<<<<< HEAD
            XDEF date,date_f, time,enter_f,name, prev_val, seloff;, User_name
            XDEF sound_f
            XDEF gens1, gens2, gens3			; generator selection
=======
            XDEF date, col,seloff, date_f, time,enter_f,User_name,name,cursor 
>>>>>>> Austin_Dev_Merge
            
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, read_pot, display_string, pot_value, init_LCD, RTI_ISR, start_c    ; symbol defined by the linker for the end of the stack
<<<<<<< HEAD
            XREF Startup_1, Startup_2, date_str, menu_str,GenSelStr
            XREF Date_Start, Time_Start
            XREF scan,admin_u, SendsChr
            XREF Door_Song, Door_Song_Start, sound_rdy,  tone_count, sound_c
            XREF GenSel,Date_Change, Time_Change, SONG_TIME_START, Song, Cont_Men, MENU, clearv
=======
            XREF Startup_1, Startup_2, date_str,re_enter,accepted
            XREF Date_Start, Time_Start, Password_start, Password_verify,Date_Change,Time_Change
            XREF User_name 
            XREF scan,admin_u,Username_start,PW_String,PW_Verify_String  
>>>>>>> Austin_Dev_Merge
            ; LCD References
	         

            ; Potentiometer References

;;--------------------------------AUSTIN's----------------;;          
MY_EXTENDED_ROM:  SECTION
delay       dc.w  1000                    ;1ms delay
keys        dc.b  $84,$42,$24,$48         ;represents hex keys 2,6,8&4 respectively
                  ;up,rght,lft,dwn
                  

port_s_ddr  equ   $24A                    ;led ddr
port_s      equ   $248                    ;leds address
port_u_ddr  equ   $26A                    ;hexpad ddr
port_u      equ   $268                    ;hexpad address
PER         equ   $26C                    ;pull_enable register
PSR         equ   $26D                    ;polarity_select
port_t_ddr	equ	  $242
port_t		equ	  $240
                  

; variable/data section
MY_EXTENDED_RAM: SECTION
user_input  ds.b 1                        ;Austin's input
;;------------------------------AUSTIN's--------------------;;

; variable/data section
MY_EXTENDED_RAM: SECTION
disp:	      ds.b 33
start_f:    ds.b 1	    ;start flag
enter_f:    ds.b 1	    ;enter flag
date_f:     ds.b 1          ;date change flag
equal_f	ds.b 1	    ;equal flag		


;temporary variables
command:    ds.b 1
prev_val:	ds.b 1	    ; previous command received from user


;Time Variables
date:    	ds.b  8		; Date string
time:		ds.b  4		; Time string
;Admin Variables
<<<<<<< HEAD
name:       ds.b  15    ; Name String
;date variables stored in mem array
seloff:   	ds.w  1     ; Selection Offset

;sound variables
sound_f:	ds.b  1

;control menu
gens1:		ds.b  1
gens2:		ds.b  1
gens3:		ds.b  1

;LCD Variables
my_LCD: SECTION
=======
name:       ds.b  16
;Pass  Variables
pass:		ds.b	16
passv:	ds.b	16
;date variables stored in mem array
seloff:     ds.w  1
cursor:     ds.w  1		;gives cursor location on LCD			   

;LCD Variables
my_LCD: SECTION
col:        ds.b 1 		;This is where the column be
row:        ds.b 1 		;This is where the row be
>>>>>>> Austin_Dev_Merge






; code section
MyCode:     SECTION
Entry:
_Startup:

;-----------------LOAD VALUES-----------------------------------------;
			lds #__SEG_END_SSTACK
<<<<<<< HEAD
			CLI
			
			
	    MOVB  #$F0,port_u_ddr   		;init bits 4-7 of hexpad as outputs    
	    MOVB  #$0F,PER          		;enable pull_enable register for hex
	    MOVB  #$FF,PSR          		;init hexpad input bits 0-3 as 
			
			MOVB  #0, start_f				    ;Make the start flag 0
			MOVB  #$20, port_t_ddr
			
;-----------------Variable Reset----------------------------------------------------------;			
			MOVB  #0, sound_rdy
			MOVB  #0, enter_f
			MOVB  #0, command
			MOVW  #0, seloff
			MOVW  #0, tone_count	
			MOVB  #$2D, gens1				; Select generator 1 as the default value
			MOVB  #$20, gens2				; 
			MOVB  #$20, gens3				;
			MOVW  #0, sound_c				; reset sound_c
			MOVW  #0, start_c
			MOVB  #0, clearv
			
			jsr init_LCD            		; call init_LCD
=======
		      CLI
			movb	#$40, RTICTL	;Initi RTI to 1ms
			Movb	#$80, CRGINT	;enable RTI
			
			
	            MOVB  #$F0,port_u_ddr   ;init bits 4-7 of hexpad as outputs    
	        	MOVB  #$0F,PER          ;enable pull_enable register for hex
	       	MOVB  #$FF,PSR          ;init hexpad input bits 0-3 as 
			
		  	MOVB  #0, start_f		;Make the start flag 0
		     	ldx #0
			stx seloff
			ldx #0
			stx cursor			;initialize cursor		
			jsr init_LCD            ;call init_LCD
>>>>>>> Austin_Dev_Merge
			

			MOVW #0, sound_c				    ; reset sound_c
			ldx #0
			stx start_c
			

<<<<<<< HEAD
;---------------------------------------START LCD DISPLAY STUFF---------------------------;
;Set the Date variables to the default value of 11/11/1111 per RobCo industry standards
;
;	
			ldab #1       					     ;
			addb #$30     					     ;Add value to make it ASCII
			ldx #0        					     ;Start with zero and index up to 8
date_res:	stab date,x
			inx
			cpx #8        					     ; only want the 8th index
			bne date_res
			
;Set the Date variables to the default value of 11:11 EST per RobCo industry standards	
;
;
			ldab #1       					     ;
			addb #$30     					     ;Add value to make it ASCII
			ldx #0        					     ;Start with zero and index up to 8
time_res:	stab time, x
			inx
			cpx #4        					     ; only want the 4th index
			bne time_res
;Set name variables to default space values
;
;
            ldab #$20        				;ascii ! values to test
            ldx #0           				;initialize x
name_res:   stab name,x      				;store ascii value into each memory location            
            inx
            cpx #15          				;check if all locations have been stored
			bne name_res 		 		
			
			Movb	#$10, RTICTL			      ;Initi RTI to 1ms
			Movb	#$80, CRGINT			      ;enable RTI			
			
;---------------------------------------END LCD DISPLAY STUFF---------------------------;
			
			
				
=======
;Set the Date variables to the default value of 11/11/1111 per RobCo industry standards	
			ldab #1       
			addb #$30        ;Add value to make it ASCII
			ldx #0           ;Start with zero and index up to 8
date_res:		stab date,x
			inx
			cpx #8           ;only want the 8th index
			bne date_res
			
;Set the Date variables to the default value of 11:11 EST per RobCo industry standards	
			ldab #1       
			addb #$30        ;Add value to make it ASCII
			ldx #0           ;Start with zero and index up to 8
time_res:		stab time, x
			inx
			cpx #4           ;only want the 4th index
			bne time_res
;initialize name variables to default space values
           	      ldab #$20        ;ascii space value
            	ldx #0           ;initialize x
name_res:  	      stab name,x      ;store ascii value into each memory location            
               	inx
                  cpx #16          ;check if all locations have been stored
			bne name_res 		 		
						
			ldx #0
			stx start_c		
;initialize pass variables to default space values
			ldab	#$20	    ;ascii space value
			ldx	#0	    ;initialize x
pass_res:	      stab	pass,x
			inx
			cpx   #16
			bne	pass_res  ;branch until PW initialized to all spaces
;initialize pass verification variables to default space values			
			ldab	#$20	    ;ascii space value
			ldx	#0	    ;initialize x
passv_res:	      stab	passv,x
			inx
			cpx   #16
			bne	passv_res  ;branch until PW initialized to all spaces	
			
					
>>>>>>> Austin_Dev_Merge
;---------------------------SHOW WELCOME MESSAGE------------------;
;Poseidon Energy Startup Message Sequence
;
;			
START:		jsr Startup_1								;
			ldd #disp
<<<<<<< HEAD
			jsr display_string 							;display the string
SRTMSG1:	BRCLR start_f, #1, SRTMSG1
=======
			jsr display_string ; display the string
SRTMSG1:     	BRCLR start_f, #1, SRTMSG1
>>>>>>> Austin_Dev_Merge


;---------------------------TELL USER TO CHANGE THE DEFAULT DATE---------------;
;Prompt the operator with the current date and time (Hours::Minutes)
;
;		
			jsr Startup_2
			ldd #disp
<<<<<<< HEAD
			jsr display_string 							;display the date time string
      		MOVB #0, start_f   							;Reset the delay for 3 seconds
=======
			jsr display_string 	;display the date time string
      		MOVB #0, start_f   	;transition display to go to date and time
>>>>>>> Austin_Dev_Merge
      
      
;-----------------------STRING DISPLAYS---------------------------;      
SRTMSG2:	     BRCLR start_f, #1, SRTMSG2
			
;Show default Date and TIme			
<<<<<<< HEAD
			jsr date_str								    ;show the default time
			ldd #disp									      ;
			jsr display_string
			MOVW #0, seloff
			
			jsr Date_Change	     					 	;jump to date change subroutine
      MOVB #0, clearv

			jsr Time_Change								;jump to time change subroutine
      MOVB #0, clearv


;-----------------------MAIN MENU SUBROUTINES---------------------------------;		
			;Prompt username and password
			;
			;
			jsr MENU									;jump to main menu subroutine
      MOVB #0, clearv

			;Prompt username and password
			;Prompt password
			jsr Cont_Men			
			MOVB #0, clearv
			
			
			;jsr SONG_TIME_START 						;test song subroutine
			;bra User_name
			
			bra DONE


;----------------------------DONE SEQUENCE-----------------;
DONE:
			nop
=======
			jsr date_str		;show the default time
			ldd #disp			
			jsr display_string
			jsr Date_Change	      ;Change Date subroutine

			jsr Time_Change		;Change Time subroutine
						
			jsr User_name		;show default username screen	
			
			jsr User_name_change	;Display users name inputs
			
			jsr Pass_word		;show default password screen	
			
			jsr PW_Creation	      ;Display users password inputs
			
			jsr Pass_wordV
			
			jsr PW_Verify
			
			jsr compare_string
			
			BRSET	equal_f, #1, yourein
			
;--------------------PASSWORD ACCEPTED DEFAULT STRING-----------------
yourein		jsr	accepted
			ldd	#disp
			jsr	display_string
			nop
								
										

           	      		           	      
;-----------------------------Username Creation-----------------------------;
User_name_change: jsr   scan		    			;check keypad input	
          		jsr   Username_start  			;manipulates keypad input and provides an output value
          		jsr	admin_u	    			;displays user inputs (from Username_start)
          		ldd	#disp		    			;load string address				    
          		jsr	display_string  			;display the string	
                  BRCLR enter_f, #1, User_name_change	;branch away when f is pressed
			movb	#0,enter_f	    			;reset f flag	
			movw	#0,cursor	    			;reset cursor location
			
			rts
>>>>>>> Austin_Dev_Merge


			
;---------------------------DEFAULT PASSWORD SHOWCASE------------
Pass_word:		jsr	PW_String
			ldd	#disp
			jsr	display_string
			
			rts
;---------------------Password Creation---------------
PW_Creation:      jsr	scan		   		 ;check keypad input
			jsr	Password_start 		 ;manipulates keypad input and provides a PW output
			jsr	PW_String			 ;store input into variables
			ldd	#disp
			jsr	display_string		 ;display input (password)
			BRCLR	enter_f, #1, PW_Creation ;branch away when f is pressed
			movb	#0,enter_f			 ;reset f flag
			movw	#0,cursor			 ;reset cursor location
			rts
;----------------DEFAULT VERIFY PASSWORD----------------------------
Pass_wordV	      jsr	PW_Verify_String
			ldd	#disp
			jsr	display_string
			rts
			
;------------------Re_type password to verify--------------------			
PW_Verify:		jsr	scan		   		 ;check keypad input
			jsr	Password_verify 		 ;manipulates keypad input and provides a PW output
			jsr	PW_Verify_String	       ;store input into variables
			ldd	#disp
			jsr	display_string		 ;display input (password)
			BRCLR	enter_f, #1, PW_Verify	 ;branch away when f is pressed
			movb	#0,enter_f			 ;reset f flag
			movw	#0,cursor			 ;reset cursor location
			rts			
;----------------------COMPARE THE STRINGS-------------------------------- 
compare_string:	ldx	cursor			 ;load initial cursor location
compare:		ldab	pass,x			 ;load both password inputs
			ldaa	passv,x
			cba	
			bne	notequal			 ;strings aren't equal
		
			inx
			cpx	#16				 ;check if at end of string
			beq 	equal				 ;strings must be equal
			bra	compare			 ;continue comparing
			
notequal:	      movb	#0,equal_f			 ;denotes not equal
		      movw	#0,cursor			 ;reset cursor location		      
;REINITIALIZES PASSWORD ASCII VALUES TO SPACE ASCII VALUES
			ldab	#$20	    ;ascii space value
			ldx	#0	    ;initialize x
pass_res2:	      stab	pass,x
			inx
			cpx   #16
			bne	pass_res2  ;branch until PW initialized to all spaces
			
			ldab	#$20	    ;ascii space value
			ldx	#0	    ;initialize x
passv_res2:	      stab	passv,x
			inx
			cpx   #16
			bne	passv_res2  ;branch until PW reinitialized to all spaces		      	
		      rts

;EQUAL PASSWORDS		      
equal:		movb  #1,equal_f			 ;denotes equal
	      	nop 					 ;strings must be equal
	      	rts
	      	
						
			
										
			
			
			
			
			
			
			
			
			
			
			
				
			