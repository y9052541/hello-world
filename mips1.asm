# author: Zhaohui Ye

	.data
zero: .asciiz"\nzero\n"
one: .asciiz"\nFirst\n"
two: .asciiz"\nSecond\n"
three: .asciiz"\nThird\n"
four: .asciiz"\nFourth\n"
five: .asciiz"\nFifth\n"
six: .asciiz"\nSixth\n"
seven: .asciiz"\nSeventh\n"
eight: .asciiz"\nEighth\n"
nine: .asciiz"\nNinth\n"
AA: .asciiz"\nAlpha\n"
BB: .asciiz"\nBravo\n"
CC: .asciiz"\nChina\n"
DD: .asciiz"\nDelta\n"
EE: .asciiz"\nEcho\n"
FF: .asciiz"\nFoxtrot\n"
GG: .asciiz"\nGolf\n"
HH: .asciiz"\nHotel\n"
II: .asciiz"\nIndia\n"
JJ: .asciiz"\nJuliet\n"
KK: .asciiz"\nKilo\n"
LLL: .asciiz"\nLima\n"
MM: .asciiz"\nMary\n"
NN: .asciiz"\nNovember\n"
OO: .asciiz"\nOscar\n"
PP: .asciiz"\nPaper\n"
QQ: .asciiz"\nQuebec\n"
RR: .asciiz"\nResearch\n"
SS: .asciiz"\nSierra\n"
TT: .asciiz"\nTango\n"
UU: .asciiz"\nUniform\n"
VV: .asciiz"\nVictor\n"
WW: .asciiz"\nWhisky\n"
XX: .asciiz"\nX-ray\n"
YY: .asciiz"\nYankee\n"
ZZ: .asciiz"\nZulu\n"
aa: .asciiz"\nalpha\n"
bb: .asciiz"\nbravo\n"
cc: .asciiz"\nchina\n"
dd: .asciiz"\ndelta\n"
ee: .asciiz"\necho\n"
ff: .asciiz"\nfoxtrot\n"
gg: .asciiz"\ngolf\n"
hh: .asciiz"\nhotel\n"
ii: .asciiz"\nindia\n"
jj: .asciiz"\njuliet\n"
kk: .asciiz"\nkilo\n"
lll: .asciiz"\nlima\n"
mm: .asciiz"\nmary\n"
nn: .asciiz"\nnovember\n"
oo: .asciiz"\noscar\n"
pp: .asciiz"\npaper\n"
qq: .asciiz"\nquebec\n"
rr: .asciiz"\nresearch\n"
ss: .asciiz"\nsierra\n"
tt: .asciiz"\ntango\n"
uu: .asciiz"\nuniform\n"
vv: .asciiz"\nvictor\n"
ww: .asciiz"\nwhisky\n"
xx: .asciiz"\nx-ray\n"
yy: .asciiz"\nyankee\n"
zz: .asciiz"\nzulu\n"
cant_find: .asciiz"\n*\n"

alpha_lower_dict: .word aa, bb, cc, dd, ee, ff, gg, hh, ii, jj, kk, lll, mm, nn, oo, pp, qq, rr, ss, tt, uu, vv, ww, xx, yy, zz
alpha_capital_dict: .word AA, BB, CC, DD, EE, FF, GG, HH, II, JJ, KK, LLL, MM, NN, OO, PP, QQ, RR, SS, TT, UU, VV, WW, XX, YY, ZZ
number_dict: .word zero, one, two, three, four, five, six, seven, eight, nine

	.text

main:

# 读入数据
read_input:
	li $v0, 12
	syscall
	move $t0, $v0

# 处理 char，搞清楚是属于那类的输入
character_handler:
	# $t0 == '?'
	beq $t0, '?' terminate_case
	
	# '0' <= $t0 <= '9'
	blt $t0, '0', cant_match_case
	ble $t0, '9', number_handler
	
	# 'A' <= $t0 <= 'Z'
	blt $t0, 'A', cant_match_case
	ble $t0, 'Z', alpha_captial_handler
	
	# 'a' <= $t0 <='z'
	blt $t0, 'a', cant_match_case
	ble $t0, 'z', alpha_lower_handler

# 找不到匹配需要输出'*'的
cant_match_case:
	li $v0, 4
	la $a0, cant_find
	syscall
	j read_input

# 是数字的情况
number_handler:
	li $v0, 4
	sub $t0, $t0, '0'
	mul $t0, $t0, 4
	lw $a0, number_dict($t0)
	syscall
	j read_input
	
# 是大写字母的情况
alpha_captial_handler:
	li $v0, 4
	sub $t0, $t0, 'A'
	mul $t0, $t0, 4
	lw $a0, alpha_capital_dict($t0)
	syscall
	j read_input

# 是小写字母的情况
alpha_lower_handler:
	li $v0, 4
	sub $t0, $t0, 'a'
	mul $t0, $t0, 4
	lw $a0, alpha_lower_dict($t0)
	syscall
	j read_input

# 输入了 '?' 程序结束
terminate_case:
