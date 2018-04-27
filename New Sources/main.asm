
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
            XDEF Entry, _Startup, disp, start_f,
            XDEF command,namev
            XDEF port_u, delay
            XDEF date,date_f, time,enter_f, prev_val, seloff;, User_name
            XDEF sound_f
            XDEF gens1, gens2, gens3			; generator selection
            XDEF pass, passv
            XDEF User_name,name,cursor, equal_f,check,switch_f 
            
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, read_pot, display_string, pot_value, init_LCD, RTI_ISR, start_c    ; symbol defined by the linker for the end of the stack
            XREF Startup_1, Startup_2, date_str, menu_str,GenSelStr,re_enter,accepted
            XREF Date_Start, Time_Start, Password_start, Password_verify
            XREF scan,admin_u, SendsChr,Username_start,PW_String,PW_Verify_String
            XREF User_name,Default_PW,Default_RE_PW,Pass_wordV 
            XREF Door_Song, Door_Song_Start, sound_rdy,  tone_count, sound_c
            XREF GenSel,Date_Change, Time_Change, SONG_TIME_START, Song, Cont_Men, MENU, clearv
            XREF PW_Creation, compare_string , user_chng,Re_Username,re_admin_u
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
date_f:     ds.b 1      ;date change flag
equal_f	    ds.b 1	    ;equal flag		
check:		ds.b 1	    ;previous switch value to compare with current switch value
switch_f	ds.b 1	    ;switch pressed flag (1 if switch is pressed)

;temporary variables
command:    ds.b 1
prev_val:	ds.b 1	    ; previous command received from user


;Time Variables
date:    	ds.b  8		;Date string
time:		ds.b  4		;Time string
;Admin Variables
name:       ds.b  15    ;Name String
;date variables stored in mem array
seloff:   	ds.w  1     ;Selection Offset

;sound variables
sound_f:	ds.b  1

;control menu
gens1:		ds.b  1
gens2:		ds.b  1
gens3:		ds.b  1

;LCD Variables
my_LCD: SECTION
;Pass  Variables
pass:		ds.b	16
passv:		ds.b	16
;date variables stored in mem array
cursor:     ds.w  1		;gives cursor location on LCD			   






; code section
MyCode:     SECTION
Entry:
_Startup:

;-----------------LOAD VALUES-----------------------------------------;
			lds #__SEG_END_SSTACK
			CLI
			
			
	    	MOVB  	#$F0,port_u_ddr   			;init bits 4-7 of hexpad as outputs    
	    	MOVB  	#$0F,PER          			;enable pull_enable register for hex
	    	MOVB  	#$FF,PSR          			;init hexpad input bits 0-3 as 
			
			MOVB  	#0, start_f				    ;Make the start flag 0
			MOVB  	#$20, port_t_ddr
			
;-----------------Variable Reset----------------------------------------------------------;			
			MOVB  	#0, sound_rdy
			MOVB  	#0, enter_f
			MOVB  	#0, command
			MOVW  	#0, seloff
			MOVW  	#0, tone_count	
			MOVB  	#$2D, gens1				;Select generator 1 as the default value
			MOVB  	#$20, gens2				; 
			MOVB  	#$20, gens3				;
			MOVW  	#0, sound_c				;reset sound_c
			MOVW  	#0, start_c
			MOVB  	#0, clearv
			MOVW  	#0, cursor
			MOVB	#$FF, check				;initialize check to value that switches will never become	
			jsr	  	init_LCD            	;call init_LCD
			

			MOVW  	#0,sound_c				;reset sound_c
			ldx   	#0
			stx   	start_c
			


;---------------------------------------START LCD DISPLAY STUFF---------------------------;	
				

;Set the Date variables to the default value of 11/11/1111 per RobCo industry standards	
			ldab 	#1       
			addb 	#$30        ;Add value to make it ASCII
			ldx 	#0          ;Start with zero and index up to 8
date_res:	stab 	date,x
			inx
			cpx 	#8          ;only want the 8th index
			bne 	date_res
			
;Set the Date variables to the default value of 11:11 EST per RobCo industry standards	
			ldab 	#1       
			addb 	#$30        ;Add value to make it ASCII
			ldx 	#0          ;Start with zero and index up to 8
time_res:	stab 	time, x
			inx
			cpx 	#4          ;only want the 4th index
			bne 	time_res
