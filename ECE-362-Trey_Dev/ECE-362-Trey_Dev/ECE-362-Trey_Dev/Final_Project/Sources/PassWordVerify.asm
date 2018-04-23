    XDEF    Password_verify
    XREF    command,passv,disp,cursor,enter_f

   


Password_verify:
			pshd
    		pshx
    		pshy

;output username inputs    
    		ldab    command
    		cmpb    #2          
   			beq     inc_alph    ;increment alphabet   
   			cmpb    #6
    		beq     R_curs      ;move cursor right on LCD
    		cmpb    #8
    		beq     dec_alph    ;decrement alphabet
    		cmpb    #4
    		beq     L_curs      ;move cursor left on LCD
    		cmpb    #15
    	    beq     F_key    
			bra 	leave	  ;branch if no option above selected
				
;changes space on LCD to 'A' to increment from there    
inc_alph:	ldx     cursor   ;load current cursor location
            ldab    passv,x   ;load alphabet letters
            cmpb	#$20
            bne	    skip     ;branch if ascii 'space' value isn't store in name
            addb    #$21     ;Change to Ascii Value 'A'($41)	
            bra     leave    ;(name was init to space '_' ($20) in main)                        		     		
skip:       inc     passv,x   ;increment ascii value stored in name
			ldab	passv,x
			cmpb 	#$5B     ;check if name passes 'Z'
			bne     leave 	     		       			            
			ldab	#$41     ;Store 'A' into name if it passes 'Z'
			bra	    leave
		
R_curs:   	ldy		cursor		  
	      	cpy		#15	     ;check if cursor at boundary
	      	beq		boundary1
	      	ldy		cursor     ;increment cursor location
	      	iny
	      	sty		cursor
	      	bra		leave	     
boundary1:  ldy		#0
	      	sty		cursor     ;jump to beginning	 	
	      	bra		leave			     	


dec_alph:   ldx     cursor   ;load current cursor location
            ldab    passv,x   ;load alphabet letters
            cmpb	#$20
            bne	  	skip2    ;branch if ascii 'space' value isn't store in name
            addb    #$3A     ;Change to Ascii Value 'Z'($41
            bra     leave    ;(name was init to space '_' ($20) in main)                                    		     		
skip2:      dec     passv,x   ;increment ascii value stored in name
			ldab	passv,x   ;reload name value to check
			cmpb 	#$40     ;check if name passes 'A'
			bne     leave 	     		       			            
			ldab	$5A     ;Store 'Z' into name if it passes 'A'
			bra	  	leave


L_curs:     ldy		cursor
	      	cpy		#0    	;check if cursor at boundary
	      	beq		boundary2
	      	ldy		cursor      ;decrement cursor location
	      	dey
	      	sty		cursor	
	      	bra		leave	     
boundary2:  ldy		#15
            sty		cursor	;set cursor to ending location
	     	bra		leave        

F_key:		movb	#1,enter_f  ;User Pressed F to leave
		
    
leave:      stab	passv,x
	      	clr		command	;reset command, or else values will keep changing    
    	    puly
    	    pulx
   	      	puld
    	    rts