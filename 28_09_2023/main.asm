.data
input_msg: .asciz "Enter count of input numbers (from 1 to 10) and then enter the numbers\n"
too_many_numbers_msg: .asciz "You can't enter this count of numbers\n"
overflow_exception_msg: .asciz "Overflow exception. Count of input numbers (without the last) and sum (without the last):\n"
.align 2
array: .space 64
array_end:

.text
la t0 array
la t1 array_end
li a7 4
la a0 input_msg
ecall
li a7 5
ecall
mv t2 a0
li t3 10
blez t2 too_many_numbers_exception
bgt t2 t3 too_many_numbers_exception
li t3 0
li t5 0
loop:
li a7 5
ecall
mv t4 a0

# Ѕудем разбирать 4 случа€ дл€ проверки переполнени€: >0>0 >0<0 <0>0 <0<0
bgtz t3 sum_is_bgtz
bgtz t4 input_is_bgtz
add t6 t3 t4
bgt t6 t3 overflow_exception
input_is_bgtz:
j sum_is_bgtz_end
sum_is_bgtz:
bltz t4 input_is_bltz
add t6 t3 t4
blt t6 t3 overflow_exception
input_is_bltz:
sum_is_bgtz_end:

add t3 t3 t4
addi t5 t5 1
bne t2 t5 loop
li a7 1
mv a0 t3
ecall
li a7 10
ecall

too_many_numbers_exception:
li a7 4
la a0 too_many_numbers_msg
ecall
li a7 10
ecall

overflow_exception:
li a7 4
la a0 overflow_exception_msg
ecall
li a7 1
mv a0 t5
ecall
li a7 11
li a0 ' '
ecall
li a7 1
mv a0 t3
ecall
li a7 10
ecall