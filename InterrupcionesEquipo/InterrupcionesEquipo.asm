.include "m8535def.inc"
	.def aux = r16
	.def count = r17
	
reset:
	rjmp main
	rjmp cuenta
	rjmp mostrar
main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	ser aux
	out ddra,aux
	out portd,aux
	ldi aux,0b00001010
	out mcucr,aux
	ldi aux, 0b11000000
	out GICR,aux
	clr aux
	ldi count,1
	sei
loop:
	out porta,aux
	rjmp loop

cuenta:
	in aux, pina
	eor aux, count
	reti

mostrar:
	rol count
	reti
