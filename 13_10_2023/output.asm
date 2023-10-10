.include "macrolib.s"

.global output

.text
output:
# принимает: a0 - число
# возвращает: ничего
print_int a0 # выводим сумму
ret

output_array:
mv t0 a0 # запоминаем в t0 начало массива
li t1 0 # счётчик цикла
mv t2 a1 # запоминаем в t2 size
loop_2:
lw a0 (t0)
li a7 1 # выводим очередное число массива
ecall
li a7 11 # ставим пробел
li a0 ' '
ecall
addi t0 t0 4
addi t1 t1 1
blt t1 t2 loop_2
ret
