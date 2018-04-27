	  XDEF ANYTHING
	  XREF Default_RE_PW,PW_Creation,Pass_wordV,compare_PW,equal_f,em_v	

ANYTHING:			
				bra	skip7			 		
;Need to do password verification

				
no_match2:		jsr 	Default_RE_PW   		;show default "re_enter password" screen			
skip7:			jsr 	PW_Creation	    		;Display users password inputs			
;				jsr 	Pass_wordV				;default verify password screen			
;
				jsr 	compare_PW
							
				brclr 	equal_f,#1, no_match2
				movb #0, em_v
				rts