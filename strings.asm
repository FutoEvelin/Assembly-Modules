;Futo Evelin,feim2349,lab4
%include 'mio.inc'

global StrLen, StrCat, StrUpper, StrLower, StrCompact

section .text

StrLen:

    xor ecx, ecx
    xor ebx, ebx ;ebx-ben a hosszt taroljuk, amit majd athelyezunk az eax-be

.loop:
    mov al, [esi+ecx]
    cmp al, 0
    je .end
    inc ecx
    inc ebx ;novelem a karakterszamlalot
    jmp .loop

.end:
    mov eax, ebx
    ret


StrUpper:
    xor ecx, ecx   ;szamlalo   
.loop2:
    mov al, [esi + ecx]  
    cmp al, 0             
    je .end2
    cmp al, 'a'           
    jl .nagybetu
	jge .kisbetu1
    cmp al, 'z'
    jg .nagybetu
	jle .kisbetu2
 ;ha kisbetu, akkor kivonunk 32-t, ha mar alapbol nagybetu akkor csak noveljuk a szamlalot
  
.kisbetu1:
cmp al,'z'
jg .nagybetu
sub al,32
mov [esi+ecx],al

.kisbetu2:
cmp al,'a'
jl .nagybetu
sub al,32
mov [esi+ecx],al
.nagybetu:
    inc ecx          
    jmp .loop2

.end2:
    ret


StrLower:
    xor ecx, ecx         ;szamlalo 

.loop3:
    mov al, [esi + ecx]   
    cmp al, 0            
    je .end3
    cmp al, 'A'          ;ha alapbol kisbetu, akkor mar csak a szamlalot novelem 
    jl .kisbetu

    cmp al, 'Z'
    jg .kisbetu
    add al, 32            ;ha nagybetu, akkor hozzaadok 32-t,hogy kisbetu legyen
    mov [esi + ecx], al   

.kisbetu:
    inc ecx               
    jmp .loop3

.end3:
    ret

StrCompact:
    xor ecx, ecx
    xor edx, edx
	
.strcompactciklus:
    xor eax, eax
    mov al, [esi+ecx]
    cmp al, 0
    je .vegestrcompact
    inc ecx
    cmp al, 9             ;vizsgaljuk a karaktereket, ha el kell tavolitanunk akkor nem tesszuk bele az uj stringbe
    je .strcompactciklus
    cmp al, 10
    je .strcompactciklus
    cmp al, 13
    je .strcompactciklus
    cmp al, 32
    je .strcompactciklus
	jmp .epit
   

.epit: ;ha nem volt olyan karakter amit ki kellett torolni, felepitjuk a szamot
 mov [edi+edx], al
 inc edx
 jmp .strcompactciklus


.vegestrcompact:
    mov [edi+edx], byte 0
    ret


StrCat:

     xor ecx,ecx
	 xor edx,edx
    
    .vegekereses:
	 mov al,[edi+ecx]
     cmp al, 0 ;megkeressuk a karakterlanc veget
     je  .masol
     inc ecx
     jmp .vegekereses

    
     .masol:
	xor edx,edx
  
    .masolas:
     mov al, [esi+edx]
     cmp al, 0
     je  .vegee
     mov [edi+ecx], al ;atmasoljuk a karaktereket egyenkent
     inc edx
     inc ecx
     jmp .masolas

    .vegee:
	
    mov byte[edi+ecx], 0
    ret







