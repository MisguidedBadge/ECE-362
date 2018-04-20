 	Xdef    start_c, RTI_ISR
	Xref	SECOND, start_f, date_f,repass 



MY_EXTENDED_RAM: section
start_c	ds.w	1
My_code:	section

	
RTI_ISR:
        
        
    	BRSET start_f, #1, MIDDLE
		Ldx   start_c
		inx
		Cpx	  #3000		              ;see if equal to 3 seconds 
		Bne	  exit_start_ISR
		BSET  start_f, #1	
		Ldx	  #0		              ;reset to 0 if 3 seconds
		bra   exit_start_ISR
		
MIDDLE: 
    
        BRSET date_f, #1, date_change ;go to date change section          

        bra exit_ISR

    
date_change:
    

		
		
exit_start_ISR:
            stx start_c
            bset $37, #$80    
       
		    rti
		
		
exit_ISR:   bset $37, #$80
			rti