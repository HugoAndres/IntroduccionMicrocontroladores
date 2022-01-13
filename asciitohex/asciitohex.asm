	.include"m8535def.inc"
	ser r16
	out ddra,r16
	out portb,r16
	ldi r17,$30
	ldi r18,7
dos:
	in r16,pinb
	add r16,r17
	cpi r16,$3A
	brlo cinco
	add r16,r18
cinco:
	out porta,r16
	rjmp dos
