.globl my_ili_handler
.extern what_to_do

.text
.align 4, 0x90
my_ili_handler:
	#prologue
	add $0x1,0(%rsp)
	call what_to_do
	mov $0x5,%rax
	iretq

    
