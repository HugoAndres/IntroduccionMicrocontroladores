	.include"m8535def.inc"
	.def aux = r16
	.def msk = r17
	.def ini = r18
	.def tc1h = r19
	.def tc1l = r20
reset:
	rjmp main
	rjmp timbre 
	.org $008
	rjmp tmpo				;3segundos
	;	.org $009
	rjmp onda 				;Señal de 400Hz
main:
	ldi aux,low(RAMEND) 	;Inicializar apuntador de pila
	out spl, aux
	ldi aux, high(RAMEND)
	out sph, aux
	ser aux					;Configurar puerto A como salida
	out ddra, aux
	out portd, aux
	ldi aux, 0b00000010

;	ldi aux, 2; detectar flanco de bajada, configura int0
	out mcucr, aux  ;configura sensado de int0 
	ldi aux, 0b01000000 
	out gicr, aux ;gicr, habilita la int0 para se active como peticion d einterrumpcion

	

	ldi aux, 0b00000101 ; habilita tc0 y tc1
	out timsk, aux
	sei 
	ldi msk, 1
; 	requiere un número x 8 = 1250
;	156 x 8 = 1250
;	256-156 = 100
; 3s = 3millones de ciclos
	ldi ini, 100
	ldi tc1h, $48
	ldi tc1l, $E5
	out tcnt1h, tc1h
	out tcnt1l, tc1l
nada:
	rjmp nada
onda:
	out tcnt0,ini
	in aux, pina ;genera onda
	eor aux, msk
	out porta, aux
	reti
tmpo:
	out tcnt1h, tc1h
	out tcnt1l, tc1l
	reti

; 3000000 = ??? x 64
; 46875 x 64 = 3m
; 65536 - 46875 = 18661 = $48E5
; tcnt1h <= $48
; tnct1l <= $E5

timbre:
	ldi aux,2 				;Inicializa contador con la prescala 1 tccr0
	out tccr0, aux
	ldi aux, 3
	out tccr1b, aux
	
