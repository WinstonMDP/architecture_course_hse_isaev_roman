.eqv FILE_BUFFER_SIZE 512

.data
file_buffer: .space FILE_BUFFER_SIZE
output_string: .space FILE_BUFFER_SIZE
accumulator: .space FILE_BUFFER_SIZE

.text
main:
jal input
mv s0 a0
mv s1 a1
li s2 1 # the before mode for process
sb zero accumulator t6
sb zero output_string t6
loop:
li a7 63
mv a0 s0
la a1 file_buffer
li a2 FILE_BUFFER_SIZE
ecall # read from input_file_name file
mv a2 a0 # size of read
la a0 accumulator
la a1 file_buffer
mv a3 s2 # mode
la a4 output_string
jal process
mv s2 a3 # save the mode
li t0 FILE_BUFFER_SIZE
beq a2 t0 loop
end:
mv a0 s1
la a1 output_string
li a2 FILE_BUFFER_SIZE
jal output
li a7 10
ecall
