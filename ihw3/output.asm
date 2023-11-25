.global output

.text
# arguments: a0 - a file descriptor, a1 - output string, a2 - the length to write
output:
li a7 64
ecall
ret