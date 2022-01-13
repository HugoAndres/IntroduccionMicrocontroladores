.include "m8535def.inc"
.def aux = r16 ;Se declaran etiquetas
.def aux2 = r17
.def aux3 = r18
.def aux4 = r19
.def aux5 = r20
.def aux6 = r21
.org 0x000 ;Se declara vector de RESET
rjmp main
.org 0x004 ;Se declara vector de Desbordamiento de Timer 2
rjmp tiempo
.org 0x008 ;Se declara vector de Desbordamiento de Timer 1
rjmp cuenta1
main:
ldi aux,low(RAMEND) ;Se inicia declaracion de Pila
out spl,aux
ldi aux,high(RAMEND)
out sph,aux ;Se termina declaracion de Pila
ser aux
clr aux2
out ddra,aux ;Se prepara salida de DDRA
out ddrc,aux ;Se prepara salida de DDRC
out ddrd,aux ;Se prepara salida de DDRD
ldi aux,$3f ;Empieza carga de números en Display
mov r2,aux
ldi aux,$06
mov r3,aux
ldi aux,$5b
mov r4,aux
ldi aux,$4f
mov r5,aux
ldi aux,$66
mov r6,aux
ldi aux,$6d
mov r7,aux
ldi aux,$7d
mov r8,aux
ldi aux,$27
mov r9,aux
ldi aux,$7f
mov r10,aux
ldi aux,$6f
mov r11,aux ;Termina carga de números en Display
ldi aux4,4
out timsk,aux4 ;Se define Timsk en 4
ldi aux,6
out tccr0,aux ;Se establece la escala de Timer 0
ldi aux,2
out tccr1b,aux ;Se establece la escala de Timer 1
ldi aux4,2
out tccr2,aux4 ;Se establece la escala de Timer 2
ldi aux6,101
out tcnt2,aux6 ;Se carga 101 a Timer 2
sei ;Se activa la bandera de interrupción
clr aux5 ;Se declaran valores adicionales
clr r22
clr r23
ldi r27,1
rcall EEPROM_read ;Lee de EEPROM
cpi r26,$ff ;Si recibe $FF de EEPROM limpia, sino sigue
breq limpia
rjmp loop
limpia:
clr r26
loop:
rcall barre ;Se llama al barrido de columna
rcall deco ;Se llama al decodificador
in r23,tcnt0 ;Se guarda el valor de tcnt0 en r23
cpi r23,7 ;Se verifica si r23 tiene 7
breq activa ;Si es asi salta a "activa"
in r22,tcnt2 ;Se guarda el valor de tcnt2 en r22
cpi r22,$fe ;Se verifica si r22 tiene $FE
brne sigue ;Si no es asi salta a "sigue"
ldi aux4,$40
out timsk,aux4 ;Se define Timsk en $40
rjmp sigue ;Salta a sigue
sigue:
rjmp loop ;Salta a "loop"
activa:
cpi r26,$63
brne incre
clr r26
rjmp escr
incre:
inc r26
escr:
rcall EEPROM_write ;Escribe el valor del turno en la EEPROM
clr r23 ;Limpia el registro 23
out tcnt0,r23 ;Limpia el registro tcnt0
ldi aux2,10 ;Carga 10 en aux2 (Entrada al contador)
ldi aux5,3 ;Carga 3 en aux5
ldi aux,$f0
out tcnt2,aux ;Carga $F0 en tcnt2
ldi aux,$ff
out tcnt1h,aux ;Carga $FF en tcnt1h
out tcnt1l,aux ;Carga $FF en tcnt1l
rjmp loop ;Salta a "loop"
tiempo: ;Interrupcion Desbordamiento Timer 2 (Sonido)
out tcnt2,aux6 ;Carga aux6 en tcnt2
in aux4,pina ;Guarda en aux4 el valor de PINA
eor aux4,aux5 ;OR exclusivo entre aux4 y aux5
out porta,aux4 ;Saca aux4 en PORTA
ldi aux4,4
out timsk,aux4 ;Se define Timsk en 4
reti ;Sale de la interrupción
cuenta1: ;Interrupcion Desbordamiento Timer 1(Contador 1/2 seg)
dec aux2 ;Decrementa aux2
brne sal ;Si no es 0 salta a "sal"
ldi aux3,$0b
out tcnt1h,aux3 ;Carga $0B en tcnt1h
ldi aux3,$dd
out tcnt1l,aux3 ;Carga $DD en tcnt1l
ldi aux2,0 ;Limpia aux2
ldi aux,0 ;Limpia aux
clr aux5 ;Limpia aux5
out porta,aux5 ;Limpia PORTA
sal:
reti ;Sale de la interrupción
EEPROM_write: ;Escribir en la EEPROM
sbic EECR,EEWE
rjmp EEPROM_write
out EEARH,r24
out EEARL,r25
out EEDR,r26
sbi EECR,EEMWE
sbi EECR,EEWE
ret
EEPROM_read: ;Leer de la EEPROM
sbic EECR,EEWE
rjmp EEPROM_read
out EEARH, r24
out EEARL, r25
sbi EECR,EERE
in r26,EEDR
ret
barre: ;Barrido de columna
out portc,r27
cpi r27,1
brne sun
out portd,r28
rjmp sdo
sun:
out portd,r29
sdo:
lsl r27
cpi r27,4
breq nvo
salir:
ret
nvo: ;Se reinicia columna
clr zl
ldi r27,1
rjmp salir
deco: ;Decodificador
mov r28,r26
cpi r28,$0a
brsh decen
ldi r29,0
rjmp dire
decen:
ldi r29,0
ldi aux,10
mov r0,aux
multi:
inc r29
mul r0,r29
sub r28,r0
cpi r28,$0a
brlo dire
ldi aux,10
mov r0,aux
mov r29,r26
rjmp multi
dire:
ldi r30,2
add r30,r28
ld r28,z
ldi r30,2
add r30,r29
ld r29,z
out portd,zh
ret
