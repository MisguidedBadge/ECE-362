      XDEF  scan,rescan,up,right,down,left, clearv
      XREF  port_u,delay1ms,command
      
      
MY_EXTENDED_RAM: SECTION
clearv    ds.b  1


KEY: Section        
 

scan:         pshd                  		
              ldaa  #%10000000  ;to read the hexpad rows (bits 4-7)         
              
rescan:	      staa  port_u  	;store the sequence, tells which row is being read
              jsr   delay1ms    ;debounce the keypad		
			  ldab  port_u      ;read user input from hex
			  
;*******************************************************
;PROMPTS the user to create a user  ID and PW			  
			  cmpb	#$11		;check if F (select) is pressed
			  beq	prompt
;**********************************************************			  
			  		
		      cmpb  #$84        ;check if up (2)
		      beq   up
		      cmpb  #$42        ;check if right(6)
		      beq   right
		      cmpb  #$24        ;check if down (8)
		      beq   down  
		      cmpb  #$48        ;check if left (4)
		      beq	left
		      lsra              ;right shift scanning sequence
		      cmpa  #$8         ;leave at end of scanning sequence
		      beq   NCommand
		      bra   rescan      ;no options above pressed

;value that will inc display value
up:               MOVB  #2,command   ;value that increments LCD display value
                  lsra               ;right shift scanning sequence
                  ;cmpa  #$8         ;leave at end of scanning sequence
		          ;beq   leave
                  bra   leave                                                                         
;shift LCD cursor right
right:            MOVB  #6,command   ;value that moves LCD cursor right
                  lsra               ;right shift scanning sequence
                  ;cmpa  #$8         ;leave at end of scanning sequence
		          ;beq   leave
                  bra   leave
;value that will dec display value                  
down:             MOVB  #8,command   ;value that decrements LCD display value
                  lsra               ;right shift scanning sequence
                  ;cmpa  #$8         ;leave at end of scanning sequence
		          ;beq   leave
                  bra   leave
;shift LCD cursor left                  
left:             MOVB  #4,command   ;value that moves LCD cursor left
                  lsra               ;right shift scanning sequence
                  ;cmpa  #$8          ;leave at end of scanning sequence
		     	  ;beq   leave
                  bra   leave
;move to time input or to homescreen when done with date and time                  
prompt:			  MOVB  #15,command	;value that will prompt user to enter id and pw
				  lsra				;right shift scanning sequence
				  ;cmpa	#$8			;leave at end of scanning sequence
				  ;beq	leave
				  bra	leave
NCommand:
                  MOVB  #16, command  ;command for no command
                  bset  clearv, #1
                  bra   leave

leave:            puld
                  rts