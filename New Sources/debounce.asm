    XDEF    delay1ms     
    XREF    delay  
  
delay1ms:   pshx     
            ldx     #delay     
loop:       dex     
            bne loop     
            pulx     
            RTS