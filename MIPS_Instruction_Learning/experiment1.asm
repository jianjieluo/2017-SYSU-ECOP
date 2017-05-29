.data
  # string buffer
  buffer: .space 60
  newstring: .space 60

  # Tips messages
  inputmessage: .asciiz "Please input your password!\n"
  repeatmessage: .asciiz "Please input your password again!\n"
  cpright: .asciiz "Password Right!\n"
  cpwrong: .asciiz "Password Error!\n"

  # report messages
  spaceReport: .asciiz "The number of space in the string is:\n"
  alphaReport: .asciiz "The number of alpha in the string is:\n"
  numberReport: .asciiz "The number of number in the string is:\n"
  lenReport: .asciiz "The total length of the original string is:\n"
  newline: .asciiz "\n"

  # debug messages
  inloop: .asciiz "get into the loop\n"
  inSpace: .asciiz "in isSpace\n"
  inCountSpace: .asciiz "in countSpace\n"
  inAlpha: .asciiz "in isAlpha\n"
  inNumebr: .asciiz "in isNumber\n"
  inprintans: .asciiz "in printAns\n"
  beforeaddone: .asciiz "before add one in the loop"

.text
.globl main

main:
  li $v0 4
  la $a0 inputmessage
  syscall

  li $v0 8
  la $a0 buffer
  li $a1 60
  syscall

  # initialize the counter
  # $s5 records the number of space
  # $s6 records the number of numbers
  # $s7 records the number of alpha
  # $s1 contains the original string
  la $s1, buffer
  move $s5, $zero
  move $s6, $zero
  move $s7, $zero
  jal loop


# $s2 contains the current judge char, '\n':0xa is the end of the string
  loop:
    lb $s2, 0($s1)

    jal isSpace
    jal isAlpha
    jal isNumber

    addi $s1, $s1, 1
    bne $s2, 0xa, loop

  move $ra, $zero  # when there is no such a phase, when it comes to line59, the $ra will come to end

  jal printStatics
  jal backwardprint

  li $v0, 4
  la $a0, newline
  syscall

  j comparepasswd

backwardprint:
  # use $t7 as the temp backford pointer of the string
  # use $t6 as the counter
  move $t6, $zero
  la $t7, buffer

  aloop:
    addi $t7, $t7, 1
    addi $t6, $t6, 1
    bne $t6, $s4, aloop

  move $t6, $zero
  backloop:
    addi $t7, $t7, -1
    addi $t6, $t6, 1

    lb $t5, 0($t7)

    beq $t5, 0x20, backloop

    # print the char
    li $v0, 11
    la $a0, 0($t5)
    syscall

    bne $t6, $s4, backloop
  jr $ra

isSpace:
  beq $s2, 0x20, countSpace
  jr $ra

countSpace:
  li $v0 4
  la $a0, inCountSpace
  syscall
  addi $s5, $s5, 1
  jr $ra

isAlpha:
  # within a-z range
  sltiu $t0, $s2, 0x61  # lt 'a'?
  sltiu $t1, $s2, 0x7B  # lt 'z' + 1?
  xor $t2, $t0, $t1   # in range a-z ?

  # within A-Z range
  sltiu   $t3, $s2, 0x41  # lt 'A'?
  sltiu   $t4, $s2, 0x5C  # lt 'Z' + 1?
  xor     $t5, $t3, $t4  # in range A-Z?

  or $t6, $t2, $t5  # judge if it is an alpha
  add $s7, $s7, $t6

  jr $ra

isNumber:
  sltiu $t0, $s2, 0x30  # lt '0'?
  sltiu $t1, $s2, 0x3A  # lt '9' + 1?
  xor $t2, $t0, $t1 # in range 0-9?

  add $s6, $s6, $t2

  jr $ra

printStatics:
  li $v0, 4
  la $a0, spaceReport
  syscall
  li    $v0, 1
  la    $a0, 0($s5)
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  li $v0, 4
  la $a0, alphaReport
  syscall
  li    $v0, 1
  la    $a0, 0($s7)
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  li $v0, 4
  la $a0, numberReport
  syscall
  li    $v0, 1
  la    $a0, 0($s6)
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  # calculate the total length of the original string and store in $t0
  # $s4 store the total length of the original string
  move $s4, $zero
  add $s4, $s5, $s6
  add $s4, $s4, $s7
  # print the total length
  li $v0, 4
  la $a0, lenReport
  syscall
  li    $v0, 1
  la    $a0, 0($s4)
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  jr $ra


end:
  li $v0, 10
  syscall

comparepasswd:
  li $v0, 4
  la $a0, repeatmessage
  syscall

  li $v0, 8
  la $a0, newstring
  la $a1, 60
  syscall

  # $s0 has the newstring
  # $s1 has the oldstring
  la $s0, newstring
  la $s1, buffer

  move $t6, $zero
  # $s3 contains the length of oldstring without spaces
  add $s3, $s6, $s7

  cloop:
    lb $t0, 0($s0)

    oldstringGetNoSpaceLoop:
      lb $t1, 0($s1)
      bne $t1, 0x20, continue
      addi $s1, $s1, 1
      j oldstringGetNoSpaceLoop
    continue:
      bne $t0, $t1, cmpwrong
      beq $t0, 0xa, isSubstring
      # if newstring not to the end yet, oldstring to, then it is wrong
      beq $t1, 0xa, cmpwrong

      addi $s0, $s0, 1
      addi $s1, $s1, 1
      addi $t6, $t6, 1

      j cloop

isSubstring:
  # use the true length of two strings to judge whether it is a substring
  beq $s3, $t6, cmpright
  j cmpwrong

cmpwrong:
  li $v0, 4
  la $a0, cpwrong
  syscall
  j end

cmpright:
  li $v0, 4
  la $a0, cpright
  syscall
  j end
