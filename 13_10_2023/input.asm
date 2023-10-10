.include "macrolib.s"

.global input

.data
input_msg: .asciz "Enter count of input numbers (from 1 to 10) and then enter the numbers\n"
too_many_numbers_msg: .asciz "You can't enter this count of numbers\n"

.text
# ���������: a0 - ������ �������
# ����������: a0 - size �������
input:
mv t1 a0 # ���������� � t1 ������ �������
la a0 input_msg # ������ ������ ������� ������
li a7 4
ecall
li a7 5 # ������ size
ecall
mv t0 a0 # ���������� size � t0
blez t0 too_many_numbers_exception
li t5 10 # ��������� ��� ���������
bgt t0 t5 too_many_numbers_exception
li t2 0 # ������� �����
loop_1:
read_int a0
sw a0 (t1)
addi t1 t1 4
addi t2 t2 1
blt t2 t0 loop_1
mv a0 t0
ret

too_many_numbers_exception:
li a7 4 # ������� ��������� � ���, ��� ����� �������� count
la a0 too_many_numbers_msg
ecall
li a7 10 # ��������� ���������
ecall
