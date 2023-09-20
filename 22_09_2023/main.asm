.text
li a7 5
ecall
mv t0 a0
li a7 5
ecall
mv t1 a0
li t2 0
beqz t1 exception
li t3 0
bgtz t0 first_operand_is_positive
li t3 1
neg t0 t0
first_operand_is_positive:
li t4 0
bgtz t1 second_operand_is_positive
li t4 1
neg t1 t1
second_operand_is_positive:
blt t0 t1 loop_else

loop:
sub t0 t0 t1
addi t2 t2 1
ble t1 t0 loop

loop_else:
beqz t3 first_operand_is_positive_2
neg t0 t0
bnez t4 second_operand_is_negative
neg t2 t2
second_operand_is_negative:
first_operand_is_positive_2_end:
li a7 1
mv a0 t2
ecall
li a7 11
li a0 ' '
ecall
li a7 1
mv a0 t0
ecall
li a7 10
ecall

exception:
li a7 4
la a0 exception_message
ecall
li a7 10
ecall

first_operand_is_positive_2:
beqz t4 second_operand_is_positive_2
neg t2 t2
second_operand_is_positive_2:
j first_operand_is_positive_2_end

.data
exception_message: .asciz "division by zero is not defined"