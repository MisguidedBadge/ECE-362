    XDEF  Home_generators,Not_home
    XREF  port_s,on_off

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

           
                    