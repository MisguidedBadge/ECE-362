
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

            XDEF Entry, _Startup, disp, start_f,flag
            XDEF command, homeflag, coalfill_f
            XDEF port_u, delay, LCD_timer1, LCD_timer2
            XDEF date,date_f, time,enter_f, prev_val, seloff;, User_name
            XDEF sound_f,on_off, syst_set_f, pow, port_s
            XDEF gens1, gens2, gens3, gc11,gc12,gc21,gc22,gc31,gc32,gens1_coal,gens2_coal,gens3_coal			; generator selection
            XDEF pass, passv, passv2, num, go_home, passflag, PW_Verify2,choose, blink_flag 



            XDEF User_name,name,namev,cursor, equal_f,check,switch_f 
            XDEF PW_Verify, port_p, stepper_r, stepper_s, port_t
            
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, read_pot, display_string, pot_value, init_LCD, RTI_ISR, start_c    ; symbol defined by the linker for the end of the stack
            XREF Startup_1, Startup_2, date_str, menu_str,GenSelStr,re_enter,accepted
            XREF Date_Start, Time_Start, Password_start, Password_verify,control_reset
            XREF scan,admin_u, SendsChr,Username_start,PW_String,PW_Verify_String

            XREF User_name,Default_PW,Default_RE_PW,Pass_wordV,compare_PW,PotRead 
            XREF Door_Song, Song_Start, sound_rdy,  tone_count, sound_c
            XREF GenSel,Date_Change, Time_Change, SONG_TIME_START, Song, Cont_Men, MENU, clearv



            XREF PW_Creation, compare_string , user_chng,Re_Username,re_admin_u, em_v,Fill_Coal,Coal_S, stepper_c, CoalFiller
            XREF Fill_Coal_S, loading_c_menu, PW_Verify_String2, Password_verify2, EM_SOUND, step_f
            
            ; LCD References
	         

            ; Potentiometer References

;;--------------------------------AUSTIN's----------------;;          
MY_EXTENDED_ROM:  SECTION
delay       dc.w  1000                    		;1ms delay
keys        dc.b  $84,$42,$24,$48         		;represents hex keys 2,6,8&4 respectively
                  ;up,rght,lft,dwn
                  

port_s_ddr  equ   $24A                    		;led ddr
port_s      equ   $248                    		;leds address
port_u_ddr  equ   $26A                    		;hexpad ddr
port_u      equ   $268                    		;hexpad address
PER         equ   $26C                   		  ;pull_enable register
PSR         equ   $26D                    		;polarity_select
port_t_ddr	equ	  $242
port_t		equ	  $240
port_p_ddr	equ	  $25A 							;port_p_ddr
port_p		equ	  $258							;port_p
                  

; variable/data section
MY_EXTENDED_RAM: SECTION
user_input  ds.b 1                        ;Austin's input
;;------------------------------AUSTIN's--------------------;;

; variable/data section
MY_EXTENDED_RAM: SECTION
disp:	      ds.b 33
start_f:    ds.b 1	    						;start flag
enter_f:    ds.b 1	    						;enter flag
date_f:     ds.b 1      						;date change flag
equal_f	    ds.b 1	    						;equal flag		
check:		ds.b 1	   							;previous switch value to compare with current switch value
switch_f:	ds.b 1	    						;switch pressed flag (1 if switch is pressed)
flag:		ds.b 1								;User MUST flip a switch when set to 1, otherwise program doesn't wait for it 
choose:		ds.b 1								;choose which generator to turn on (located in switch input)
passflag:	ds.b 1								;for when re_entering password after first time verifying
homeflag	ds.b 1								;so the program only displays 'loading home screen' the first time a switch is flipped, other times displays which generator(s) is/are turned on
syst_set_f:	ds.b 1								;flag that indicates if system settings menu has been accessed. This will start a 10 second timer in rti if a,b, or f aren't pressed on hex pad
screen_sel	ds.b 1								;flag that determines which screen the user is choosing (when pushing a or b)	when in control menu
go_home		ds.b 1		

