ori $v0, $0, 5
syscall
ori $t0, $v0, 0
ori $v0, $0, 5
syscall
ori $t1, $v0, 0
slt $t3, $t0, $t1
beq $t3, $0, ausga
nop
ori $a0, $t1, 0
j end
nop
ausga: 
	ori $a0, $t0, 0
	j end
	nop
end:
	ori $v0, $0, 1
	syscall
	ori $v0, $0, 10
	syscall