	.include "m8535def.inc"
	.def aux = r16

	ser aux
	out ddra,aux
	clr aux 
	rjmp reinicio

	datos:
		.db $3f,6,$5b,$4f,$66,$6d,$7d,7,$7f,$6f

	reinicio:
		ldi r22, $00
     	ldi r16, low(RAMEND)
		out spl, r16
		ldi r16, high(RAMEND)
     	out sph, r16
		ldi ZH, high(datos<<1)
     	ldi ZL, low(datos<<1)
     	rjmp fin

	fin:
		lpm aux, Z+
    	out porta, aux
		rcall delay
    	inc r22
    	cpi r22, $0A
		breq reinicio
    	rjmp fin

	delay:
		; Assembly code auto-generated
		; by utility from Bret Mulvey
		ldi r18, 4
		ldi r19, 206
		ldi r20, 0
		L1: dec r20
			brne L1
			dec r19
			brne L1
			dec r18
			brne L1
			lpm
			nop
			ret
