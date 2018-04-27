    XDEF  Home_generators,Not_home,Switch_Blink
    XREF  port_s,on_off,blink_flag

;---------------Turn on leds when on homescreen----------
Home_generators:
          pshd
         
          ldab  on_off    ;load which generators are on
          stab  port_s    ;show them in leds
          
          puld
          rts
;-----------------------------------------------------------
;--------------Turn off leds when leaving homescreen--------
Not_home: 
          movw  #0,port_s ;turn leds off
          rts
;-----------------------------------------------------------
;--------------LEDs blink after switch until admin entered------------
Switch_Blink:
          
          pshd
          movb  #1,blink_flag ;so the rti knows to create a .5 second blink delay
back:     ldab  on_off        ;load leds that are already on or off to make them blink
          stab  port_s        ;show generators that are currently on
loop:     brclr start_f,#1,loop ;should be a half second loop (loops in rti for .5 seconds)          
          andb  #0        
loop2:    brclr start_f,#1,loop2 ;another .5 second delay
          bra   back
          puld       
          rts   
;----------------------------------------------------------------------