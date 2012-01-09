####################################################################
# Count the number of characters (letters, numbers, etc) on a frase, excluding end of line
# (ASM MIPS)
#
# Laudin Alessandro Molina
# 2012-01-08
####################################################################

.data
frase:  .asciiz "123456789012345678901234567890"
letters: .byte 0
i:      .byte 0
msg1:   .asciiz "Enter a new text: "
msg2:   .asciiz "The frase: "
msg3:   .asciiz " have "
msg4:   .asciiz " letters"

.text
.globl main

main:
  # Print the message: "Enter a new text: "
  la $a0, msg1            # syscall parameter
  li $v0, 4               # print
  syscall

  # Read a string and save on the frase address.
  li $v0, 8               # read a string
  li $a1, 29              # how many characters shall we read?
  la $a0, frase           # where to save the string?
  syscall

  lb $t2, i($zero)   		# Load i on the register t2
  add $t2, $zero, $zero	# i = 0
  lb $t1, letters($zero)		# Load letras on the register t1
  add $t1, $zero, $zero	# clear letters
  addi $t5, $zero, '\n'        # $t5 = \n

loop:
  lb $t3, frase($t2)		# t3 = frase[i]
  beqz $t3, Exit			# if $t3 = 0, it means, end of string.
  beq $t3, $t5, Exit		# if $t3 = \n, it means, end of line
  addi $t2, $t2, 1
  j loop

Exit:
# Print messages
  la $a0, msg2
  li $v0, 4
  syscall
  la $a0, frase
  li $v0, 4
  syscall
  la $a0, msg3
  li $v0, 4
  syscall
  move $a0, $t2
  li $v0, 1
  syscall
  la $a0, msg4
  li $v0, 4
  syscall

# Exit
  li $v0, 10
  syscall
