.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
#prologue
   #just for testing
   mov 0(%rsp),%rdi
   add $0x1,0(%rsp)
  /*pushq %r8
  pushq %rax
#checking what opcode length
  movq $0xF00,%rax
  andq 16(%rsp),%rax
  jnz len2
len1:
  movq $1, %r8
  jmp function
len2:
  movq $2, %r8
function:
#calling what_to_do with last byte of opcode
  #movq $0xFF, %rdi
  #andq 16(%rsp),  %rdi
  movq 16(%rsp),%rdi
  #call what_to_do
#cases in accordence to function return value
  mov %rdi,%rax # temporary for test!
  cmp $0, %eax
  jne case_not_zero 
case_zero:
   popq %rax
   popq %r8
   jmp old_ili_handler
case_not_zero:
   mov %rax,%rdi
   add %r8,16(%rsp)
   popq %rax
   popq %r8*/
   iretq
   
  