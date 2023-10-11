.global output

.text
# arguments: a0 - begin of an array, a1 - size of the array
# return: nothing
output:
addi sp sp -4
sw ra (sp)
mv t0 a0
li t1 0 # a loop conter
loop:
lw a0 (t0)
li a7 1 # print a next number
ecall
li a7 11 # print space
li a0 ' '
ecall
addi t0 t0 4
addi t1 t1 1
blt t1 a1 loop
lw ra (sp)
addi sp sp 4
ret
