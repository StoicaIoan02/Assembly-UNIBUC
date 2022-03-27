.data

n: .long 0
n3: .long 0
m: .long 0
s: .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
ap: .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   
sol: .long 0
ok: .long 0
aux: .long 0

endl_s: .asciz "\n"
no_sol: .asciz "-1\n"
scan_int: .asciz "%d"
print_int: .asciz "%d "

.text

back:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	
	movl n3, %eax
	cmp 8(%ebp), %eax  #8(%ebp) == k
	jne end_if1
	movl $1, sol
	jmp exit_back
	end_if1:
	
	lea s, %edi
	movl 8(%ebp), %eax
	cmp $0, (%edi, %eax, 4)
	je end_if2
	movl 8(%ebp), %eax
	add $1, %eax
	pushl %eax
	call back
	popl %eax
	jmp exit_back
	end_if2:
	
	movl $1, %ecx
	for2:
		cmp n, %ecx	#%ecx = contorul
		jg for2_exit
		
		#if(ap[i] <= 2 )
		lea ap, %edi
		cmp $2, (%edi, %ecx, 4)
		jg final_for2
			
		#ap[i]++;
		lea ap, %edi
		add $1, (%edi, %ecx, 4)	
		
		#s[k] = i;
		lea s, %edi
		movl 8(%ebp), %eax
		movl %ecx, (%edi, %eax, 4) 
		
		#ok = 1;
		movl $1, ok
		
		
		push %ecx
		#for(int j=k-m;j<=k+m;j++)
		movl 8(%ebp), %ecx
		sub m, %ecx
		for5: 
			movl 8(%ebp), %eax
               	add m, %eax
               	add $1, %eax
               	cmp %ecx, %eax
               	je for5_exit
                		
                		#if ( j>=1 && j< 3*n+1 && j!=k && s[k] == s[j])
                		cmp $1, %ecx		#j>=1
                		jl end_if5
                		
                		cmp n3, %ecx		#j<=3*n
                		jge end_if5
                		
                		cmp 8(%ebp), %ecx	#j!=k	
                		je end_if5
                		
                		lea s, %edi
                		movl 8(%ebp), %eax
                		movl (%edi, %ecx, 4), %edx
                		cmp (%edi, %eax, 4), %edx	#s[k] == s[j]
                		jne end_if5
                		
					#{
					#ok = 0;
					movl $0, ok
						
					#break;
					jmp for5_exit	
					#}
				
				end_if5:
			
                	add $1, %ecx
                	jmp for5
               for5_exit:
               popl %ecx
		
		
		#if (ok==1)
                #back ( k+1 );
		
		movl ok, %eax
		movl $1, %edx
		cmp %edx, %eax
		jne end_if3
		pushl %ecx
		add $1, 8(%ebp)
		pushl 8(%ebp)
		call back
		popl %eax
		sub $1, 8(%ebp)
		popl %ecx
		end_if3:
		
		#if ( sol == 1 )
                 #return;
		movl sol, %eax
		cmp $1, %eax
		je final_for2
		
		#s[k] = 0;
            	lea s, %edi
            	movl 8(%ebp), %eax
            	movl $0, (%edi, %eax, 4)
            	
            	#ap[i]--;
            	lea ap, %edi
            	sub $1, (%edi, %ecx, 4)	
		
		final_for2:
		
		add $1, %ecx
		jmp for2	
	for2_exit:
	
		
	
	
	
	
	exit_back:
	
	
	popl %edi
	popl %ebp
	ret


.global main

main:

#scanf("%d",n);
pushl $n
pushl $scan_int
call scanf
popl %edx
popl %edx

#scanf("%d",m);
pushl $m
pushl $scan_int
call scanf
popl %edx
popl %edx


mov n, %eax
mov $3, %edx
mul %edx
add $1, %eax
mov %eax, n3


#for (int i=1; i<= n * 3; i++)
movl $1, %ecx
for1:
	cmp n3, %ecx	#%ecx = contorul
	je for1_exit
	
	#scanf("%d",&s[i]);
	pushl %ecx
	pushl $aux
	pushl $scan_int
	call scanf
	popl %edx
	popl %edx
	popl %ecx
	
	lea s, %edi #edi = s 
	movl aux, %eax
	movl %eax, (%edi, %ecx, 4)
	
	#ap[s[i]]++;
	movl (%edi, %ecx, 4) , %eax	
	lea ap, %edi
	add $1, (%edi, %eax, 4)

	add $1, %ecx
	jmp for1
	
for1_exit:
	
pushl $1
call back
popl %eax

#if ( sol == 1 )
movl sol, %eax
cmp $1, %eax
jne else4
	#for(int i=1; i<= 3 * n; i++)
	movl $1, %ecx
	for4:
		cmp n3, %ecx
		je for4_exit
			
		#printf("%d ",s[i]);
		lea s, %edi
		pushl %ecx
		pushl (%edi, %ecx, 4)
		pushl $print_int
		call printf
		popl %edx
		popl %edx
		popl %ecx
		
		add $1, %ecx
		jmp for4
	for4_exit:
		
	#printf("\n");
	pushl $endl_s
	call printf
	popl %edx
	
	jmp end_if4
else4:
	#else 
        #printf("-1\n");
	pushl $no_sol
	call printf
	popl %edx
	
end_if4:

	
#printf("\n");
pushl $endl_s
call printf
popl %edx

movl $1, %eax
xorl %ebx, %ebx
int $0x80



