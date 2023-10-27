.global main

.text
main:
jal input # now a0 is x
jal calculus # now fa0 is result
jal output
li a7 10
ecall