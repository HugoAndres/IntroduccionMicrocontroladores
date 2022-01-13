.include"m8535def.inc"
	.def aux = r16
	.def contador = r17
	.def convertir = r23
	.equ N0 = $3f
	.equ N1 = $06
	.equ N2 = $5b
	.equ N3 = $4f
	.equ N4 = $66
	.equ N5 = $6d
	.equ N6 = $7d
	.equ N7 = $27
	.equ N8 = $7f
	.equ N9 = $6f
.macro ldb
	ldi aux,@1
	mov @0,aux
	.endm
.macro datos
	ldb r9,@0
	ldb r8,@1
	ldb r7,@2 
	ldb r6,@3
	ldb r5,@4 
	ldb r4,@5
	ldb r3,@6 
	ldb r2,@7
	ldb r1,@8 
	ldb r0,@9
	.endm

main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	ser aux
	out ddra,aux
	out portd,aux
	ldi aux, N0
	out porta,aux
checa:
	sbis pind,2
	rcall ascendente
	sbis pind,3
	rcall descendente
	rjmp checa
cuatro:
	mov convertir, r9
	mov r9,r8
	mov r8,r7
	mov r7,r6
	mov r6,r5
	mov r5,r4
	mov r4,r3
	mov r3,r2
	mov r2,r1
	mov r1,r0
	mov r0,convertir
	out porta,convertir
	rcall retardo
	rjmp cuatro
retardo:
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 499 993 cycles
; 499ms 993us at 1 MHz

    ldi  r18, 3
    ldi  r19, 138
    ldi  r20, 84
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    nop
	ret
ascendente:
	datos N0,N1,N2,N3,N4,N5,N6,N7,N8,N9
	rcall cuatro
	ret
descendente:
	datos N9,N8,N7,N6,N5,N4,N3,N2,N1,N0
	rcall cuatro
	ret

