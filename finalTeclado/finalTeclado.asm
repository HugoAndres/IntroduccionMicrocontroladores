    .include"m8535def.inc"
    .def aux =r16
    .def col=r17
    .def tec = r19
    .def tecf = r20
    .equ GUION = $40
    .equ POR = $76
    .equ ENTRE = $49
    .equ MAS = $52
    .equ IGUAL = $48
    .equ CERO = $3F
    .equ UNO = $06
    .equ DOS = $5B
    .equ TRES = $4F
    .equ CUATRO = $66
    .equ CINCO = $6D
    .equ SEIS = $7D
    .equ SIETE = $27
    .equ OCHO = $7F
    .equ NUEVE = $6F
.macro ldb
    ldi aux,@1
    mov @0,aux
.endm
.macro mensaje
    ldb r7,@0
    ldb r6,@1
    ldb r5,@2
    ldb r4,@3
    ldb r3,@4
    ldb r2,@5
    ldb r1,@6
    ldb r0,@7
.endm
reset:
    rjmp main ; vector de reset
    rjmp mueve;verctor INT0
    rjmp borra; vector INT1
    .org $009
    rjmp barre;vector timer0
main:
    ldi aux,low(ramend)
    out spl,aux
    ldi aux,high(ramend)
    out sph,aux
    rcall config_io
    rcall texto0
    clr zh
    clr zl
    ldi col,1
    out portc,col
    ld aux,z
    out porta,aux
opuno:
    nop
    nop
    nop
    rjmp opuno
config_io:
    ser aux
    out ddra,aux
    out portb,aux
    out ddrc,aux
    out portd,aux
    ldi aux,3
    out tccr0,aux; preescala ck/64
    ldi aux,$01; 0000 0001
    out timsk,aux; toie0
    ldi r18,193; para contar 63 4ms
    ldi aux,$03; 0000 0011
    out mcucr,aux
    ldi aux,$C0; 1100 0000
    out gicr,aux; habilito INT0 e INT1
    sei
    ret
texto0:
    mensaje GUION,GUION,GUION,GUION,GUION,GUION,GUION,GUION
    ret
barre:
    out tcnt0,r18
    out porta,zh
    inc zl
    lsl col
    brne opdos; si z = 0
    ldi col,1
    clr zl
opdos:
    out portc,col
    ld aux,z
    out porta,aux
    reti
mueve:
    mov r8,r7
    mov r7,r6
    mov r6,r5
    mov r5,r4
    mov r4,r3
    mov r3,r2
    mov r2,r1
    mov r1,r0
    in tec,pinb
    cpi tec,$7E
    breq LA
    cpi tec,$BE
    breq LCERO
    cpi tec,$DE
    breq LIGUAL
    cpi tec,$EE
    breq LMAS
    cpi tec,$7D
    breq LUNO
    cpi tec,$BD
    breq LDOS
    cpi tec,$DD
    breq LTRES
    cpi tec,$ED
    breq LMENOS
    cpi tec,$7B
    breq LCUATRO
    cpi tec,$BB
    breq LCINCO
    cpi tec,$DB
    breq LSEIS
    cpi tec,$EB
    breq LPOR
    cpi tec,$77
    breq LSIETE
    cpi tec,$B7
    breq LOCHO
    cpi tec,$D7
    breq LNUEVE
    cpi tec,$E7
    breq LENTRE
suelta:
    in tecf,pinb
    cp tecf,tec
    breq suelta  
    reti
LA:
    ldb r8, GUION
    rcall texto0
    rjmp suelta
LCERO: 
    ldb r0,CERO
    rjmp suelta
LIGUAL: 
    ldb r0,IGUAL
    rjmp suelta
LMAS:
    ldb r0,MAS
    rjmp suelta
LUNO:
    ldb r0,UNO
    rjmp suelta
LDOS:
    ldb r0,DOS
    rjmp suelta
LTRES:
    ldb r0,TRES
    rjmp suelta
LMENOS:
    ldb r0,GUION
    rjmp suelta
LCUATRO:
    ldb r0,CUATRO
    rjmp suelta
LCINCO:
    ldb r0,CINCO
    rjmp suelta
LSEIS:
    ldb r0,SEIS
    rjmp suelta
LPOR:
    ldb r0,POR
    rjmp suelta
LSIETE:
    ldb r0,SIETE
    rjmp suelta
LOCHO:
    ldb r0,OCHO
    rjmp suelta
LNUEVE:
    ldb r0,NUEVE
    rjmp suelta
LENTRE:
    ldb r0,ENTRE
    rjmp suelta
borra:
    ;rutina que borra última tecla
    ldb r8,GUION
    mov r0,r1
    mov r1,r2
    mov r2,r3
    mov r3,r4
    mov r4,r5
    mov r5,r6
    mov r6,r7
    mov r7,r8
    mov r8,r9
    reti
