	XDEF  Emergency, em_v
	
	XREF  PW_Verify, compare_PW, equal_f, Song_Start, Pass_wordV, Default_RE_PW, PW_Creation
	
	
MY_EXTENDED_ROM: SECTION

MY_EXTENDED_RAM: SECTION
em_v	ds.b	1

EmergShut: SECTION

Emergency:

;--------------------SHUT DOWN EVERYTHING------------------------;

			 	jsr		Song_Start
			 	movb	#1, em_v
			 ;	cli
			 ;	bra 	skip	
NMatch:			 		
;Need to do password verification
;no_match:		jsr 	Default_RE_PW   		;show default "re_enter password" screen			
;skip:			jsr 	PW_Creation	    		;Display users password inputs			
;				jsr 	Pass_wordV				;default verify password screen			
;				jsr 	PW_Verify				;Re_type password to verify			
;				jsr 	compare_PW			
;				brclr 	equal_f,#1, no_match			
				rts