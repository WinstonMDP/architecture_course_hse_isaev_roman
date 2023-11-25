.global process

.text
# arguments:
#     a0 - accumulator (null terminated string),
#     a1 - string to process,
#     a2 - size of a1 string,
#     a3 - mode (modes: 1 - string before, 0 - string after),
#     a4 - intersection string
# Intersection of string before '\n' and one after. 
process:
li t0 0 # counter
li t4 '\n'
beqz a3 after # check mode
loop:
lb t1 (a1) # take symbol of process string
li a3 0
beq t1 t4 after # check symbol = '\n'
li a3 1
mv t3 a0 # accumulator
loop_1:
lb t2 (t3)
addi t3 t3 1
beq t1 t2 end_1
bnez t2 loop_1
push_new_char: # push character to the string of unique characters before '\n' (accumulator)
addi t3 t3 -1
sb t1 (t3)
addi t3 t3 1
sb zero (t3)
end_1:
addi t0 t0 1
addi a1 a1 1
beq t0 a2 return
b loop
after:
addi t0 t0 1
addi a1 a1 1
loop_after:
lb t1 (a1)
mv t3 a0 # accumulator
loop_after_1:
lb t2 (t3)
addi t3 t3 1
beq t1 t2 push_new_char_after
beqz t2 end_after_1
b loop_after_1
# push char from the after '\n' part of process string to the intersection string,
# if it is in the accumulator and not in the intersection string
push_new_char_after:
mv t5 a4 # intersection string
loop_2:
lb t6 (t5)
addi t5 t5 1
beq t6 t1 end_after_1
bnez t6 loop_2
addi t5 t5 -1
sb t1 (t5)
addi t5 t5 1
sb zero (t5)
end_after_1:
addi t0 t0 1
addi a1 a1 1
blt t0 a2 loop_after
return:
ret
