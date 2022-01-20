unsersub:
	addi $t0, $0, 0
	addi $t0, $0, 0
	
mach:
	srav $t2, $a1, $t0
	andi $t2, $t2, 1
	
	   addi $t0, $t0, 1
	   bne $t2, $0, wenn
	   nop
	   j waehrend
	   nop
wenn:
	addi $t1, $t1, 1
	
waehrend:
	sub $t3, $a0, $t0
	bgtz $t3, mach
	nop
	sub $t4, $t1, $a2
	bgtz $t4, wenn_
	nop
	j ende
	nop
wenn_:
	add $t1, $0, $0

ende:
	add $v0, $0, $t1
	jr $ra
	nop