;temporary variables
command:    ds.b 1
prev_val:	ds.b 1	    						; previous command received from user


;Time Variables
date:    	ds.b  8								;Date string
time:		ds.b  4								;Time string
;Admin Variables
name:       ds.b  16
namev:		ds.b  16	    				    ;Name String
;date variables stored in mem array
seloff:   	ds.w  1
LCD_timer1	ds.w	1
LCD_timer2	ds.w	1    						;Selection Offset

;sound variables
sound_f:	ds.b  1

;control menu
gens1:		ds.b  1
gens2:		ds.b  1
gens3:		ds.b  1
;generator coal by percentage
; 65000 lower nibble  3692  240 Mil
;  ------             369   24  Mil
;                     37    2.4 Mil

; 65000 lower nibble 738

; 65000 lower nibble 1108
gc11     ds.w   1 ; upper
gc12     ds.w   1 ; lower
gc21     ds.w   1
gc22     ds.w   1
gc31     ds.w   1
gc32     ds.w   1


gens1_coal: ds.b  1 							;generator coal first spot   Upper (240 mil/% at 1%)                                   ;generator coal second spot  Lower
gens2_coal: ds.b  1               ;generator coal   (4.8 mil/% at 100%) (480 mil/% at 1%) (% times 4.8)
gens3_coal:	ds.b  1               ;generator coal (720 mil/% at 1%)

