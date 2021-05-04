.global main, get_elemnt_from_matrix, multiplyMatrices
.extern set_elemnt_in_matrix



.section .text

main:

    ret


get_elemnt_from_matrix:
	#TODO: STUDENTS NEED TO FILL
        #rdi = matrix pointer
        #rsi = num of columns
        #rdx = row index
        #rcx = col index
        pushq %rbp
        mov %rsp, %rbp  #convetions for stack
        imull $4, %esi, %esi #one line memorey size
        imull $4, %ecx, %ecx #column index memory size form the start of the index row
        imull %ecx,%esi # esi = (column_memory+row_memory)*4   
        add %esi,%eax # eax=matrix pointer + (one row size)*(row index) + exact cell in the line      
        leave
	ret

multiplyMatrices:
	#TODO: STUDENTS NEED TO FILL
        #edi = first matrix ptr
        #esi = second matrix ptr
        #edx = result matrix ptr
        #ecx = first matrix num of row
        #r8d = first matrix cols and seconed matrix rows
        #r9d = second matrix num of cols
        #-4(rbp) = field size                 
        pushq %rbp
        mov %rsp, %rbp
        pushq %r12
        pushq %r13
      
        #set counters                
        mov 0,%r12d# r12  = (i) first_matrix_num of rows cnt
        mov 0,%r13d# r13 = (j) second_natrix number of cols cnt
        mov %ecx, %r14d 
        dec %r14d # r14d= first_mat_num_of_row -1
        mov %r9d, %r15d 
        dec %r15d # r15d= second_mat_num_of_cols -1
        
        
        
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
        movl %ecx, %edx # %edi = first matrix num of row
        movl %r8d, %ecx # %ecx = first matrix cols and seconed matrix rows
        movl %r9d, %r8d
        movl %r12d, %r9d
        pushq %r13
        call calcElement
        #set parametrs for set_element_in_matrix
        addq $4, %rsp
        movl 16(%rsp), %edi
        movl 4(%rsp), %esi
        movl %r12d, %edx
        movl %r13d, %ecx
        movl %eax, %r8d
        call set_element_in_matrix
        #resotre all regs
        popq %r9
        popq %r8
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        
        #inner loop for(int i=0; i<num of col; i++)
        inc %r13d                                                                  
        cmp %r8d,%r13d 
        jne inner_loop
        
        #outter loop for (int j=0; j< num of rows; j++)
        inc %r12d
        mov 0,%r13d    
        cmp %ecx,%r12d
        jne outter_loop 
        
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
        #r8d = second_num_of_rows
        #r9d = row
        #4(rbp) = col      
        
        pushq %rbp
        mov %rsp, %rbp
        pushq %r12
        movl $0, %r10d  #int i=0
        movl $0, %eax   #int sum =0
        movl $0, %r12d   # r12 = first[row,i]
        leal (%edi,%r9d,4), %edi #edi = *first_matrix[row]
        leal (%esi,4(rbp) ,4), %esi    #esi = first[0][col]
        imul 4,%ecx,%r12d   #r13d = second row mem size
        
        loop:
        
        movl (%edi,%r10d,4), %r11d  #r11d = first_matrix[row][i]
        imul (%esi,%r10d, %r13d),%r11d # r11d = first_mat[row][i]*second[i][col] 
        add %r11d, %eax #sum += r11d(mul)
        
        #inner loop for(int i=0; i<second num of rows; i++)
        inc %r10d 
        cmp %r10d,  %r8d
        jne loop
        
        #epilogue
        popl %r12d
        leave
        ret





