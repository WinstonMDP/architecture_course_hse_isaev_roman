.include "macrolib.s"

.global input

.data
input_msg: .asciz "Enter count of input numbers (from 1 to 10) and then enter the numbers\n"
too_many_numbers_msg: .asciz "You can't enter this count of numbers\n"

.text
# принимает: a0 - начало массива
# возвращает: a0 - size массива
input:
mv t1 a0 # запоминаем в t1 начало массива
la a0 input_msg # просим ввести входные данные
li a7 4
ecall
li a7 5 # вводим size
ecall
mv t0 a0 # запоминаем size в t0
blez t0 too_many_numbers_exception
li t5 10 # константа для сравнения
bgt t0 t5 too_many_numbers_exception
li t2 0 # счётчик цикла
loop_1:
read_int a0
sw a0 (t1)
addi t1 t1 4
addi t2 t2 1
blt t2 t0 loop_1
mv a0 t0
ret

too_many_numbers_exception:
li a7 4 # выводим сообщение о том, что введён неверный count
la a0 too_many_numbers_msg
ecall
li a7 10 # завершаем программу
ecall
