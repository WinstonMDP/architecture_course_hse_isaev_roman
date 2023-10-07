.text

main:
jal fac
li a7 1
ecall
li a7 10
ecall

fac:
li t1 1
li t2 1
li t3 2147483647 # 2^31 - 1
mv t4 t3
loop:
addi t1 t1 1
mul t2 t2 t1
div t4 t3 t2
blt t4 t1 loop_end
j loop
loop_end:
mv a0 t1
ret