on_off:		  ds.b  1								;Determines which generators are on or off (values 0-7) 
num			ds.b	3
coalfill_f  ds.b  1               ;coal fill flag (if successful then start filling coal
pow			ds.b	3
	   							;previous switch value to compare with current switch value
	    						;switch pressed flag (1 if switch is pressed)
								;User MUST flip a switch when set to 1, otherwise program doesn't wait for it 
							;choose which generator to turn on (located in switch input)
								;for when re_entering password after first time verifyin								;Leaves control menu and returns to homescreen if f key isn't pressed within 10 seconds
blink_flag  ds.b 1                ;flag that lets rti know to set a delay between blinks

;Time Variables

;Pass  Variables

pass:		ds.b	16
passv:		ds.b	16
passv2:		ds.b	16

;date variables stored in mem array
cursor:     ds.w  1								;gives cursor location on LCD			   
;Stepper Motor
stepper_r:	ds.b	1							;stepper ready
stepper_s:	ds.b	1




; code section
MyCode:     SECTION
Entry:
_Startup:

;-----------------LOAD VALUES-----------------------------------------;
				lds 	#__SEG_END_SSTACK
				CLI
			
			

	    		MOVB  	#$F0,port_u_ddr   		;init bits 4-7 of hexpad as outputs    
	    		MOVB  	#$0F,PER          		;enable pull_enable register for hex
	    		MOVB  	#$FF,PSR          		;init hexpad input bits 0-3 as 
			
				MOVB  	#0, start_f				;Make the start flag 0
				MOVB  	#$28, port_t_ddr
			    movb	#%01000000,$1E
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
				MOVB	  #0, check				;initialize previous switch value to 0
				movb	  #1, flag	
				movb	  #0, em_v
				movb	  #$1E,port_p_ddr
				movb	  #$FF,port_s_ddr
				movb	  #0, stepper_r
				movw	  #0, stepper_c
				movb	  #0, stepper_s
				movw    #65000,gc11      ;default values for the coal
				movw    #65000,gc21
				movw    #65000,gc31
				movw    #1,gc12
				movw    #1,gc22
				movw    #1,gc32
				movb	#0,passflag
				movb	#0,homeflag

				movb	#100, gens1_coal
				movb	#100, gens2_coal
				movb	#100, gens3_coal

				movb	#0,num					;initialize num
				movb	#0,syst_set_f			;initialize system set flag
				movb	#0,screen_sel			;initialize screen select
				movw	#0,LCD_timer1			;initialize counting
				movw	#0,LCD_timer2

				movb	#0,go_home 
				movb	#0, on_off
				;movb	#$8, port_t

				movb	#0,go_home
				movb  #0,blink_flag		

				jsr	  	init_LCD            	;call init_LCD
			

				MOVW  	#0,sound_c				;reset sound_c
				ldx   	#0
				stx   	start_c
			


;---------------------------------------START LCD DISPLAY STUFF---------------------------;					
;Set the Date variables to the default value of 11/11/1111 per RobCo industry standards	
			ldab 	#1       
			addb 	#$30        			;Add value to make it ASCII
			ldx 	#0          			;Start with zero and index up to 8
date_res:	stab 	date,x
			inx
			cpx 	#8          			;only want the 8th index
			bne 	date_res
			
;Set the Date variables to the default value of 11:11 EST per RobCo industry standards	
			ldab 	#1       
		    addb 	#$30        			;Add value to make it ASCII
	      	ldx 	#0          			;Start with zero and index up to 8
time_res:	stab 	time, x
		    inx
			cpx 	#4          			;only want the 4th index
			bne 	time_res
;initialize name variables to default space values
      		ldab 	#$20        			;ascii space value
      		ldx 	#0          			;initialize x
name_res:  		    
      		stab 	name,x      			;store ascii value into each memory location            
      		inx
      		cpx 	#16         			;check if all locations have been stored
			bne 	name_res 		 		
				  		
			ldx 	#0
			stx 	start_c		
;initialize pass variables to default space values
			ldab	#$20	     			;ascii space value
			ldx		#0	         			;initialize x
pass_res:		stab	pass,x
			inx
			cpx   	#16
			bne		pass_res     			;branch until PW initialized to all spaces
;initialize pass verification variables to default space values			
			ldab	#$20	     			;ascii space value
			ldx		#0	          	 		;initialize x
passv_res:		stab	passv,x
			inx
			cpx   	#16
			bne		passv_res     	  		;branch until PW initialized to all spaces
;initialize pass verification variables to default space values			
			ldab	#$20	     			;ascii space value
			ldx		#0	          	 		;initialize x
passv_res4:		stab	passv2,x
			inx
			cpx   	#16
			bne		passv_res4     	  		;branch until PW initialized to all spaces				    
;initialize (Re_Enter) name variables to default space values
      		ldab 	#$20        			;ascii space value
      		ldx 	#0          			;initialize x
name_resv:  	stab 	namev,x      			;store ascii value into each memory location            
      		inx
      		cpx 	#16         			;check if all locations have been stored
			bne 	name_resv
;initialize generator on and off values with space values
      		ldab 	#$20        			;ascii space value
      		ldx 	#0          			;initialize x
gen_res:    	stab 	num,x      				;store ascii value into each memory location            
      		inx
      		cpx 	#3	         			;check if all locations have been stored
			bne 	gen_res  		 		
				
			
;---------------------------------------INTERUPT SHIP--------------------------;			
			Movb	#$10, RTICTL			;Initi RTI to .128 ms
			Movb	#$80, CRGINT			;enable RTI
			Movb    #$80, INTCR 			;sets edge trigger
			Movb    #$40, INTCR 			;enable IRQ				

;---------------------------------------END LCD DISPLAY STUFF---------------------------;

					
;---------------------------SHOW WELCOME MESSAGE------------------;
;Poseidon Energy Startup Message Sequence
;
;			
START:		
      		jsr 	Startup_1								
			ldd 	#disp
			jsr 	display_string 			;display the string
SRTMSG1:	  	BRCLR 	start_f, #1, SRTMSG1



;---------------------------TELL USER TO CHANGE THE DEFAULT DATE---------------;
;Prompt the operator with the current date and time (Hours::Minutes)
;
;		
			jsr 	Startup_2
			ldd 	#disp
			jsr 	display_string 			;display the date time string
      		MOVB 	#0, start_f   			;Reset the delay for 3 seconds
      
      
;-----------------------STRING DISPLAYS---------------------------;      
SRTMSG2:	  	BRCLR 	start_f, #1, SRTMSG2
			
;Show default Date and TIme			

				jsr 	date_str				    ;show the default time
				ldd 	#disp									     
				jsr 	display_string
				MOVW 	#0, seloff			
				jsr 	Date_Change	     		;jump to date change subroutine
      	MOVB 	#0, clearv
				jsr 	Time_Change				  ;jump to time change subroutine
      	MOVB 	#0, clearv

;---------------------MAIN CODE BODY------------------------------------------------
;---------------------MAIN CODE BODY------------------------------------------------
;---------------------MAIN CODE BODY------------------------------------------------						
      		      jsr 	User_name				  ;show default username screen				
				  jsr 	user_chng	    		;Display users name inputs						
				  jsr 	Default_PW				;show default password screen				
				  bra 	skip            	;skip the re_enter password subroutine				
no_match:	      jsr 	Default_RE_PW   	;show default "re_enter password" screen			
skip:			  jsr 	PW_Creation	    	;Display users password inputs			
				  jsr 	Pass_wordV				;default verify password screen			
				  jsr 	PW_Verify				  ;Re_type password to verify			
				  jsr 	compare_PW			
				  brclr 	equal_f,#1, no_match			
				  jsr 	prompt					  ;Tell user to turn on each generator and set power output to max         		
				
				

				
go_back:                   							
				  clr   go_home
				  jsr 	PotRead
			      jsr 	MENU					    ; Shows MW output and time
	
	  jsr   loading_c_menu
CONMEN:	    	  jsr 	Cont_Men			    ; Control Menu that shows generators
				  
                  
				  
				  
				  BRCLR coalfill_f, #1, CONMEN2
			    
			    
			    ;- Reset Stepper Values -;

				  jsr	Coal_S
				  jsr   Fill_Coal_S
				  jsr	Song_Start
				  ;movb	#0,start_f
				  bra   FILL
CONMEN2:
                  brset go_home, #1, go_back
                  bra   CONMEN				  
				  


				;-Testing Fill Process -;
FILL:
				  jsr	CoalFiller

				  brclr	step_f,#1,FILL

				 		
				  bra 	go_back
				
				
;---------------------MAIN CODE BODY------------------------------------------------
;---------------------MAIN CODE BODY------------------------------------------------
;---------------------MAIN CODE BODY------------------------------------------------				




;------------Re_type password to verify--------------------------------------------
PW_Verify:		 jsr	    scan		   		    ;check keypad input
			  	 jsr	    Password_verify 	    ;manipulates keypad input and provides a PW output
			  	 jsr	    PW_Verify_String	    ;store input into variables
			  	 ldd	    #disp
			     jsr	    display_string		    ;display input (password)
			  	 BRCLR	enter_f, #1, PW_Verify	;branch away when f is pressed
			  	movb	#0,enter_f			    ;reset f flag
			  movw	#0,cursor			    ;reset cursor location
			      
			  rts
;-----------Re_type passwod to verify AGAIN, then store it into passv if successful------
 PW_Verify2:  jsr   scan
              jsr	  Password_verify2		  	;manipulates user inputs
              jsr   PW_Verify_String2
              ldd   #disp
              jsr   display_string
;--------------check if a or b pressed-------------------------------------

		   	  brset	go_home,#1,reset_pass_passv2		
              ldab  command             ;skip below code if a or b is pressed
              cmpb  #10

              beq   reset_pass_passv2
              cmpb  #11
            	bne	  skip3
 
reset_pass_passv2:
			    jsr		control_reset
			    bra		skip2              
skip3:    brclr 	enter_f,#1,PW_Verify2
skip2:
          movb  #0,enter_f
          movb  #0,cursor
              
              	rts	
	      	   
;------------PASSWORD ACCEPTED DEFAULT STRING--------------------------------------
prompt:		jsr	    accepted
			    ldd	    #disp
			    jsr	    display_string
          MOVB    #0,start_f              ;to stay in loop in next isntruction
RSRTMSG2:	BRCLR	start_f, #1, RSRTMSG2   ;display try again message for 3 seconds				    
			    rts	      			

	       
										
			
			
			
			
			
			
			
			
			
			
			
