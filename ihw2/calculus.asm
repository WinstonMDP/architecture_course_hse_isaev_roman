.global calculus

.data
zero_c: .double 0
one: .double 1
epsilon: .double 0.0001

.text
# arguments: a0 - x
# return: fa0 - e^x
calculus:
fld ft0 one t0 # result
fld ft1 one t0 # previous result
fld ft2 one t0 # element of sequence
fld ft3 one t0 # difference betwenn result and previous result
fld ft4 epsilon t0
fld ft5 one t0 # 1 / n!
fld ft6 zero_c t0 # n
fld ft7 one t0 # constant 1
fld ft8 one t0 # x^n
fcvt.d.w ft9 a0 # x
loop:
fmul.d ft8 ft8 ft9 # x^n = x^{n-1} * x
fadd.d ft6 ft6 ft7 # ++n
fdiv.d ft5 ft5 ft6 # 1 / n! = (1 / (n - 1)!)(1 / n)
fmv.d ft2 ft5 # 1 / n!
fmul.d ft2 ft2 ft8 # x^n / n!
fadd.d ft0 ft0 ft2 # sum of sequence
fneg.d ft1 ft1 # previous = -previous
fadd.d ft3 ft0 ft1 # difference = sum of sequence - previous
fmv.d ft1 ft0 # previous = current
flt.d t0 ft3 ft4
beqz t0 loop
fmv.d fa0 ft0 # move result to fa0
ret
