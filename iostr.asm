;Futo Evelin,feim2349,lab4
%include 'mio.inc'
%include 'strings.inc'
section .text
global ReadStr,WriteStr,ReadLnStr,NewLine,WriteLnStr


ReadStr:
    xor edx, edx

.loop:
cmp ecx,0
je .end
    xor eax,eax
    call mio_readchar
    call mio_writechar
    cmp al, 13
    je .end
    cmp al, 8
    je .torol
    mov [esi+edx], al ;felepitem a karakterlancot egyenkent, minden lepesnel novelem a szamlalot
    inc edx
	dec ecx
    jmp .loop

.torol: ;torles
    cmp edx, 0
    je .loop        
    mov al, ' '  
    call mio_writechar
    mov al, 8    
    call mio_writechar
    dec edx  
    mov [esi+edx], byte 0  
    jmp .loop

.end:
    mov [esi+edx], byte 0
    xor edi, edi
    mov edi, edx
	
    ret


WriteStr: ;kiiratom a karakterlancot
    xor edi,edi
	call StrLen
	mov edi,eax
    xor eax, eax
    mov edx, edi
    inc edx
    mov edi, edx
    xor edx, edx
.loop2:
    mov al, [esi+edx]
    inc edx
    cmp edx, edi
    je .end2
    call mio_writechar
    jmp .loop2

.end2:

    ret


ReadLnStr:
    xor edx, edx
	
.loop:
    cmp ecx,0
    je .end
    xor eax,eax
    call mio_readchar
    call mio_writechar
    cmp al, 13
    je .end
    cmp al, 8
    je .torol
    mov [esi+edx], al ;felepitem a karakterlancot
    inc edx
	dec ecx
    jmp .loop

.torol:
    cmp edx, 0
    je .loop        
    mov al, ' '  
    call mio_writechar
    mov al, 8    
    call mio_writechar
    dec edx  
    mov [esi+edx], byte 0  
    jmp .loop

.end:
    mov [esi+edx], byte 0
    xor edi, edi
    mov edi, edx
	call NewLine
    ret

NewLine: ;ujsor kiirasa
mov al,10
call mio_writechar
ret

WriteLnStr:
    xor eax, eax
    mov edx, edi
    inc edx
    mov edi, ecx
    xor edx, edx
.loop2:
    mov al, [esi+edx]
    inc edx
    cmp edx, edi
    je .end2
    call mio_writechar
    jmp .loop2

.end2:
call NewLine
    ret