;initialize name variables to default space values
      		ldab 	#$20        ;ascii space value
      		ldx 	#0          ;initialize x
name_res:  	    
      		stab 	name,x      ;store ascii value into each memory location            
      		inx
      		cpx 	#16         ;check if all locations have been stored
			bne 	name_res 		 		
						
			ldx 	#0
			stx 	start_c		
;initialize pass variables to default space values
			ldab	#$20	     ;ascii space value
			ldx		#0	         ;initialize x
pass_res:	stab	pass,x
			inx
			cpx   	#16
			bne		pass_res     ;branch until PW initialized to all spaces
;initialize pass verification variables to default space values			
			ldab	#$20	     ;ascii space value
			ldx	#0	          	 ;initialize x
passv_res:	stab	passv,x
			inx
			cpx   	#16
			bne		passv_res     	  ;branch until PW initialized to all spaces
;initialize (Re_Enter) name variables to default space values
      		ldab 	#$20        ;ascii space value
      		ldx 	#0          ;initialize x
name_resv:  stab 	namev,x      ;store ascii value into each memory location            
      		inx
      		cpx 	#16         ;check if all locations have been stored
			bne 	name_resv 		 		
				
			
;---------------------------------------INTERUPT SHIP--------------------------;			
			Movb	#$10, RTICTL			    ;Initi RTI to .128 ms
			Movb	#$80, CRGINT			    ;enable RTI				

;---------------------------------------END LCD DISPLAY STUFF---------------------------;

					
;---------------------------SHOW WELCOME MESSAGE------------------;
;Poseidon Energy Startup Message Sequence
;
;			
START:		
      		jsr Startup_1								
			ldd #disp
			jsr display_string 					;display the string
SRTMSG1:	BRCLR start_f, #1, SRTMSG1



;---------------------------TELL USER TO CHANGE THE DEFAULT DATE---------------;
;Prompt the operator with the current date and time (Hours::Minutes)
;
;		
				jsr Startup_2
				ldd #disp
				jsr display_string 					;display the date time string
      			MOVB #0, start_f   					;Reset the delay for 3 seconds
      
      
;-----------------------STRING DISPLAYS---------------------------;      
SRTMSG2:		BRCLR start_f, #1, SRTMSG2
			
;Show default Date and TIme			

				jsr date_str					;show the default time
				ldd #disp									     
				jsr display_string
				MOVW #0, seloff
			
				jsr Date_Change	     			;jump to date change subroutine
      			MOVB #0, clearv

				jsr Time_Change					;jump to time change subroutine
      			MOVB #0, clearv


      			jsr User_name		;show default username screen	
			
				jsr user_chng	    ;Display users name inputs
			
				jsr Default_PW		;show default password screen
				
				bra skip            ;skip the re_enter password subroutine
				
no_match:		jsr Default_RE_PW   ;show default "re_enter password" screen
			
skip:			jsr PW_Creation	    ;Display users password inputs
			
				jsr Pass_wordV		;default verify password screen
			
				jsr PW_Verify		;Re_type password to verify
			
				jsr compare_string
			
				brclr equal_f,#1, no_match
			
				jsr yourein         ;make a delay for this
			
				jsr MENU
			
				jsr Cont_Men
			
				jsr SONG_TIME_START

			    



;------------Re_type password to verify--------------------------------------------
PW_Verify:	    jsr	    scan		   		    ;check keypad input
			    jsr	    Password_verify 	    ;manipulates keypad input and provides a PW output
			    jsr	    PW_Verify_String	    ;store input into variables
			    ldd	    #disp
			    jsr	    display_string		    ;display input (password)
			    BRCLR	enter_f, #1, PW_Verify	;branch away when f is pressed
			    movb	#0,enter_f			    ;reset f flag
			    movw	#0,cursor			    ;reset cursor location
			    rts			
	      	   
;------------PASSWORD ACCEPTED DEFAULT STRING--------------------------------------
yourein		    jsr	    accepted
			    ldd	    #disp
			    jsr	    display_string
          		MOVB    #0,start_f              ;to stay in loop in next isntruction
RSRTMSG2:		BRCLR   start_f, #1, RSRTMSG2    ;display try again message for 3 seconds				    
			    rts	      			

	       
										
			
			
			
			
			
			
			
			
			
			
			
