		XDEF	Default_PW,Default_RE_PW,Pass_wordV,User_name,Default_RE_Ad
		XREF	PW_String,PW_Verify_String,re_enter,start_f,admin_u,display_string
		XREF	re_admin_u,disp

;-------------Display Default Password String--------------		
Default_PW:	    
      			jsr	    PW_String
				ldd	    #disp
				jsr	    display_string			
				rts
				

;------------Display Default Re_enter PW String-------------
Default_RE_PW:  jsr     re_enter
                ldd     #disp
                jsr     display_string
                MOVB    #0,start_f              ;to stay in loop in next isntruction
RSRTMSG:	    BRCLR   start_f, #1, RSRTMSG    ;display try again message for 3 seconds                
                rts
                
;------------Display Default Verify PW String---------------                
Pass_wordV:	    jsr 	PW_Verify_String    
			    ldd	    #disp
			    jsr	    display_string
			    rts

;-----------Display Default Username String----------------
User_name:
            	jsr   admin_u         ;Display default admin username   
            	ldd   #disp           ;store effective address of admin display
           	    jsr   display_string  ;display admin display
           	    rts
;-----------Display Default Re_enter username String------------
Default_RE_Ad:	jsr	  	re_admin_u
				ldd		#disp
				jsr		display_string
				rts	  		