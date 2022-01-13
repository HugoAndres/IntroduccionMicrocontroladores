	.include "m8535def.inc"
	ldi r16,low(RAMEND) ; RAMEND = $025F
	ldi r17,high(RAMEND)
	out spl,r16
	out sph,r17

inicio:
	ldi r16,10
	ldi r17,20
	ldi r18,30

	rcall ejemp1

	ldi r16,40
	ldi r17,50
	ldi r18,60

	rcall ejemp1

	ldi r16,$10
	ldi r17,$20
	ldi r18,$30

	rcall ejemp1
	rjmp inicio

ejemp1:
	add r16,r17
	adc r18,r16
	swap r18		;cambia nibles 0x3c ->0xc3

	rcall sub2

	inc r18

	rcall sub2

	ret

sub2:
	nop
	nop
	push r17 ; pone la PC en la memoria y decremeta en 2 SP
	nop
	ret



