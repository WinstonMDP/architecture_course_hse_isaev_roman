.global input

.eqv FILE_NAME_SIZE 64

.data
input_file_name: .space FILE_NAME_SIZE
output_file_name: .space FILE_NAME_SIZE

.text
# return: a0 - input file descriptor, a1 - output file descriptor
input:
addi sp sp -4
sw ra (sp)
li a7 8
li a1 FILE_NAME_SIZE
la a0 input_file_name
ecall # input input_file_name
jal break_remove # remove '\n' in input_file_name
la a0 output_file_name 
ecall # input output_file_name
jal break_remove # remove '\n' in output_file_name
li a7 1024
la a0 input_file_name
li a1 0
ecall # open file_name_1 file read-only
mv t0 a0 # input_file_name file descriptor
la a0 output_file_name
li a1 1
ecall # open output_file_name file to write-only
mv a1 a0 # ouput_file_name file descriptor
mv a0 t0
lw ra (sp)
addi sp sp 4
ret