.global a_to_b

.text
# arguments: a0 - begin of an array_a, a1 - begin of a array_b, a2 - size of the arrays
# return: nothing
a_to_b:
addi sp sp -4 # save values
sw a0 (sp)
addi sp sp -4
sw a1 (sp)
addi sp sp -4
sw ra (sp)
mv a1 a2 # set size of the arrays to a1
jal sums
mv t0 a0
mv t1 a1
lw ra (sp) # restore values
addi sp sp 4
lw a1 (sp)
addi sp sp 4
lw a0 (sp)
addi sp sp 4
li t2 0 # a loop counter
li t3 2 # a constant for rem
loop_2:
rem t4 t2 t3
beqz t4 even
sw t1 (a1)
j if_end_2
even:
sw t0 (a1)
if_end_2:
addi t2 t2 1
addi a1 a1 4
blt t2 a2 loop_2
ret

# arguments: a0 - begin of an array, a1 - size of the array
# return: a0 - sum of the positive numbers, a1 - sum of the negative numbers
sums:
li t0 0 # loop counter
li t1 0 # sum of the positive numbers
li t2 0 # sum of the negative numbers
loop_1:
lw t3 (a0)
bgtz t3 if_positive_number
add t2 t2 t3
j if_end_1
if_positive_number:
add t1 t1 t3
if_end_1:
addi a0 a0 4
addi t0 t0 1
blt t0 a1 loop_1
mv a0 t1
mv a1 t2
ret
