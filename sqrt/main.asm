%macro print 2
		push rax
        push rbx
        push rcx
        push rdx
        mov rax, 1
        mov rdi, 1
        mov rdx, %1
        mov rsi, %2
        syscall
		pop rdx
        pop rcx
        pop rbx
        pop rax
%endmacro

%macro printNumber 1
		push rax
        push rbx
        push rcx
        push rdx
		mov rbx, 0
		mov rax, [%1]
		mov rcx, 10
		%%_divide:
			xor rdx, rdx
			div rcx
			push rdx
			inc rbx
			test rax, rax
			jnz %%_divide
		%%_display:
			pop rax
			add rax, '0'
			mov [result], rax
			print 1, result
			dec rbx
			cmp rbx, 0
			jg %%_display
		pop rdx
        pop rcx
        pop rbx
        pop rax
%endmacro

section   .text
global    _start

_start: 
		fild dword [number]
    	fsqrt
    	fistp dword [val]

    	printNumber val
		print nlen, newLine

end:
        mov       rax, 60
        xor       rdi, rdi
        syscall

section .data
	number dd 90000
	newLine db 0xA, 0xD
    nlen equ $ - newLine
section .bss
		val resb 1
		result resb 1