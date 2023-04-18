	.data
menuPrompt:       .asciiz "Chose one of the following(Type 1-4):\n1. Binary to hexadecimal and decimal\n2. Hexadecimal to binary and decimal\n3. Decimal to binary and hexadecimal\n4. Exit\n"
numPrompt1:       .asciiz "Enter a valid binary number to be converted(Only digits 0 and 1 are aloud):\n"
numPrompt2:       .asciiz "Enter a valid hexadecimal number to be converted(Only digits [0,9], [A-F], and [a-f] are aloud):\n"
numPrompt3:       .asciiz "Enter a valid decimal number to be conveted(Only digits [0,9] are aloud):\n"
binDisplay:       .asciiz "Binary number: "
decDisplay:       .asciiz "Decimal number: "
hexDisplay:       .asciiz "Hexadecimal number: "
invalidChoice:    .asciiz "The menu option you chose is invalid, please try again.\n"
invalidBinNum:	  .asciiz "The binary number you entered is invalid, please try again. \n"
invalidDecNum:	  .asciiz "The decimal number you entered is invalid, please try again. \n"
invalidHexNum:	  .asciiz "The hexadecimal number you entered is invalid, please try again. \n"
maxHexDigits:	  .asciiz "The hexadecimal number you entered contains more then 8 digits(32 bits). Please try again.\n"
maxBinDigits:	  .asciiz "The binary number you entered contains more then 32 bits. Please try again.\n"
newLine:          .asciiz "\n"
inputNum:         .space 100
menuChoice:	  .word 0
	.text
main:
  	lw $t0, menuChoice
  	beq $t0, 4, exit
  	#Loop Code:
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, menuPrompt
  	syscall
  	li $v0, 5
  	syscall
  	move $t0, $v0
  	sw $t0, menuChoice
  	beq $t0, 1, num1
  	beq $t0, 2, num2
  	beq $t0, 3, num3
  	beq $t0, 4, num4
  	#If entered number is not 1-4:
  	li $v0, 4
  	la $a0, invalidChoice
  	syscall
  	j main 	
  num1:
  	jal binToHexAndDec
  	j continue
  num2:
  	jal hexToBinAndDec
  	j continue
  num3:
  	jal decToBinAndHex
  	j continue
  num4:
  	jal exit
  continue:
  	j main

#When user types 1, this function will run. Inputed num will be stored in "inputNum" label
binToHexAndDec:
  validLoop1:
	li $v0, 4
	la $a0, numPrompt1
	syscall
	li $v0, 8
	la $a0, inputNum
	li $a1, 100
	syscall
	#Check if valid:
	la $s0, inputNum
	li $t0, 0 #Keeps track of how many bits. If > 32, => invalid number
  checkLoop1:
  	lb $s1, 0($s0)
  	bgt $t0, 32, maxDigits1
  	beq $s1, 0x0A, isValid1 #Since the final byte of input will be enter, if loop reaches this byte => input is valid
  	beq $s1, 0x30, continue1
  	beq $s1, 0x31, continue1
  	j notValid1
  continue1: 
  	addi $t0, $t0, 1
  	addi $s0, $s0, 1
  	j checkLoop1
  isValid1:
  	#Convert to actual binary number.
  	la $s0, inputNum
  	li $s1, 0
  convertLoop1:
  	lb $s2, 0($s0)
  	beq $s2, 0x0A return1
  	sll $s1, $s1, 1
  	addi $s2, $s2, -48
  	or $s1, $s1, $s2
  	addi $s0, $s0, 1
  	j convertLoop1	
  notValid1:
  	li $v0, 4
  	la $a0, invalidBinNum
  	syscall
  	j validLoop1	
  maxDigits1:
  	li $v0, 4
  	la $a0, maxBinDigits
  	syscall
  	j validLoop1	
  return1:
  	li $v0, 4
  	la $a0, binDisplay
  	syscall
  	li $v0, 35
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, hexDisplay
  	syscall
  	li $v0, 34
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, decDisplay
  	syscall
  	li $v0, 1
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
	jr $ra
	
