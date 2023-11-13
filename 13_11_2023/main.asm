.global main

.data
.eqv STR1_SIZE 40
.eqv STR2_SIZE 40
str1: .space STR1_SIZE
str2: .space STR2_SIZE
str3: .asciz "hey"

.text
main:
la a0 str1
li a1 STR1_SIZE
li a7 8
ecall
# li a7 8
# la a0 str2
# li a1 STR2_SIZE
# ecall
la a0 str1
la a1 str3
jal strcpy
li a7 4
ecall
li a7 10
ecall
