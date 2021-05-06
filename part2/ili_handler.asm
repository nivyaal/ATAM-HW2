.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
#prologue
  pushq %rdi
  pushq %r8
#checking what opcode length
  testq $0xf00,16(%rsp)
  jnz len2
len1:
  movq $1, %r8
  jmp function
len2:
  movq $2, %r9
function:
#calling what_to_do with last byte of opcode
  movq $0xff, %rdi
  andq 16(%rsp),  %rdi
  call what_to_do
#cases in accordence to function return value
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


