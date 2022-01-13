;	TABLA DE DECODIFICACIÓN (Display de cátodo común)
	
	; 0	| 0 0 1 1 1 1 1 1	$3F -> R20
	; 1 | 0 0 0 0 0 1 1 0	$06 -> R21
	; 2 | 0 1 0 1 1 0 1 1	$5B -> R22
	; 3 | 0 1 0 0 1 1 1 1	$4F -> R23
	; 4 | 0 1 1 0 0 1 1 0	$66 -> R24
	; 5 | 0 1 1 0 1 1 0 1	$6D -> R25
	; 6 | 0 1 1 1 1 1 0 1	$7D -> R26
	; 7 | 0 0 0 0 0 1 1 1	$07 -> R27
	; 8 | 0 1 1 1 1 1 1 1	$7F -> R28
	; 9 | 0 1 1 0 1 1 1 1	$6F -> R29

	; A | 0 1 1 1 0 1 1 1	$77	
	; B | 0 1 1 1 1 1 0 0	$7C
	; C | 0 0 1 1 1 0 0 1	$39
	; D | 0 1 0 1 1 1 1 0	$5E
	; E | 0 1 1 1 1 0 0 1	$79
	; F | 0 1 1 1 0 0 0 1	$71

	;Apuntador x: r26, r27
	;Apuntador y: r28, r29
	;Apuntador z: r30, r31
	
	
	.include"m8535def.inc"
	ser r16			; 1.- Configuración de puertos
	out ddra,r16
	out portb,r16

	ldi r16,$3F		; 2.- Cargar tabla de decodificación
	mov r0,r16		
	ldi r16,$06
	mov r1,r16
	ldi r16,$5B
	mov r2,r16
	ldi r16,$4F
	mov r3,r16
	ldi r16,$66
	mov r4,r16
	ldi r16,$6D
	mov r5,r16
	ldi r16,$7D
	mov r6,r16
	ldi r16,$07
	mov r7,r16
	ldi r16,$7F
	mov r8,r16
	ldi r16,$6F
	mov r9,r16
	ldi r16,$77
	mov r10,r16
	ldi r16,$7C
	mov r11,r16
	ldi r16,$39
	mov r12,r16
	ldi r16,$5E
	mov r13,r16
	ldi r16,$79
	mov r14,r16
	ldi r16,$71
	mov r15,r16

	clr ZH			; 3.- ZH <- $00

cuatro:
	
	in r16,pinb		; 4.- Ingresa el dato r15 <- PB

	mov ZL,r16		; 5.- Mueve el dato que esta en r16 a ZL  (ZL <- r16)

	ld r16,Z		; 6.- Lee el dato en Z (r16 <- Z)

	out porta,r16	; 7.- Muestra en el PA <- r16

	rjmp cuatro		; 8.- Ir al punto cuatro
