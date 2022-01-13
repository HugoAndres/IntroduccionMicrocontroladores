	.include"m8535def.inc"	
	.def aux = r16			;Asignar nombres a los registros
	.def col = r17			;La información que se enviara al puerto C

	ldi aux,low(RAMEND)		;Inicialización el apuntador de pila
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	
	ser aux					;Configuración del puerto A y puerto C como salida
	out ddra,aux
	out ddrc,aux
	
	ldi aux,$40				;Carga de información
	mov r5,aux
	mov r0,aux
	ldi aux,$77
	mov r1,aux
	ldi aux,$38
	mov r2,aux
	ldi aux,$3F
	mov r3,aux
	ldi aux,$76
	mov r4,aux
	
	clr zh					;Carga 0 en ZH

barre:						;Obtener la dirección de los datos			
	ldi zl,6
	ldi col,0b00100000		;Carga un 1 en el bit 5 en el registro col

otro:						
	out portc,col			;Manda la información al puerto C
	ld aux,-z				
	out porta,aux
	rcall delay
	out porta,zh
	lsr col
	breq barre
	rjmp otro
delay:
; Assembly code auto-generated
; by atility from Bret Mulvey
; Delay 3493 cycles
; 3ms 493us at 1MHz

	ldi r18, 5
	ldi r19, 136
L1: dec r19
	brne L1
	dec r18
	brne L1
	rjmp PC+1
	ret
