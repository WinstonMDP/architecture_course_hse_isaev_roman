.global strcpy

.text
# arguments: a0 - destination string, a1 - source string
# return: a0 - destination string
strcpy:
mv t1 a0 # save begin of the destination string
loop:
lb t0 (a1)
beqz t0 loop_end
sb t0 (a0)
addi a0 a0 1
addi a1 a1 1
b loop
loop_end:
mv a0 t1
ret
