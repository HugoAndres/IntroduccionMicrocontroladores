	.include"m8535def.inc"
	.def aux = r16 
	.def aux2 = r17
	.def aux3 = r5
	.def aux4 = r18

	.macro boton ;Declaración de macro
		cj:
			sbic pinb,@0
			rjmp sig
			rjmp cj
		sig:
			rcall ideco
			ldi aux,@1
			mov aux3,aux
			rjmp fin
	.endm

reset: 				;Interrupción reset
	rjmp main
	.org $009 		
	rjmp barre
main:
	ldi aux,low(ramend) ;Declaración de la pila
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux 
	ser aux
	out ddra,aux 
	out ddrc,aux 
	out portb,aux 
	ldi aux,2
	out tccr0,aux 
	ldi aux,1
	out timsk,aux 
	sei 
	ldi aux,$99
	mov r6,aux ;Número máximo de turnos
	ldi aux4,1 
	ldi r20,$3f ;Carga de números en Display
	ldi r21,$06
	ldi r22,$5b
	ldi r23,$4f
	ldi r24,$66
	ldi r25,$6d
	ldi r26,$7d
	ldi r27,$27
	ldi r28,$7f
	ldi r29,$6f 
	ldi aux,$06
	mov aux3,aux 
	ldi aux,$39
	mov r4,aux ;C
	ldi aux,$40
	mov r3,aux ;-
	ldi aux,$06
	mov r2,aux 
	ldi aux,$3f
	mov r1,aux 
	ldi aux,$78
	mov r0,aux 
	clr zh
	clr zl 
	ldi aux2,4 
fin:
	sbis pinb,0
	rjmp cj1 
	sbis pinb,1
	rjmp cj2 
	sbis pinb,2
	rjmp cj3 
	sbis pinb,3
	rjmp cj4 
	sbis pinb,4
	rjmp cj5 
	rjmp fin 
barre: 
dos: 
	out porta,zh
	com aux2
	out portc,aux2
	com aux2
	ld aux,z+
	out porta,aux
	lsl aux2
	brcs nvo
salir: 
	reti
nvo: 
	clr zl
	ldi aux2,4
	rjmp salir
cj1: 
	boton 0,6
cj2:
	boton 1,$5b
cj3:
	boton 2,$4f
cj4:
	boton 3,$66
cj5:
	boton 4,$6d 
ideco: 
	push zl
	cp aux4,r6
	brne increm 
	ldi aux4,1
	rjmp et1
increm:
	inc aux4 
et1:
	ldi zl,20
	mov r19,aux4
	andi r19,$0f
	cpi r19,$0a
	breq ipht
	add zl,r19
	ld r19,z
	mov r2,r19
	mov r19,aux4
	swap r19
	andi r19,$0f
	ldi zl,20
	add zl,r19
	ld r19,z
	mov r1,r19
	pop zl
	ret
ipht:
	ldi r30,$06
	add aux4,r30
	rjmp et1
