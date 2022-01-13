	.include"m8535def.inc"
	.def aux = r16 
	.def aux2 = r17
	.def aux3 = r18
	.def aux4 = r19
	.def aux5 = r20
	.def aux6 = r21

	.org $000 		;Se declara RESET
	rjmp main
	.org $004 		;Se declara Desbordamiento de Timer 2
	rjmp tiempo
	.org $008 		;Se declara Desbordamiento de Timer 1
	rjmp cuenta1
main:
	ldi aux,low(RAMEND) 	;Se inicia declaracion de Pila
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux 			
	ser aux
	clr aux2
	out ddra,aux 			;Se configura puerto A
	ldi aux4,4
	out timsk,aux4 
	ldi aux,6
	out tccr0,aux 
	ldi aux,2
	out tccr1b,aux 
	ldi aux4,2
	out tccr2,aux4 
	ldi aux6,101
	out tcnt2,aux6 
	sei 					;Se activa la bandera de interrupcion
	clr aux5 				;Se declaran valores adicionales
	clr r22
	ldi r24,$FE
	ldi r25,6
	clr r23
loop:
	in r23,tcnt0 			
	cp r23,r25 
	breq activa 			
	in r22,tcnt2 
	cp r22,r24 
	brne sigue 
	ldi aux4,$40
	out timsk,aux4 
	rjmp sigue 
sigue:
	rjmp loop 
activa:
	clr r23 
	out tcnt0,r23 
	ldi aux2,10 
	ldi aux5,3 
	ldi aux,$F0
	out tcnt2,aux 
	ldi aux,$FF
	out tcnt1h,aux 
	out tcnt1l,aux 
	rjmp loop 
tiempo: 
	out tcnt2,aux6 
	in aux4,pina 
	eor aux4,aux5 
	out porta,aux4 
	ldi aux4,4
	out timsk,aux4 
	reti 
cuenta1: 
	dec aux2 				;Decrementa aux2
	brne sal 
	ldi aux3,$0B
	out tcnt1h,aux3 
	ldi aux3,$DD
	out tcnt1l,aux3 
	ldi aux2,0 
	ldi aux,0 
	clr aux5 
sal:	
	reti	 				;Sale de la interrupcion
