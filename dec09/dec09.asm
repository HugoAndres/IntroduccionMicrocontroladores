
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

	ldi r20,$3F		; 2.- Cargar tabla de decodificación
	ldi r21,$06
	ldi r22,$5B
	ldi r23,$4F
	ldi r24,$66
	ldi r25,$6D
	ldi r26,$7D
	ldi r27,$07
	ldi r28,$7F
	ldi r29,$6F

	clr ZH			; 3.- ZH <- $00

cuatro:
	ldi ZL,20		; 4.- ZL <- 20 [porque el primer datos esta en el registro 20]
	
	in r16,pinb		; 5.- Ingresa el dato r15 <- PB

	add ZL,r16		; 6.- Suma 20 + r16 (ZL <- ZL + r16)

	ld r16,Z		; 7.- Lee el dato en Z (r16 <- Z)
	
	out porta,r16	; 8.- Muestra en el PA <- r16

	rjmp cuatro		; 9.- Ir al punto cuatro

