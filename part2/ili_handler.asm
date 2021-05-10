.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
#prologue    
  pushq %r8
  pushq %rax
#rdi holding the illegal command
  movq 16(%rsp), %rdi
  #movq (%rdi),%rdi
  
#checking what opcode length
  cmp $0x0F,%dil
  je len2
len1:
  movq $1, %r8
  jmp function
len2:
  movq $2, %r8 
  shrq $8, %rdi
function:
#calling what_to_do with last byte of opcode

  andq $0xFF,  %rdi
  call what_to_do
#cases in accordence to function return value
  cmp $0, %eax
  jne case_not_zero 
case_zero:
   popq %rax
   popq %r8
  jmp *old_ili_handler
case_not_zero:
  # mov %rax,%rdi
   add %r8,16(%rsp)
   popq %rax
   popq %r8
   mov $5,%rdi
 iretq
 
   
  
