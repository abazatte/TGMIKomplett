testbench:
addi $sp,$sp,-12 			# Platz auf Stack schaffen
ori $t0,$0,44 				# 44 nach $t0
sw $t0,8($sp) 				# und auf Stack ablegen
ori $t0,$0,12 				# 12 nach $t0
sw $t0,4($sp)		 		# und auf Stack ablegen
jal ggt 				# Sprung in den zu testenden Code
nop 					# dieser Befehl wird noch ausgeführt! (wg. Pipelining)
lw $at,0($sp) 				# Rückgabewert vom Stack holen
addi $sp,$sp,12				# Stackpointer wieder auf Anfangswert (Platz freigeben)
ori $v0,$0,10			 	# Funktion: Programm beenden
syscall				 	# Simulatorfunktion ausführen
 
ggt:
	beq $a0,$0,if_1
	nop
else:
	while:
		beq $a1, $0, end_while
		nop
		
		sub $t1, $a0, $a1
		bgtz $t1, if_2
		nop
	else_2:
		sub $a1, $a1, $a0
		j while
		nop
	if_2:	
		sub $a0, $a0, $a1
		j while
		nop
	end_while:
		add $t0, $0, $a0
		j end
		nop
if_1: 
	add $t0, $0, $a1
end:
	add $v0, $t0, $0
	jr $ra
	nop
#addi $sp,$sp,-16			# Platz auf Stack schaffen
#nop					# nop
#lw $t2,20($sp)				# b von Stack holen
#lw $t3,24($sp)				# a von Stack holen
#bne  $t3,$0, Else			# if-Else-Abfrage
#nop					# nop
#add $v0,$0,$t2	
#sw $v0,8($sp)				# Rückgabewert = b
#j  Endif				# Sprung zu Endif
#nop					# nop
#Else:					# Else 
#	while:				# ab hier while Schleife weitermachen
#	beq  $t2, $0, Endwhile
#	bgt $t3,$t2, if
#	nop
#	sub $t2,$t2,$t3
#	j endif
#	nop
#	if:
#	sub $t3,$t3,$t2
#	endif:
#	nop
#j while
#nop
#Endwhile:
#add $v0,$0,$t3	
#sw $v0,16($sp)
#nop		
					
					
#Endif:					# Endif, Else übersprungen
#addi $sp,$sp,16				# Stack wird zurückgesetzt	
#jr $ra					# jump Befehl zum Hauptprogramm
#nop					# nop
