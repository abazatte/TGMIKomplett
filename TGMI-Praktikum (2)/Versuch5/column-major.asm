#  Row-major order traversal of n x n array of words.
#  Pete Sanderson 31 March 2007, adapted by W. Gehrke 2018

         ori      $t0,$0,8 # $t0 = number of rows
         or       $t1,$t0,$0     # $t1 = number of columns (same as rows)
         or       $s0,$0,$0      # $s0 = row counter
         or       $s1,$0,$0      # $s1 = column counter
         or       $t2,$0,$0      # $t2 = the value to be stored
         
         #  Each loop iteration will store incremented $t1 value into next element of matrix.
         #  Offset is calculated at each iteration. offset = 4 * (row*#cols+col)
         #  Note: no attempt is made to optimize runtime performance!
         
loop:    mul      $s2,$s0, $t1   # $s2 = row * #cols  (two-instruction sequence)
         add      $s2, $s2, $s1  # $s2 += column counter
         sll      $s2, $s2, 2    # $s2 *= 4 (shift left 2 bits) for byte offset
         sw       $t2, data($s2) # store the value in matrix element
         addi     $t2, $t2, 1    # increment value to be stored
         
         #  Loop control: If we increment past last column, reset column counter and increment row counter
         #                If we increment past last row, we're finished.
         
                          
         #########################################################
         # Fuer Row/Column-Tausch hier $s0 und $s1 tauschen
         #########################################################
         
         addi     $s0, $s0, 1    # increment row counter
         bne      $s0, $t1, loop # not at end of row so loop back
         nop
         
         addi     $s0, $0,  0    # reset row counter
         addi     $s1, $s1, 1    # increment column counter
         bne      $s1, $t0, loop # not at end of matrix so loop back
         nop
         
         #  We're finished traversing the matrix.
         
         ori      $v0,$0,10      # system service 10 is exit
         syscall                 # we are outta here.
         
         
         .data
data:    .word     0 : 65536     # matrix of words
         
         
