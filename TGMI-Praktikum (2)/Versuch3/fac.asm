fac:
addi $v0 , $0 , 1
addi $t1 , $0 , 1
addi $t2 , $0 , 1
nop
for:
beq  $t1, $a0 , Endfor
mul $v0 , $v0 , $t1
add $t1 , $t1 , $t2
nop
j for
nop
Endfor:
jr $ra
nop

	# Diese Zeilen müssen die letzten Zeilen sein -- nicht ändern!
	.eqv program_under_test fac
	.include "testbench.asm"			
	.include "testdata_fac.asm"
	
	
