section .data
    x dd 5, 3, 2, 6, 1, 7, 4
    len dd ($ - x) / 4
    y dd 0, 10, 1, 9, 2, 8, 5
    format db "average value is: %d", 0xA
    
section .text
  global main
  extern printf

main: 
    mov edx, 0
    mov eax, 0

_loop:
	xor esi, esi
    cmp edx, [len]
    jge calculate
    
    mov esi, [x + edx * 4]
    sub esi, [y + edx * 4]

    add eax, esi
	inc edx
    jmp _loop

calculate:
	mov bx, 0
	cmp eax, 0
	jge make_result
	mov bx, 1
	neg eax
make_result:
    mov ecx, [len]
    xor edx, edx
    idiv ecx
	cmp bx, 0
	je print
	neg eax

print:
	mov [result], eax
    push rax
    push rbx
    push rcx
    push rdx
    push rbp
    mov rdi, format
    mov rsi, [result]
    call printf
    pop rax
    pop rbx
    pop rcx
    pop rdx
    pop rbp

end:
    mov rax, 60
    xor rdi, rdi
    syscall



section .bss
	result resb 1