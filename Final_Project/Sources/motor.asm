  	XDEF	motor
  	XREF	on_off,port_t
motor:
		pshd
	;	ldab	on_off
		ldab	port_t
		andb	#%00000111
		cmpb	#0
		bne		spin
		bclr	port_t,#$8
		bra		leave
spin:	bset	port_t,#$8
leave:
		puld
		rts