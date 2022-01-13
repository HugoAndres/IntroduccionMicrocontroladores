	.include"m8535def.inc"
	.def aux = r16
	.def contador = r17

	ldi aux,low(RAMEND)		;Inicializar SP
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux

	ser aux					;Configurar el puerto A como salida
	out ddra,aux

	clr contador
	ldi r22, $09			;Inicializar el registro que usara como "contador" a 0

cuatro:
	mov r23, contador
	cpi r23,0
	breq D0
	cpi r23,1
	breq D1
	cpi r23,2
	breq D2
	cpi r23,3
	breq D3
	cpi r23,4
	breq D4
	cpi r23,5
	breq D5
	cpi r23,6
	breq D6
	cpi r23,7
	breq D7
	cpi r23,8
	breq D8
	cpi r23,9
	breq D9
	out porta,r23
	cpi contador,9
	breq reinicio
	rcall retardo
	inc contador
	rjmp cuatro

retardo:
; Assembly code auto-generated
; by utility from Bret Mulvey
; Delay 2 999 985 cycles
; 749ms 996us 250 ns at 4 MHz
	
    ldi  r18, 16
    ldi  r19, 57
    ldi  r20, 9
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    rjmp PC+1
	ret

D0:
	ldi r23,$3f
	rjmp cuatro+21
D1:
	ldi r23,$06
	rjmp cuatro+21
D2:
	ldi r23,$5b
	rjmp cuatro+21
D3:
	ldi r23,$4f
	rjmp cuatro+21
D4:
	ldi r23,$66
	rjmp cuatro+21
D5:
	ldi r23,$6d
	rjmp cuatro+21
D6:
	ldi r23,$7d
	rjmp cuatro+21
D7:
	ldi r23,$07
	rjmp cuatro+21
D8:
	ldi r23,$7f
	rjmp cuatro+21
D9:
	ldi r23,$6f
	rjmp cuatro+21

reinicio:
	ldi contador,$00
	rjmp cuatro
