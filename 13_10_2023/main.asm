.include "macrolib.s"

.global main

.data
.align 2
array: .space 40
array_end:

.text
main:
la a0 array
jal input
mv s0 a0
mv a1 s0
la a0 array
jal sum
jal output
li a7 10 # завершаем программу
ecall
