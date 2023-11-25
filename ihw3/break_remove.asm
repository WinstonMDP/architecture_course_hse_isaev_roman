.global break_remove

.text
# arguments: a0 - string
break_remove:
li t0 '\n'
mv t1 a0
loop:
lb t2 (t1)
beq t0 t2 end
addi t1 t1 1
b loop
end:
sb zero (t1)
ret
