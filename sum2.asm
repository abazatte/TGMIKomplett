addi $t0, $0, 69
addi $t1, $0, 720
add $a0, $t0, $t1
addi $a0, $a0, 100
ori $v0, $0, 1
syscall
ori $v0, $0, 10
syscall