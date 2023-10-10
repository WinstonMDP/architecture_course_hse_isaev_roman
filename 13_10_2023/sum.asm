.global sum

.data
overflow_exception_msg: .asciz "Overflow exception. Count of well summed numbers and well sum:\n"

.text
sum:
# ���������: a0 - ������ �������, a1 - size �������
# ����������: a0 - ����� �������
mv t0 a0 # ���������� � t0 ������ �������
li t1 0 # ������� �����
mv t2 a1 # ���������� � t2 size
li t3 0
li t5 0
loop_3:
lw t4 (t0)

# ����� ��������� 4 ������ ��� �������� ������������: >0>0 >0<0 <0>0 <0<0
bgtz t3 sum_is_bgtz
bgtz t4 input_is_bgtz
add t6 t3 t4
mv a0 t1
bgt t6 t3 overflow_exception
input_is_bgtz:
j sum_is_bgtz_end
sum_is_bgtz:
bltz t4 input_is_bltz
add t6 t3 t4
mv a0 t1
blt t6 t3 overflow_exception
input_is_bltz:
sum_is_bgtz_end:

add t3 t3 t4
addi t0 t0 4
addi t1 t1 1
blt t1 t2 loop_3
mv a0 t3
ret

overflow_exception:
mv t5 a0
li a7 4 # ������� ��������� ����������
la a0 overflow_exception_msg
ecall
li a7 1 # ������� ��������� ����� � ����� ���������������� ���������
mv a0 t5
ecall
li a7 11
li a0 ' '
ecall
li a7 1
mv a0 t3
ecall
li a7 10 # ��������� ���������
ecall
