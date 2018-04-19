	
	XDEF Startup_1, Startup_2, date_str,admin_u,menu_str,GenSelStr
	
	XREF disp, date, time, name, gens1, gens2, gens3
	
MY_EXTENDED_RAM: SECTION	

StringCode: SECTION	
	
	
		   ;*********************string Startup Poseidon Ind.*********************
           ;intializing string "disp" to be:
           ;"The value of the pot is:      ",0
Startup_1  movb #'P',disp
           movb #'o',disp+1
           movb #'s',disp+2
           movb #'e',disp+3
           movb #'i',disp+4
           movb #'d',disp+5
           movb #'o',disp+6
           movb #'n',disp+7
           movb #' ',disp+8
           movb #'E',disp+9
           movb #'n',disp+10
           movb #'e',disp+11
           movb #'r',disp+12
           movb #'g',disp+13
           movb #'y',disp+14
           movb #' ',disp+15
           movb #'C',disp+16
           movb #'o',disp+17
           movb #'a',disp+18
           movb #'l',disp+19
           movb #' ',disp+20
           movb #'P',disp+21
           movb #'l',disp+22
           movb #'a',disp+23
           movb #'n',disp+24
           movb #'t',disp+25
           movb #'-',disp+26
           movb #'1',disp+27
           movb #'-',disp+28
           movb #'I',disp+29
           movb #'N',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'    
;*********************string Startup Poseidon Ind.*********************

		   rts
		   
		   
Startup_2  movb #'P',disp
           movb #'l',disp+1
           movb #'e',disp+2
           movb #'a',disp+3
           movb #'s',disp+4
           movb #'e',disp+5
           movb #' ',disp+6
           movb #'S',disp+7
           movb #'e',disp+8
           movb #'t',disp+9
           movb #' ',disp+10
           movb #'T',disp+11
           movb #'h',disp+12
           movb #'e',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb #'T',disp+16
           movb #'i',disp+17
           movb #'m',disp+18
           movb #'e',disp+19
           movb #' ',disp+20
           movb #'A',disp+21
           movb #'n',disp+22
           movb #'d',disp+23
           movb #' ',disp+24
           movb #'D',disp+25
           movb #'a',disp+26
           movb #'t',disp+27
           movb #'e',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'    
;*********************string Startup Poseidon Ind.*********************

		   rts
		   
date_str   movb date,disp
           movb date+1,disp+1
           movb #'/',disp+2
           movb date+2,disp+3
           movb date+3,disp+4
           movb #'/',disp+5
           movb date+4,disp+6
           movb date+5,disp+7
           movb date+6,disp+8
           movb date+7,disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
           movb #' ',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb time,disp+16
           movb time+1,disp+17
           movb #':',disp+18
           movb time+2,disp+19
           movb time+3,disp+20
           movb #' ',disp+21
           movb #' ',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #' ',disp+25
           movb #' ',disp+26
           movb #' ',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,  disp+32    ;string terminator, acts like '\0'    
;*********************string Startup Poseidon Ind.*********************
           rts 

admin_u:   movb #'E',disp
           movb #'n',disp+1
           movb #'t',disp+2
           movb #'e',disp+3
           movb #'r',disp+4
           movb #' ',disp+5
           movb #'U',disp+6
           movb #'s',disp+7
           movb #'e',disp+8
           movb #'r',disp+9
           movb #'n',disp+10
           movb #'a',disp+11
           movb #'m',disp+12
           movb #'e',disp+13
           movb #':',disp+14
           movb #' ',disp+15
           movb name,disp+16
           movb name+1,disp+17
           movb name+2,disp+18
           movb name+3,disp+19
           movb name+4,disp+20
           movb name+5,disp+21
           movb name+6,disp+22
           movb name+7,disp+23
           movb name+8,disp+24
           movb name+9,disp+25
           movb name+10,disp+26
           movb name+11,disp+27
           movb name+12,disp+28
           movb name+13,disp+29
           movb name+14,disp+30
           movb #' ',disp+31
           movb #0,disp+32     
		   
		   
		   rts
		   
;*********************string Menu Poseidon Ind.*********************

		   
menu_str:  movb date,disp
           movb date+1,disp+1
           movb #'/',disp+2
           movb date+2,disp+3
           movb date+3,disp+4
           movb #'/',disp+5
           movb date+4,disp+6
           movb date+5,disp+7
           movb date+6,disp+8
           movb date+7,disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
           movb #' ',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb time,disp+16
           movb time+1,disp+17
           movb #':',disp+18
           movb time+2,disp+19
           movb time+3,disp+20
           movb #' ',disp+21
           movb #' ',disp+22
           movb #'1',disp+23
           movb #'2',disp+24
           movb #'0',disp+25
           movb #'M',disp+26
           movb #'W',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,  disp+32    ;string terminator, acts like '\0' 
		   
		   rts
		   
;*********************Control Menu Poseidon Ind.*********************

		   
GenSelStr: movb #'G',disp
           movb #'E',disp+1
           movb #'N',disp+2
           movb #'1',disp+3
           movb #' ',disp+4
           movb #'G',disp+5
           movb #'E',disp+6
           movb #'N',disp+7
           movb #'2',disp+8
           movb #' ',disp+9
           movb #'G',disp+10
           movb #'E',disp+11
           movb #'N',disp+12
           movb #'3',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb gens1,disp+16
           movb gens1,disp+17
           movb gens1,disp+18
           movb gens1,disp+19
           movb #' ',disp+20
           movb gens2,disp+21
           movb gens2,disp+22
           movb gens2,disp+23
           movb gens2,disp+24
           movb #' ',disp+25
           movb gens3,disp+26
           movb gens3,disp+27
           movb gens3,disp+28
           movb gens3,disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,  disp+32    ;string terminator, acts like '\0' 
		   
		   rts