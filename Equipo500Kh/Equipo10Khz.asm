.include "m8535def.inc"
.def aux = r16
.def aux1 = r17
.def aux2 = r17
reset:
    rjmp main
	.org $008
    rjmp onda0
    .org  $009
    rjmp onda
main:
    ldi aux , low (RAMEND)        ;Inicializa la pila
    out spl , aux
    ldi aux , high (RAMEND)
    out sph , aux
    rcall config
fin:
    nop
    nop
    rjmp fin
config:
    ser aux               ;Configuración puerto A como salida
    out ddra , aux
    ldi aux ,2                ; Ponemos 2 en la prescala del TimeCounter0
    out tccr0 , aux
    ldi aux ,1                ; Habilita el TimerCounter0
    out timsk , aux
    sei
    ldi aux2 ,132
    ret
onda0:
	ldi aux1, 1
    ldi aux2, 214
onda :
    nop
    out tcnt0 , aux2
    in aux , pina    
    com aux
    out porta , aux
    reti
