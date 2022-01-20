addi $a1, $0, 30
addi $t0, $0, 1

beding:
	ble $t0, $a1, for
	nop
	
end:
	addi $v0, $0, 10
	syscall
	
for:	add $a0, $0, $t0
	addi $v0, $0, 1
	syscall
	addi $t0, $t0, 1
	j beding
	nop
	