	
	XDEF Date_Start
	
	XREF disp, command, col, row, dateoff, date, seloff, display_string,enter_f
MY_EXTENDED_ROM: SECTION
numbers:    dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9

;number options for the time


;letter options for the name

MY_EXTENDED_RAM: SECTION
prev_val:	ds.b 1	    ; previous command received from user

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
            cmpb #15
            lbeq  F_key  
            bra  DONE
            
I_num:      ldx  seloff    ; load selection offset
            ldab  date, x   ; load selection value
            cmpb #$39        ; if 10 then go back to 0
            beq  n_res_high            
            incb            ; increment the value 
            stab date, x    ; store incremented value
            bra  DONE        
        
    ;;;;;;;;;;;
             

D_num:      ldx   seloff    	;load selection offset
            ldab  date, x   	;load selection value 
            cmpb #$30        	;if 0 then go back to 10
            beq  n_res_low            
            decb            	;decrement the value
            stab date, x    	;store incremented value
            bra  DONE    

R_num:
            ldx seloff        ;load selection offset
            cpx #7            ;see if selection is at the furthest right
            beq r_res     	  ;if so then reset
            inx               ;increment the selection to the next right value if not
            stx seloff
            bra DONE
            
            

L_num:      
            ldx seloff        ;load selection offset
            cpx #0            ;see if selection is at the furthest right
            beq l_res     	  ;if so then reset
            dex               ;decrement the selection to the next right value if not
            stx seloff
            bra DONE
          
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
            
l_res: 	ldx #7
        stx seloff
        bra DONE  

r_res: 	ldx #0
        stx seloff
        bra DONE  
            
            
DONE:      
		MOVB command, prev_val 
		MOVB #0, command
		
		
		puly
		pulx
		puld	
        rts