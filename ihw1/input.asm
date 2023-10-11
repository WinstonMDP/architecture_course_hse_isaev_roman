.global input

.data
input_msg: .asciz "Enter count of input numbers (from 1 to 10) and then enter the numbers\n"
too_many_numbers_msg: .asciz "You can't enter this count of numbers\n"

.text
# arguments: a0 - begin of an array
# return: a0 - size of the array
input:
addi sp sp -4
sw ra (sp)
mv t0 a0
la a0 input_msg # ask to enter size of the array
li a7 4
ecall
li a7 5 # enter size of the array
ecall
mv t1 a0 # set the size to t1
blez t1 too_many_numbers_exception
li t2 10 # a constant to compare
bgt t1 t2 too_many_numbers_exception
li t2 0 # a loop counter
loop:
li a7 5 # enter a next number
ecall
sw a0 (t0)
addi t0 t0 4
addi t2 t2 1
blt t2 t1 loop
mv a0 t1
lw ra (sp)
addi sp sp 4
ret

too_many_numbers_exception:
li a7 4 # print exception message
la a0 too_many_numbers_msg
ecall
li a7 10 # terminate
ecall
