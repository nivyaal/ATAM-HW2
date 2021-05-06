.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
	#prologue
	pushq %rdi
	pushq %r8
	#check whats the opcode length
	movq 16(%rsp),%rax
	and $0XFF00,%rax
	cmp $0x0F00,%rax
	je len2
len1:
	movq $1, %r8
	jmp function
len2:
	movq $2, %r8
function:
#calling waht to do with last byte
	movq $0xFF,%rdi
	andq 16(%rsp), %rdi
	call what_to_do
	#cases accordance to function return val
	cmp $0, %eax
	jne case_not_zero
case_zero:
	popq %r8
	popq %rdi
	jmp old_ili_handler
case_not_zero:
	add %r8,16(%rsp)
	popq %r8
	popq %rdi
  	iretq 

    