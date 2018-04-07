    XDEF    Username_start
    XREF    command

    pshd
    pshx
    pshy   


Username_start:   
;output username inputs    
    ldab    command
    cmpb    #2          
    beq     init_alph   ;increment alphabet    
    cmpb    #6
    beq     R_curs      ;move cursor right on LCD
    cmpb    #8
    beq     init_alph   ;decrement alphabet
    cmpb    #4
    beq     L_curs      ;move cursor left on LCD
    ;cmpb    #15
    ;beq     F_key    

;changes space on LCD to 'A' to increment from there    
init_alph:  ldx     #disp    ;load current cursor location
            ldab    name,x   ;load alphabet letters
            addb    #$21     ;Change to Ascii Value 'A'($41)
            ldab    command
            cmpb    #2
            beq     inc_alph
            cmpb    #8
            beq     dec_alph
inc_alph:            

R_curs:     


dec_alph:   


L_curs:         
    
    
    puly
    pulx
    puld
    rts