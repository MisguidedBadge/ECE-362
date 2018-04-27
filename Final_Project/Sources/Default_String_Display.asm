		XDEF	Default_PW,Default_RE_PW,Pass_wordV,User_name,Default_RE_Ad,User_name2,Pass_wordV2
		XDEF	loading,loading_c_menu,chng_pass_display,password_changed_display 
		XREF	PW_String,PW_Verify_String,re_enter,start_f,admin_u,display_string,PW_Verify_String2
		XREF	re_admin_u,disp,admin_u2,match_p,c_menu_str,chng_pass_str,Pass_changed

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
RSRTMSG:	      BRCLR   start_f, #1, RSRTMSG    ;display try again message for 3 seconds                
                rts
                
;------------Display Default Verify PW String---------------                
Pass_wordV:	    jsr 	PW_Verify_String    
			          ldd	    #disp
			          jsr	    display_string
			          rts

;-----------Display Default Username String----------------
User_name:
            	jsr  	admin_u         ;Display default admin username   
            	ldd  	#disp           ;store effective address of admin display
           	  jsr   	display_string  ;display admin display
           	    rts
;-----------Display Default Re_enter username String------------
Default_RE_Ad:	jsr	  	re_admin_u
				ldd		#disp
				jsr		display_string
				movb	#0,start_f
RSRTMSG2:		BRCLR	start_f, #1, RSRTMSG2				
				rts
;-----------Display Enter username message again--------------
User_name2:
				jsr		admin_u2
				ldd		#disp
				jsr		display_string
				rts
;----------Display Loading Home Screen message--------------
loading:	
				jsr		match_p
				ldd		#disp
				jsr		display_string
				movb	#0,start_f
RSRTMSG3:		BRCLR	start_f, #1, RSRTMSG3
				rts
;----------Display control menu loading screen-------------------
loading_c_menu:
				jsr		c_menu_str
				ldd		#disp
				jsr		display_string
				movb	#0,start_f
RSRTMSG4:		BRCLR	start_f, #1, RSRTMSG4   ;display try again message for 3 seconds
				rts
;----------Dsplay change password screen-----------------------
chng_pass_display:
				jsr		chng_pass_str
				ldd		#disp
				jsr		display_string
				movb	#0,start_f
SRTMSG1:		BRCLR 	start_f, #1, SRTMSG1
				rts
;----------PassWord Changed Screen------------------------------
password_changed_display:
        jsr	  Pass_changed
				ldd   #disp
				jsr   display_string
				movb  #0,start_f
SRTMSG5:		BRCLR 	start_f, #1, SRTMSG5   ;display password changed successfully message for 3 seconds
        rts
;------------Display Default Verify PW2 String---------------                
Pass_wordV2:	  	  jsr 	  PW_Verify_String2    
			          ldd	    #disp
			          jsr	    display_string
			          rts
												  		