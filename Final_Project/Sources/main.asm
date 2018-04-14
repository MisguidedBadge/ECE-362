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
            XDEF Entry, _Startup, disp, start_f
            XDEF command
            XDEF port_u, delay
            XDEF date, col,seloff, date_f, time,enter_f,name;, User_name
            XDEF sound_f
            
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, read_pot, display_string, pot_value, init_LCD, RTI_ISR, start_c    ; symbol defined by the linker for the end of the stack
            XREF Startup_1, Startup_2, date_str
            XREF Date_Start, Time_Start
            XREF scan,admin_u, SendsChr
            XREF Door_Song, Door_Song_Start, sound_rdy,  tone_count, sound_c
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
user_input  ds.b 1                       ;Austin's input
;;------------------------------AUSTIN's--------------------;;

; variable/data section
MY_EXTENDED_RAM: SECTION
disp:	    ds.b 33
start_f:    ds.b 1	    ;start flag
enter_f:    ds.b 1	    ;enter flag
date_f:     ds.b 1      ; date change flag


;temporary
command:    ds.b 1



;Time Variables
date:    	ds.b  8
time:		ds.b  4
;Admin Variables
name:       ds.b  15
;date variables stored in mem array
seloff:   ds.w  1   

sound_f:	ds.b  1

;LCD Variables
my_LCD: SECTION
col:    ds.b 1 ; This is where the column be
row:    ds.b 1 ; This is where the row be


MY_EXTENDED_ROM:  SECTION

;unique offset for the corresponding date values
;dateoff:	dc.b  0,1,3,4,6,7,8,9



; code section
MyCode:     SECTION
Entry:
_Startup:

;-----------------LOAD VALUES-----------------------------------------;
			lds #__SEG_END_SSTACK
			CLI
			
			
	        MOVB  #$F0,port_u_ddr   		;init bits 4-7 of hexpad as outputs    
	        MOVB  #$0F,PER          		;enable pull_enable register for hex
	        MOVB  #$FF,PSR          		;init hexpad input bits 0-3 as 
			
			MOVB  #0, start_f				;Make the start flag 0
			MOVB  #$20, port_t_ddr
			
			MOVB  #0, sound_rdy
			
			ldx #0
			stx seloff
			stx tone_count	
			jsr init_LCD            		; call init_LCD
			
			MOVW #0, sound_c				; reset sound_c
			ldx #0
			stx start_c
			

;---------------------------------------START LCD DISPLAY STUFF---------------------------;
;Set the Date variables to the default value of 11/11/1111 per RobCo industry standards
;
;	
			ldab #1       					;
			addb #$30     					;Add value to make it ASCII
			ldx #0        					;Start with zero and index up to 8
date_res:	stab date,x
			inx
			cpx #8        					; only want the 8th index
			bne date_res
			
;Set the Date variables to the default value of 11:11 EST per RobCo industry standards	
;
;
			ldab #1       					;
			addb #$30     					;Add value to make it ASCII
			ldx #0        					;Start with zero and index up to 8
time_res:	stab time, x
			inx
			cpx #4        					; only want the 4th index
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
			
			Movb	#$10, RTICTL			;Initi RTI to 1ms
			Movb	#$80, CRGINT			;enable RTI			
			
;---------------------------------------END LCD DISPLAY STUFF---------------------------;
			
			
				
;---------------------------SHOW WELCOME MESSAGE------------------;
;Poseidon Energy Startup Message Sequence
;
;			
START:		jsr Startup_1								;
			ldd #disp
			jsr display_string 							;display the string
SRTMSG1:	BRCLR start_f, #1, SRTMSG1


;---------------------------TELL USER TO CHANGE THE DEFAULT DATE---------------;
;Prompt the operator with the current date and time (Hours::Minutes)
;
;		
			jsr Startup_2
			ldd #disp
			jsr display_string 							;display the date time string
      		MOVB #0, start_f   							;Reset the delay for 3 seconds
      
      
;-----------------------DEFAULT DATE DISPLAY---------------------------;      
SRTMSG2:	BRCLR start_f, #1, SRTMSG2
			
;Show default Date and TIme			
			jsr date_str								;show the default time
			ldd #disp									;
			jsr display_string
			jsr Date_Change	     					 	;jump to date change subroutine

			jsr Time_Change								;jump to time change subroutine
			
			jsr SONG_TIME_START 						;test song subroutine
			;bra User_name
			
			bra DONE


;----------------------------DATE CHANGE SEQUENCE-----------------;
								
Date_Change:

	    	jsr	scan						 	;keyboard scan inputs
            jsr Date_Start			 			;Date changing subroutine
            jsr date_str			 			;use the date string which includes date and time var
            ldd #disp				 			;load string
            jsr display_string
            BRCLR enter_f, #1, Date_Change 		;branch away when done
            ldx #0
            stx enter_f
		    stx seloff				 			;reset the offset value
            
            rts
            
;----------------------------TIME CHANGE--------------------------------;

Time_Change:
	      jsr scan								;keyboard scan inputs
	      jsr Time_Start						;time changing subroutine
	      jsr date_str	     					;use the date string which includes date and time var
          ldd #disp								;load string
          jsr display_string
          BRCLR enter_f, #1, Time_Change		;branch away when enter is pressed		
          ldx #0
		  stx seloff				 			;reset the offset value
          stx enter_f
            
          rts
          
;----------------------------SONG TIME--------------------------------;               
; MODIFY THIS WHEN USE WITH OTHER STUFF
; SONGS DONE
;
SONG_TIME_START:

      jsr Door_Song_Start 						;Song start sequence
Song:
      jsr Door_Song		  						;Song sequence
      
      bra Song			  						;loop until done with someting


            
DONE:
			nop

			
			
			