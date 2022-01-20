sum:
		addi $t1, $0, 0
		addi $t2, $0, 101
	beding:
		sub $t3, $t2, $t1
		bgtz $t3, for
		nop
		j endfor
		nop
		for:
			add $t0, $t0, $t1
			addi $t1, $t1, 1
			j beding
			nop
		endfor:
			ori $a0, $t0, 0
			ori $v0, $0, 1
			syscall
			ori $v0, $0, 10
			syscall
			