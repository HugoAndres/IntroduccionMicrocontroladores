	.include"m8535def.inc"

inicio:
	ser r16
	out ddra,r16
	out portb,r16 

casoCero:			; Si se ingresa $00, el resultado es $10

	in r16,pinb 	; Guarda el dato de entrada en el registro r16
	ldi r17,$01 	; Guarda $01 en el registro r17
	ldi r20,$10		; Guarda $10 en el registro r20
	cp r16,r17		; Compara el registro r16 y r17 [r16 - r17]
	brlo resultado	; if (C = 1) 
	ldi r18,$02 	; Guarda $02 en r18
	mov r19,r17 	; Mueve el dato de r17 -> r19
	clr r20     	; Limpia el registro r20 

sacandoRaiz:
	cp r16,r19 		; Realiza la operación r16 - r19
	brlo resultado	; if (C = 1)
	add r17,r18 	; r17 <- r17 + r18
	add r19,r17 	; r19 <- r19 + r17
	inc r20     	; r20 <- r20 + 1 
	cpi r20,$0F     ; r20 - $0F
    breq resultado  ; if (Z = 1)
	rjmp sacandoRaiz

resultado:
	out porta,r20	; Resultado
	rjmp inicio
	
