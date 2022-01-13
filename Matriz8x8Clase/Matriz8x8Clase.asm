	.include"m8535def.inc"
	.def adh=r16
	.def adl=r17
	.def col=r18
	.def aux=r19
	.def cta=r20
;---------------------------------------
.macro num
	push zh
	push zl
	ldi ZH, high(@0<<1)
	ldi ZL, low(@0<<1)
	lpm r0, Z+
	lpm r1, Z+
	lpm r2, Z+
	lpm r3, Z+
	lpm r4, Z+
	lpm r5, Z+
	lpm r6, Z+
	lpm r7, Z
	pop zl
	pop zh
.endm

	rjmp start
	.org $008
	rjmp cuenta
	rjmp barre
	.org $0E
	rjmp conv

start:
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16
	ser r16
	out ddrd, r16
	out ddrb, r16
	out ddrc, r16
	ldi r16, $ED
	out ADCSRA, r16
	ldi r16, $20
	out ADMUX, r16
	ldi aux, 2
	out tccr0, aux
	ldi aux, 2
	out tccr1b, aux
	ldi aux, 5
	out timsk, aux
	sei
	ldi cta, -1
	ldi col, 1
	clr zh
	ldi zl, 0
loop:
	out portc, adh
	rjmp loop
conv:
	in adl, ADCL
	in adh, ADCH
	reti
barre:
	out portb, zh
	ld aux, z+
	lsl col
	brcs nbarre
sss:
	com col
	out portd, col
	com col
	out portb, aux
	reti
nbarre:
	ldi col, 1
	ldi zl, 0
	ld aux, z+
	rjmp sss
cuenta:
	inc cta
	cpi cta, 0
	breq cta0
	cpi cta, 1
	breq cta1
	cpi cta, 2
	breq cta2
	cpi cta, 3
	breq cta3
	cpi cta, 4
	breq cta4
	cpi cta, 5
	breq cta5
	cpi cta, 6
	brne ncta
	ldi cta, -1
ncta:
	reti
cta4:
	rjmp cta41
cta5:
	rjmp cta51
cta0:
	num cero
	rjmp ncta
cta1:
	num uno
	rjmp ncta
cta2:
	num dos
	rjmp ncta
cta3:
	num tres
	rjmp ncta
cta41:
	num cuatro
	rjmp ncta
cta51:
	num cinco
	rjmp ncta
;------------------------------------------------------
cero:
	.db $00, $7C, $82, $82, $82, $7C, $00, $02
uno:
	.db $00, $22, $42, $FE, $02, $02, $00, $04
dos:
	.db $00, $42, $86, $8A, $92, $62, $00, $08
tres:
	.db $00, $44, $82, $92, $92, $6C, $00, $10
cuatro:
	.db $00, $08, $18, $28, $48, $FE, $00, $20
cinco:
	.db $00, $F4, $92, $92, $92, $8C, $00, $40
