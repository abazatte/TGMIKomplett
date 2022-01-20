.text
	nop	# *****************************************************
	nop	# *****                                           *****
	nop	# *****    Hier beginnt der Code der Testbench    *****
	nop	# *****                                           *****
	nop	# *****************************************************
	
__check_ra:             # falls der Rücksprung im aufrufenden Programm nicht steht, landen wir hier
	la	 $a0,__missing_jr_str  
	ori  $v0,$0,4
	syscall
	ori  $v0,$0,10   	# Funktion: Ende des Programms
    syscall     		# tschuess
	nop	
	
.globl main

main:
testbench:
	la	 $a0,__start_str
	ori  $v0,$0,4
	syscall
	la   $k0,__testdata # 
	lw 	 $k1,0($k0)		# Anzahl der Testfälle nach $k1
	lw 	 $s4,0($k0)		# Anzahl der Testfälle auch nach $s4
	lw 	 $s6,4($k0)		# Anzahl der Operanden nach $s6
	addi $s6,$s6,-1		# $s6 ist jetzt 0 oder 1
	ori  $s5,$0,0		# $s5 = Fehlerzähler
	addi $k0,$k0,8		# Adresse erhöhen



__test_loop:
	beq	 $s6,$0,__read_one_op	# nur 1 Operand?
	nop	
	lw 	 $a0,0($k0)		# Operand 1 nach $a0
	lw 	 $a1,4($k0)		# Operand 2 nach $a1
	lw 	 $s7,8($k0)		# Erwartetes Ergebnis nach $s7
	j    __do_test
	nop 
__read_one_op:	
	lw 	 $a0,0($k0)		# Operand 1 nach $a0
	lw 	 $s7,4($k0)		# Erwartetes Ergebnis nach $s7
	
__do_test:
	addi $sp,$sp,-24	# kritische Register auf dem Stack sichern
	sw	 $k0,0($sp)
	sw	 $k1,4($sp)
	sw	 $s4,8($sp)	
	sw	 $s5,12($sp)	
	sw	 $s6,16($sp)	
	sw	 $s7,20($sp)
	
	jal  program_under_test
	nop

	lw	 $k0,0($sp)		# kritische Register zurückholen
	lw	 $k1,4($sp)
	lw	 $s4,8($sp)
	lw	 $s5,12($sp)
	lw	 $s6,16($sp)
	lw	 $s7,20($sp)
	addi $sp,$sp,24
     
	beq  $v0,$s7,__ok	# kein Fehler, dann weiter
	nop
	
	jal __fehlermeldung	# Fehlermeldung ausgeben
	nop
	
__ok:	
	beq	 $s6,$0,__inc_one_op	# nur 1 Operand?
	nop	
	addi $k0,$k0,12		# Adresse für Testdaten erhöhen
	j __finish_check
	nop 
__inc_one_op:
	addi $k0,$k0,8		# Adresse für Testdaten erhöhen
		
__finish_check:
	addi $k1,$k1,-1		# Testzähler dekrementieren
	beq  $k1,$0,__ende	# Alle Tests durchgelaufen ?
	nop
	
	j    __test_loop	# Nein, dann weiter mit nächstem Test
	nop
	
__ende:
	la	 $a0,__ende_str
	ori  $v0,$0,4
	syscall

	la	 $a0,__anz_tests_str
	ori  $v0,$0,4
	syscall
	or	 $a0,$0,$s4
	ori  $v0,$0,1
	syscall

	la	 $a0,__anz_fehler_str
	ori  $v0,$0,4
	syscall
	or	 $a0,$0,$s5
	ori  $v0,$0,1
	syscall
	la	 $a0,__newline_str
	ori  $v0,$0,4
	syscall
	syscall
		
	ori  $v0,$0,10   	# Funktion: Ende des Programms
    syscall     		# tschuess


__fehlermeldung:
	ori  $s7,$v0,0		# errechnetes (falsches) Ergebnis sichern
	addi $s5,$s5,1		# Fehlerzähler erhöhen
	
	la	 $a0,__fehler_str
	ori  $v0,$0,4
	syscall
	lw	 $a0,0($k0)
	ori  $v0,$0,1
	syscall
	la	 $a0,__space_str
	ori  $v0,$0,4
	syscall
	lw	 $a0,4($k0)
	ori  $v0,$0,1
	syscall
	la	 $a0,__space_str
	ori  $v0,$0,4
	syscall
	beq	 $s6,$0,__print_one_op	# nur 1 Operand?
	nop							# dann ist jetzt bereits alles ausgegeben
	lw	 $a0,8($k0)
	ori  $v0,$0,1
	syscall
	la	 $a0,__space_str
	ori  $v0,$0,4
	syscall
__print_one_op:
	ori  $a0,$s7,0
	ori  $v0,$0,1
	syscall
	la	 $a0,__newline_str
	ori  $v0,$0,4
	syscall
	jr   $ra
	nop
	
.data 
__fehler_str:
	.asciiz	"Fehler: "
__newline_str:
	.asciiz	"\n"
__space_str:
	.asciiz	" "
__anz_tests_str:
	.asciiz	"\nAnzahl der Tests:  "
__anz_fehler_str:
	.asciiz	"\nAnzahl der Fehler: "
__ende_str:
	.asciiz	"\nTests beendet\n"
__start_str:
	.asciiz	"\n\nStart der Tests\n"
__missing_jr_str:
	.asciiz	"\n\nHaben in Ihrem Code 'jr $ra' vergessen?\nProgramm wird beendet.\n\n"

.text
