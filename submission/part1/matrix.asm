.global main, get_elemnt_from_matrix, multiplyMatrices
.extern set_elemnt_in_matrix



.section .text
get_elemnt_from_matrix:
        #rdi = matrix pointer
        #rsi = num of columns
        #rdx = row index
        #rcx = col index
        #prologue
        pushq %rbp
        mov %rsp, %rbp 
        
        imul %rsi, %rdx #edx = index of cel [row][0] in matrix
        add %rcx, %rdx #edx = index of cel [row][col] in matrix
        mov (%rdi, %rdx, 4), %rax #eax=matrix pointer + (index of cel [row][col] in matrix)*4 
        #epilogue
        leave
	ret

multiplyMatrices:
        #edi = first matrix ptr
        #esi = second matrix ptr
        #edx = result matrix ptr
        #ecx = first matrix num of row
        #r8d = first matrix cols and seconed matrix rows
        #r9d = second matrix num of cols
        #4(rbp) = field size   
        #prologue             
        pushq %rbp
        mov %rsp, %rbp
        pushq %r12
        pushq %r13
      
        #set counters                
        mov $0,%r12d# r12  = (i) first_matrix_num of rows cnt
        mov $0,%r13d# r13 = (j) second_natrix number of cols cnt

     
      outter_loop:
        inner_loop:

        # saving regs before call
        pushq %rdi
        pushq %rsi
        pushq %rdx
        pushq %rcx
        pushq %r8
        pushq %r9
        
        #set parametrs for calcElement
        movl %ecx, %edx # edi = first matrix num of row
        movl %r9d, %ecx # ecx = first matrix cols and seconed matrix rows
        movl %r8d, %r8d # r8d = second matrix num of cols
        movl %r12d, %r9d    #r9d = index i of row
        pushq %r13          #4(rbp) = index j of col
        call calcElement
        #set parametrs for set_element_in_matrix
        cdq
        addq $8, %rsp
        divl 16(%rbp)        #value = value%field
        
        movl %edx, %r8d     #r8d = value
        movq 24(%rsp), %rdi #edi = result matrix ptr
        movl (%rsp), %esi  #esi = result matrix size
        movl %r12d, %edx    #edx = index i (row)
        movl %r13d, %ecx    #ecx = index j (col)


        call set_elemnt_in_matrix
        #resotre all regs
        popq %r9
        popq %r8
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        
        #inner loop for(int i=0; i<second.num_of_col; i++)
        inc %r13d                                                                  
        cmp %r9d,%r13d 
        jne inner_loop
        
        #outter loop for (int j=0; j< first.num of rows; j++)
        inc %r12d
        mov $0,%r13d    # j = 0
        cmp %ecx,%r12d
        jne outter_loop 
        
        #epilogue
        popq %r13
        popq %r12 
        leave     
	ret

calcElement: #int calcElement(int *first_matrix, int *second_matrix, int first_mat_num_of_rows, int second_num_of_col, int second_num_rows, int row, int col)
        #TODO: STUDENTS NEED TO FILL
        #edi = *first_matrix
        #esi = *second_matrix
        #edx = first_mat_num_of_rows
        #ecx = second_num_of_col 
        #r8d = second_num_of_rows and firs_num_of_cols
        #r9d = row
        #16(rbp) = col      
        
        #prologue
        pushq %rbp
        mov %rsp, %rbp
        pushq %r12
        pushq %r13
        
        #intiating variables
        mov $0, %r10  #int i=0
        mov $0, %rax   #int sum =0
        mov $0, %r12   # r12 = first[row,i]
        mov 16(%rbp), %r13 # r13 = col
        
        imul %r8,%r9 #r9d = row*first_num_of_col  = first_matrix[row]
 
        loop:
        
        movl (%rdi,%r9,4), %r11d  #r11d = first_matrix[row][i]
        imull (%rsi,%r13, 4),%r11d # r11d = first_mat[row][i]*second[i][col] 
        addl %r11d, %eax #sum += r11d(mul)       
        inc %r9d    #row++
        add %ecx, %r13d    #col++
        
        #inner loop for(int i=0; i<second num of rows; i++)
        inc %r10d 
        cmp %r10d,  %r8d
        jne loop
        
        #epilogue
        popq %r13
        popq %r12
        leave
        ret





