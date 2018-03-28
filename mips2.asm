	.data
success_output: .asciiz "\nSuccess! Location: "
fail_output: .asciiz "\nFail!\n"
buf: .space 1000

	.text
main:

# 读入字符串（串长度 < 1000）
read_string:
	li $v0, 8
	la $a0, buf
	li $a1, 1000
	syscall
	
# 读入字符
read_char:
	li $v0, 12
	syscall
	move $t0, $v0
	
	beq $t0, '?', terminate_case
	
# 在读入的字符串中寻找对应的字符
handler:
	li $t1, 0
	loop:
	lb $t2, buf($t1)
	addi $t1, $t1, 1
	beq $t2, 0, fail_case
	beq $t2, '\n', fail_case
	beq $t2, $t0, success_case
	#beq $t1, $a1, fail_case
	j loop
	
# 找到字符的位置并输出
success_case:
	li $v0, 4
	la $a0, success_output
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	j read_char

# 在字符串中没有找到该字符
fail_case:
	li $v0, 4
	la $a0, fail_output
	syscall
	
	j read_char

# 用户键入 '?' 输入结束
terminate_case:
	
