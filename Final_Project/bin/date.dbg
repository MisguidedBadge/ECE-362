	
	XDEF Date_Start
	
	XREF prev_val, disp, command, date, seloff, enter_f, clearv,syst_set_f
MY_EXTENDED_ROM: SECTION
numbers:    dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9

;number options for the time


;letter options for the name

MY_EXTENDED_RAM: SECTION


Highlight_section: SECTION



;go through the date changing the default value
;LCD Date is from disp+1 to disp+10 Start on disp+1
;Code words sent form keypad and will be passed to the function
;Reset Command to standby once proccessed
Date_Start:
            pshd
            pshx
            pshy


            ldab command    ; load the register with the value of command
            cmpb prev_val
            lbeq  DONE
            cmpb #2         ; command for increment number
            lbeq  I_num      ; Increase number for selection
            cmpb #8         ; decrement
            lbeq  D_num
            cmpb #6         ; Right
            lbeq  R_num
            cmpb #4         ; Left
            lbeq  L_num
            BRCLR clearv, #1, DONE
            cmpb #15
            lbeq  F_key  
            bra  DONE


;-------------Increase Number Value--------------------------;            
            
I_num:      ldx  seloff     ; load selection offset4
            ldab  date, x   ; load selection value
            cmpb #$39       ; if 10 then go back to 0
            beq  n_res_high            
            incb            ; increment the value 
            stab date, x    ; store incremented value
            bra  DONE        
        
             
;-------------Decrease Number Value--------------------------;
D_num:      ldx   seloff    	;load selection offset
            ldab  date, x   	;load selection value 
            cmpb #$30        	;if 0 then go back to 10
            beq  n_res_low            
            decb            	;decrement the value
            stab date, x    	;store incremented value
            bra  DONE    

;-------------Shift Number Place Right--------------------------;
R_num:
            ldx seloff        ;load selection offset
            cpx #7            ;see if selection is at the furthest right
            beq r_res     	  ;if so then reset
            inx               ;increment the selection to the next right value if not
            stx seloff
            bra DONE              
  
;-------------Shift Number Place Left--------------------------;
L_num:      
            ldx seloff        ;load selection offset
            cpx #0            ;see if selection is at the furthest right
            beq l_res     	  ;if so then reset
            dex               ;decrement the selection to the next right value if not
            stx seloff
            bra DONE

;-------------Exit the Sequence--------------------------------;          
F_key:      movb #1,enter_f  ;set zero flag for enter_f          
            bra DONE

n_res_high: ldab  #0
		        addb #$30
        	  stab  date, x   ;increment value
        	  bra DONE

n_res_low:  ldab  #9
		        addb #$30
        	  stab  date, x   ;decrement value
        	  bra DONE
            
l_res: 		ldx #7			; reset to the right most value
        	stx seloff
        	bra DONE  


r_res: 		ldx #0			; reset to the left most value
        	stx seloff
        	bra DONE  

            
;-------------DONE SEQUENCE------------------------------------;            
DONE:      		brset	syst_set_f,#1,skip
			MOVB command, prev_val 
			MOVB #0, command
skip:	
		
		      puly
		      pulx
		      puld	
           rts

