.global main

.data
.align 2
array_a: .space 40
array_a_end:
array_b: .space 40
array_b_end:

.text
main:
la a0 array_a # set begin of the a array to a0
jal input
mv a2 a0 # set size of the arrays to a2
la a0 array_a # set begin of the array_a to a0
la a1 array_b # set begin of the array_b to a1
mv s0 a2
jal a_to_b
la a0 array_b # set begin of the array_b to a0
mv a1 s0 # set size of arrays to a1
jal output
li a7 10 # terminate
ecall
