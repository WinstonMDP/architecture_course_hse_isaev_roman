.include "macrolib.s"

.global output

.text
output:
# ���������: a0 - �����
# ����������: ������
print_int a0 # ������� �����
ret

output_array:
mv t0 a0 # ���������� � t0 ������ �������
li t1 0 # ������� �����
mv t2 a1 # ���������� � t2 size
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
