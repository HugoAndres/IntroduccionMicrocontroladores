	.include"m8535def.inc"
	.def aux = r16;
	rjmp main
	rjmp incr		;INT0
	rjmp apaga

main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux

	ser aux			;configuración puerto A como salida
	out ddra,aux
	out portd,aux

	ldi aux,$09		;00001001		Configuración sensado INT0 Y ONT1
	out mcucr,aux

	ldi aux,$C0 ;Habilitar INTO e INT1
	out gicr, aux

	sei		;pone un 1 en la bandera i

fin:
	nop
	nop
	out porta, aux
	nop
	nop
	rjmp fin

apaga:
	clr aux,
	reti

incr: 
	inc aux
	reti
