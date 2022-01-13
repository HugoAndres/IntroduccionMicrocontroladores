	.include"m8535def.inc"	;Se declaran etiquetas
	.def aux = r16
	.def aux1 = r17
	.def aux2 = r18
	.def aux3 = r21
	.def aux4 = r0
	.def tc1h = r19
	.def tc1l = r20
	.def dirl = r22
	.def dirh = r23 
	
	.macro writeEEPROM
		ldi dirh, @0
		ldi dirl, @1
		mov aux, aux4
		rcall EEPROM_write
	.endm

	.macro readEEPROM
		ldi dirh, @0
		ldi dirl, @1
		rcall EEPROM_read
	.endm
reset:
	rjmp main
	.org $004
	rjmp onda
	.org $008
	rjmp tmpo
	rjmp cliente
	.org $012
	rjmp reset_eeprom
main:
	ldi aux,low(ramend)		;Se declara el apuntador de pila
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	clr aux
	mov aux4, aux
	writeEEPROM $00, $00
	ser aux					;Se configuran los puertos de salida
	out ddra,aux
	out ddrc,aux
	out ddrd,aux
	out portb,aux
	ldi aux,6
	out tccr0,aux
	ldi aux,0b01000101
	out timsk,aux
	ldi aux, 0b01000000
	out mcucsr, aux
	ldi aux, $20
	out gicr, aux
	sei
	ldi aux,250
	out tcnt0,aux			;Se establece la preescala de Timer 0
	ldi aux1,1

;   para 5 segundos se necesitan 5,000,000 ciclos
;   19531.25x256=5000000
;   65536-19531=46005=$b3b5
;   tcnt1h <= $B3
;   tcnt1l <= $B5

	ldi aux2,256-141
	ldi tc1h,$B3
	ldi tc1l,$B5
	out tcnt1h,tc1h
	out tcnt1l,tc1l
loop:
	in aux3,tcnt0
	clr aux
	sub aux,aux3
	out portc,aux
	readEEPROM $00,$00
	out portd, aux
	rjmp loop
onda:
	out tcnt2,aux2
	in aux,pina
	eor aux,aux1
	out porta,aux
	reti
tmpo:
	ldi aux,0
	out tccr2,aux
	out tccr1b,aux
	ldi aux,250
	out tcnt0,aux
	inc aux4
	writeEEPROM $00,$00
	reti
cliente:
	ldi aux,2
	out tccr2,aux
	ldi aux,4
	out tccr1b,aux
    out tcnt1h,tc1h
	out tcnt1l,tc1l
	reti
reset_eeprom:
	clr aux4
	writeEEPROM $00,$00
EEPROM_read:
	sbic EECR, EEWE
	rjmp EEPROM_read
	out EEARH, r23
	out EEARL, r22
	sbi EECR, EERE
	in r16, EEDR
	ret
EEPROM_write:
	sbic EECR, EEWE
	rjmp EEPROM_write
	out EEARH, r23
	out EEARL, r22
	out EEDR, r16
	sbi EECR, EEMWE
	sbi EECR, EEWE
	ret

