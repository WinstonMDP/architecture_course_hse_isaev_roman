.global main

.data
.align 2
array_a: .space 40
array_a_end:
array_b: .space 40
array_b_end:

.text
main:
la a0 array_a
jal input
mv a2 a0
la a0 array_a
la a1 array_b
mv s0 a2
jal a_to_b
la a0 array_b
mv a1 s0
jal output
li a7 10 # terminate
ecall