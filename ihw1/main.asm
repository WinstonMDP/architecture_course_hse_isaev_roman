.data
input_msg: .asciz "Enter count of input numbers (from 1 to 10) and then enter the numbers\n"
too_many_numbers_msg: .asciz "You can't enter this count of numbers\n"
.align 2
array: .space 40
array_end:

.text
main:
jal input
mv t0 a0
jal output
li a7 10 # ��������� ���������
ecall

input:
la a0 input_msg # ������ ������ ������� ������
li a7 4
ecall
li a7 5 # ������ count
ecall
mv t0 a0 # ���������� count � t0
li t1 10 # ��������� ��� ���������
blez t0 too_many_numbers_exception
bgt t0 t1 too_many_numbers_exception
la t1 array
li t2 0 # ������� �����
loop_1:
li a7 5 # ������ ��������� ����� �������
ecall
sw a0 (t1)
addi t1 t1 4
addi t2 t2 1
blt t2 t0 loop_1
mv a0 t0
ret

output:
la t0 array
li t1 0 # ������� �����
mv t2 a0
loop_2:
lw a0 (t0)
li a7 1 # ������� ��������� ����� �������
ecall
li a7 11 # ������ ������
li a0 ' '
ecall
addi t0 t0 4
addi t1 t1 1
blt t1 t2 loop_2
ret


too_many_numbers_exception:
li a7 4 # ������� ��������� � ���, ��� ����� �������� count
la a0 too_many_numbers_msg
ecall
li a7 10 # ��������� ���������
ecall
