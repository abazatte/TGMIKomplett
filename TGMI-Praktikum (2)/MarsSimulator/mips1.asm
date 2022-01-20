addi $t0, $0, 31
sub $t2, $t0, $a1

beding:
	sub $t2, $t0, $a1
	bgtz $t2, while
	nop
endwhile:
	addi $t4, $0, 5
	mult $t0, $t4
	add $v0, $t0, $0
	mflo $v0
	j end
	nop
while:
	srav $t1, $a0, $t0
	andi $t1, $t1, 1
	addi $t5, $0, 1
	bne $t1, $t5, if
	nop
else:
	addi $t0, $t0, -1
	j beding
	nop
if:
	addi $t0, $t0, -2
	j beding
	nop
end:
	jr $ra