	XDEF  Emergency, em_v
	
	XREF  PW_Verify, compare_PW, equal_f, Song_Start, Pass_wordV, Default_RE_PW, PW_Creation, EM_Song, SOUND_RT, port_t, port_s
	
	
MY_EXTENDED_ROM: SECTION
e_cnt	dc.b		1	


MY_EXTENDED_RAM: SECTION
em_v	ds.b	1
	

EmergShut: SECTION

Emergency:

;--------------------SHUT DOWN EVERYTHING------------------------;
			
				
			    
			 	jsr		Song_Start
			 	movb	#100, em_v
Yee:			jsr		EM_Song
				jsr		SOUND_RT
				
				ldab	e_cnt
				cmpa    0
				bne		light
				bra		nlight
				
nlight:			movb 	#$FF, port_s
				bra		Yee
				
light:			movb	#$00, port_s
				

				bra		Yee
			 	
			 	
			 
			 	
			 	rti
			  	
