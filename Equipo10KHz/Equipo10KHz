.include"m8535def.inc"
.def aux = r16
.def aux1 = r17
.def aux2 = r18

reset:
	rjmp main
	.org $009
	rjmp onda
main:
	ldi aux, low(RAMEND)	;Inicializa apuntador de pila
	out spl, aux
	ldi aux, high(RAMEND)
	out sph, aux
config:
	ser aux					;Configuración puerto A como salida
	out ddra, aux
	ldi aux, 1				; Ponemos 1 en la preescala del TimeCounter0
	out tccr0, aux
	ldi aux, 1				; Habilita el TimerCounter0
	out timsk, aux			
	sei
	ldi aux1, 1
	ldi aux2, 214
fin:
	rjmp fin
onda:
	nop
	out tcnt0, aux2
	in aux, pina
	eor aux, aux1
	out porta,aux
	reti


			
