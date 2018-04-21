
	XDEF Startup_1, Startup_2, date_str,admin_u,menu_str,GenSelStr,admin_u,PW_String,PW_Verify_String
	XDEF re_enter,accepted,re_admin_u
	
	XREF disp, date, time, name, namev, gens1, gens2, gens3, pass, passv

	
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
;*********************Username_Diplay*********************
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
           movb name+15,disp+31
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
	     rts
;************************PassWord_Display**********************
PW_String: movb #'E',disp
           movb #'n',disp+1
           movb #'t',disp+2
           movb #'e',disp+3
           movb #'r',disp+4
           movb #' ',disp+5
           movb #'P',disp+6
           movb #'a',disp+7
           movb #'s',disp+8
           movb #'s',disp+9
           movb #'W',disp+10
           movb #'o',disp+11
           movb #'r',disp+12
           movb #'d',disp+13
           movb #':',disp+14
           movb #' ',disp+15
           movb pass,disp+16
           movb pass+1,disp+17
           movb pass+2,disp+18
           movb pass+3,disp+19
           movb pass+4,disp+20
           movb pass+5,disp+21
           movb pass+6,disp+22
           movb pass+7,disp+23
           movb pass+8,disp+24
           movb pass+9,disp+25
           movb pass+10,disp+26
           movb pass+11,disp+27
           movb pass+12,disp+28
           movb pass+13,disp+29
           movb pass+14,disp+30
           movb pass+15,disp+31
           movb #0,disp+32
           
           rts
;*************************Verify_Password************************
PW_Verify_String: movb #'V',disp
           	   	  movb #'e',disp+1
           		  movb #'r',disp+2
           		  movb #'i',disp+3
          	  	  movb #'f',disp+4
           		  movb #'y',disp+5
          	      movb #'P',disp+6
           		  movb #'a',disp+7
           		  movb #'s',disp+8
           		  movb #'s',disp+9
           		  movb #'W',disp+10
           		  movb #'o',disp+11
           		  movb #'r',disp+12
           		  movb #'d',disp+13
           		  movb #':',disp+14
           		  movb #' ',disp+15
          		  movb passv,disp+16
           		  movb passv+1,disp+17
           		  movb passv+2,disp+18
           		  movb passv+3,disp+19
           		  movb passv+4,disp+20
          		  movb passv+5,disp+21
           		  movb passv+6,disp+22
           		  movb passv+7,disp+23
           		  movb passv+8,disp+24
           		  movb passv+9,disp+25
           		  movb passv+10,disp+26
           		  movb passv+11,disp+27
           		  movb passv+12,disp+28
           		  movb passv+13,disp+29
           		  movb passv+14,disp+30
           		  movb passv+15,disp+31
           		  movb #0,disp+32
           
           		  rts
;************************Re-Enter Password***************
re_enter:  movb #'P',disp
           movb #'a',disp+1
           movb #'s',disp+2
           movb #'s',disp+3
           movb #'W',disp+4
           movb #'o',disp+5
           movb #'r',disp+6
           movb #'d',disp+7
           movb #'s',disp+8
           movb #' ',disp+9
           movb #'D',disp+10
           movb #'o',disp+11
           movb #'n',disp+12
           movb #'t',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb #'M',disp+16
           movb #'a',disp+17
           movb #'t',disp+18
           movb #'c',disp+19
           movb #'h',disp+20
           movb #' ',disp+21
           movb #'T',disp+22
           movb #'r',disp+23
           movb #'y',disp+24
           movb #' ',disp+25
           movb #'A',disp+26
           movb #'g',disp+27
           movb #'a',disp+28
           movb #'i',disp+29
           movb #'n',disp+30
           movb #' ',disp+31
           movb #0,disp+32

           
           rts
;---------Turn on all 3 generators and set power output to max------
accepted:  movb #'T',disp
           movb #'u',disp+1
           movb #'r',disp+2
           movb #'n',disp+3
           movb #'O',disp+4
           movb #'n',disp+5
           movb #'G',disp+6
           movb #'e',disp+7
           movb #'n',disp+8
           movb #'e',disp+9
           movb #'r',disp+10
           movb #'a',disp+11
           movb #'t',disp+12
           movb #'o',disp+13
           movb #'r',disp+14
           movb #'s',disp+15
           movb #'S',disp+16
           movb #'e',disp+17
           movb #'t',disp+18
           movb #'T',disp+19
           movb #'o',disp+20
           movb #'M',disp+21
           movb #'a',disp+22
           movb #'x',disp+23
           movb #'P',disp+24
           movb #'o',disp+25
           movb #'w',disp+26
           movb #'e',disp+27
           movb #'r',disp+28
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
;**********************Re_enter_Username******************
re_admin_u: movb #'R',disp
           	movb #'e',disp+1
           	movb #'E',disp+2
           	movb #'n',disp+3
           	movb #'t',disp+4
           	movb #'e',disp+5
           	movb #'r',disp+6
           	movb #'U',disp+7
           	movb #'s',disp+8
           	movb #'e',disp+9
           	movb #'r',disp+10
           	movb #'n',disp+11
           	movb #'a',disp+12
           	movb #'m',disp+13
           	movb #'e',disp+14
           	movb #':',disp+15
           	movb namev,disp+16
           	movb namev+1,disp+17
           	movb namev+2,disp+18
           	movb namev+3,disp+19
           	movb namev+4,disp+20
           	movb namev+5,disp+21
           	movb namev+6,disp+22
           	movb namev+7,disp+23
           	movb namev+8,disp+24
           	movb namev+9,disp+25
           	movb namev+10,disp+26
           	movb namev+11,disp+27
           	movb namev+12,disp+28
           	movb namev+13,disp+29
           	movb namev+14,disp+30
           	movb namev+15,disp+31
           	movb #0,disp+32     
		   		   
		   	rts

;-------------------------Usernames match-----------------------------
match_a:   movb #'U',disp
           movb #'s',disp+1
           movb #'e',disp+2
           movb #'r',disp+3
           movb #'n',disp+4
           movb #'a',disp+5
           movb #'m',disp+6
           movb #'e',disp+7
           movb #'s',disp+8
           movb #' ',disp+9
           movb #'M',disp+10
           movb #'a',disp+11
           movb #'t',disp+12
           movb #'c',disp+13
           movb #'h',disp+14
           movb #' ',disp+15
           movb #' ',disp+15
           movb #' ',disp+16
           movb #' ',disp+17
           movb #' ',disp+18
           movb #' ',disp+19
           movb #' ',disp+20
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
		   
		   rts		   	