#When user types 2, this function will run. Inputed num will be stored in "inputNum" label
hexToBinAndDec:
  validLoop2:
	li $v0, 4
	la $a0, numPrompt2
	syscall
	li $v0, 8
	la $a0, inputNum
	li $a1, 100
	syscall
	#Check if valid:
	la $s0, inputNum
	li $t0, 0 #Keeps track of how many hexadecimal digits. If > 8, => invalid number
  checkLoop2:
  	lb $s1, 0($s0)
  	bgt $t0, 8, maxDigits2
  	beq $s1, 0x0A, isValid2
  	#Check if 0-9
  	sge $s2, $s1, 0x30
  	sle $s3, $s1, 0x39
  	add $s4, $s2, $s3
  	beq $s4, 2, continueCheckLoop2
  	#Check if A-F
  	sge $s2, $s1, 0x41
  	sle $s3, $s1, 0x46
  	add $s4, $s2, $s3
  	beq $s4, 2, continueCheckLoop2
  	#Check if a-f
  	sge $s2, $s1, 0x61
  	sle $s3, $s1, 0x66
  	add $s4, $s2, $s3
  	beq $s4, 2, continueCheckLoop2
  	j notValid2
  continueCheckLoop2:
  	addi $t0, $t0, 1
  	addi $s0, $s0, 1
  	j checkLoop2
  isValid2:
  	#At this point, $s0 holds address of last digit in inputted number, since we just looped through each digit in string previously
  	#Since last byte in string is enter, subtract 1 to get the actual last digit of inputted number.
  	#Now, $s0 holds value of last digit of inputted number. We now will loop through string in reverse order.
  	#Convert to actual hexadecimal number.
  	addi $s0, $s0, -1 
  	li $s1, 0
  	li $s2, 1
  convertLoop2:
  	lb $s3, ($s0)
  	beqz $s3, return2
  	#Check if 0-9
  	sge $s4, $s3, 0x30
  	sle $s5, $s3, 0x39
  	add $s5, $s4, $s5
  	beq $s5, 2, convertDigit
  	#Check if A-F
  	sge $s4, $s3, 0x41
  	sle $s5, $s3, 0x46
  	add $s5, $s4, $s5
  	beq $s5, 2, convertUpHex
  	#If not 0-9 or A-F, => a-f
  	j convertLowHex	
  convertDigit:
  	addi $s3, $s3,-48
  	j continueConvertLoop2
  convertUpHex:
  	addi $s3, $s3, -55
  	j continueConvertLoop2
  convertLowHex:
  	addi $s3, $s3, -87
  continueConvertLoop2:
  	mul $s3, $s3, $s2
  	add $s1, $s1, $s3
  	mul $s2, $s2, 16
  	addi $s0, $s0, -1
  	j convertLoop2
  notValid2:
  	li $v0, 4
  	la $a0, invalidHexNum
  	syscall
  	j validLoop2	
  maxDigits2:
  	li $v0, 4
  	la $a0, maxHexDigits
  	syscall 
  	j validLoop2		
  return2:
  	li $v0, 4
  	la $a0, hexDisplay
  	syscall
  	li $v0, 34
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, binDisplay
  	syscall
  	li $v0, 35
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, decDisplay
  	syscall
  	li $v0, 1
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
	jr $ra
	
#When user types 3, this function will run. Inputed num will be stored in "inputNum" label
decToBinAndHex:
  validLoop3:
	li $v0, 4
	la $a0, numPrompt3
	syscall
	li $v0, 8
	la $a0, inputNum
	li $a1, 100
	syscall
	#Check if valid:
	#$t0 holds value of 1 to start with. If first digit in inputted string is negative symbol, $t1 is changed to -1
	#The final converted decimal number will be multiplied by $t1.
	li $t0, 1
	la $s0, inputNum
	li $s1, 0x30
	li $s2, 0x39
	lb $s3, 0($s0)
	beq $s3, 0x0A, isValid3
	beq $s3, 0x2D  isNegative
	addi $s0, $s0, 1
  checkLoop3:
  	lb $s3, 0($s0)
  	beq $s3, 0x0A, isValid3   #Since the final byte of input will be enter, if loop reaches this byte => input is valid
  	sge $s4, $s3, $s1
  	beq $s4, $0, notValid3 
  	sle $s4, $s3, $s2
  	beq $s4, $0, notValid3
  	addi $s0, $s0, 1
  	j checkLoop3	
  isNegative: #If decimal number is negative, store -1 in $t0. Then, the number will be multiplied by -1 after converting
  	li $t0, -1
  	addi $s0, $s0, 1
  	j checkLoop3	
  isValid3:
  	#At this point, $s0 holds address of last digit in inputted number, since we just looped through each digit in string previously
  	#Since last byte in string is enter, subtract 1 to get the actual last digit of inputted number.
  	#Now, $s0 holds value of last digit of inputted number. We now will loop through string in reverse order.
  	#Convert to actual decimal number.
  	addi $s0, $s0, -1 
  	li $s1, 0
  	li $s2, 1
  convertLoop3:
  	lb $s3, ($s0)
  	beqz $s3, return3
  	beq $s3, 0x2d, return3
  	addi $s3, $s3, -48
  	mul $s3, $s3, $s2
  	add $s1, $s1, $s3
  	mul $s2, $s2, 10
  	addi $s0, $s0, -1
  	j convertLoop3
  notValid3:
  	li $v0, 4
  	la $a0, invalidDecNum
  	syscall
  	j validLoop3 			
  return3:
  	mul $s1, $s1, $t0
  	li $v0, 4
  	la $a0, decDisplay
  	syscall
  	li $v0, 1
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, binDisplay
  	syscall
  	li $v0, 35
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
  	li $v0, 4
  	la $a0, hexDisplay
  	syscall
  	li $v0, 34
  	move $a0, $s1
  	syscall
  	li $v0, 4
  	la $a0, newLine
  	syscall
	jr $ra
	
#When user types 1, this function will run
exit:
	li $v0, 10
	syscall
