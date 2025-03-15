;Futo Evelin,feim2349,lab4
%include 'mio.inc'
%include 'iostr.inc'
%include 'strings.inc'
section .text
global ReadInt,WriteInt,ReadBin,WriteBin,ReadHex,WriteHex

ReadInt:
.memoriacim:
mov ebp,esp ;lementem a veremmutatot
sub esp,200
mov esi,esp
mov ecx,200
clc
call ReadStr ;string-kent beolvasom a szamot
call NewLine
xor edi,edi
xor ebx,ebx
xor edx,edx

jmp .minusz ;eloszor lellenorzom, hogy a szam negativ-e
.hiba:
stc
jmp .hibaend

.minusz:
xor eax,eax
mov al,[esi+edi]
cmp al,'-'
je .negativ;ha a szam negativ, akkor beallitom az elojelregisztert, ami jelen esetben az edx
jne .loop
.loop:
xor eax,eax
mov al,[esi+edi] ;egyenkent beleteszem a string minden elemet az al-be,s felepitem a szamot
cmp al,byte 0
je .vege

cmp al,'9'
jg .hiba

cmp al,'0'
jl .hiba

sub al,48
imul ebx,10
jo .hibaend
add ebx,eax
jo .hibaend
inc edi
jmp .loop

.negativ:
mov edx,1
add edi,1
jmp .loop

.vege:
cmp edx,1
je .negal
jne .nemnegal
.negal:
imul ebx,-1
mov eax,ebx
mov esp,ebp
clc
ret

.nemnegal:
mov eax,ebx
mov esp,ebp ;visszallitom a veremmutatot
clc
ret

.hibaend:
mov esp,ebp
stc
ret

WriteInt:
    push ebx
    cmp eax, 0
    je .zero
    cmp eax,0
    jg .nemneg
	xor ebx,ebx
	mov ebx,eax
	mov eax,'-'
	call mio_writechar
	mov eax,ebx
    neg eax

.nemneg:
    xor ebx,ebx
    xor esi,esi
    mov ebx,10
.loop2: ;a mar felepitett szamot osztom 10-el, ameddig csak lehet, a maradekot pedig pusholom
    xor edx,edx
    cmp eax,0
    je .kiiras
    cdq
    idiv ebx
    push edx
    inc esi
    jmp .loop2

.kiiras: ;kiirom magat a szamot
    cmp esi,0
    je .end
    pop eax
    add eax,48
    call mio_writechar
    dec esi
    jmp .kiiras

.zero:
    mov eax, '0'  
    call mio_writechar
	pop ebx
    ret

.end:
    pop ebx
    ret
	

ReadBin:
clc
.memoriacim:;beallitom a veremmutatot
mov ebp,esp ;lementem a veremmutatot
sub esp,200
mov esi,esp
mov ecx,200
call ReadStr  ;stringkent beolvasom a szamot
jg .hiba
call mio_writeln      
xor edi,edi
xor ebx,ebx
xor ecx,ecx

jmp .hibaloop

.hiba:
stc
jmp .vegehiba

.hibaloop: ;vizsgalom, ha van-e hiba, ha igen akkor stc
xor eax,eax
mov al,[esi+edi]

cmp al, byte 0
je .read
inc edi
cmp al,'1'
jg .hiba 
jl .lehetnulla
je .hibaloop
.lehetnulla:
cmp al,'0'
jl .hiba
jmp .hibaloop

.read: ;egyenkent vegigmegyek a karakterlancon, felepitem a szamot
xor edi,edi
jmp .read_loop
.read_loop:
inc ecx
cmp ecx,33
jg .hiba
xor eax,eax
mov al,[esi+edi]
cmp al,byte 0
je .vege
sub al,48
shl ebx,1
add ebx,eax
inc edi
jmp .read_loop
.vege:
mov eax, ebx

.end:
mov esp,ebp
clc
ret
.vegehiba:
mov esp,ebp ;visszaallitom a veremmutatot
stc
ret


WriteBin: ;a szamot mindig shiftelem balra, ha van carry, akkor kiiratok 1-et,kulonben 0-t

    xor ecx, ecx
    mov ecx, 32         

.write_loop:
    cmp ecx, 0
    je .end_write
    shl eax, 1           
    jc .kiir1
    jnc .kiir0
.kiir1:
push eax
mov al,'1'
call mio_writechar
dec ecx
pop eax
jmp .write_loop

.kiir0:
push eax
mov al,'0'
call mio_writechar
dec ecx
pop eax
jmp .write_loop

.end_write:
    ret
	

ReadHex:
.memoriacim:
mov ebp,esp ;lementem a veremmutatot
sub esp,200
mov esi,esp
mov ecx,200
clc
call ReadStr ;beolvasom a szamot egy string-kent
call NewLine

mov edx, 0   
mov eax, 0
mov ebx, 0
xor edi,edi
jmp .loop1

.hiba:   
;ha hibaba utkozunk, a vegere ugrok
stc
jmp .hibaend

.loop1:
xor eax,eax
mov al,[esi+edi]

cmp eax,byte 0   ;vizsgalom a hiba eseteket, nezem ha enter
je .end

cmp eax,57      ;vizsgalom ha a szamjegy 9-nel kisebb-e(ezen belul majd vizsgalva lesz az,hogy 0-nal kisebb-e,mert akkor hiba)
jle .szam

cmp eax,70      ;vizsgalom ha a karakter kisebb-e mint F,amely a legnagyobb nagybetu, mely alkalmazhato meg hexa szamjegykent(ezen belul lesz majd vizsgalva, hogy nagyobb-e mint az A ascii kodja,mert ha nem akkor hiba)
jle .szj

cmp eax,102     ;vizsgalom ha a karakter kisebb-e mint f,amely a legnagyobb kisbetu,mely alkalmazhato meg hexa szamjegykent(ezen belul lesz vizsgalva, hogy nagyobb-e mint az a ascii kodja, mert ha nem akkor hiba)
jle .szjhex
jg .hiba


.szam:          ;atalakitom a karaktereket szamokka,szamrendszerek kozotti atalakitas is tortenik(shiftelest alkalmazok)
cmp eax,48
jl .hiba  
sub eax,48
shl edx,4
jo .hiba
add edx, eax
jo .hiba
inc edi
jmp .loop1

.szjhex:  
cmp eax,97    
jl .hiba
sub eax,87
shl edx,4
jo .hiba
add edx, eax
jo .hiba
inc edi
jmp .loop1

.szj: 
cmp eax,65
jl .hiba   
sub eax,55
shl edx,4
jo .hiba
add edx, eax
jo .hiba
inc edi
jmp .loop1

.hibaend:
mov esp,ebp
ret

.end:       ;a szam eax-ba kerul
mov esp,ebp
mov eax,edx
ret


 
WriteHex: ;elvegzem a szam kiirasat hogy 
    push ebx
    xor esi,esi
    xor ecx,ecx
    mov esi, eax

    mov eax, '0'
    call mio_writechar

    mov eax, 'x'
    call mio_writechar

    cmp esi,0
	je .hex_loopzero
	jne .hex_loop
.hex_loopzero: ;lekezelem azt az esetet amikor a szam 0
mov eax,esi
shr esi,4 ;shiftelem a szamot jobbra 4-el,majd and-elem 1111b-vel
and eax,1111b
cmp eax,'9' ; targyalom, hogy az illeto karakter kisbetu nagybetu vagy szam-e, s ennek fuggvenyeben kezelem
jle .szamjegy
mov eax,0
push eax
jmp .zero

.hex_loop:
    mov eax,esi
	cmp esi,0
	je .nullaszama
    shr esi, 4   ;shiftelem a szamot jobbra 4-el,majd and-elem 1111b-vel
    and eax, 1111b                     
    cmp eax, 9    ; targyalom, hogy az illeto karakter kisbetu nagybetu vagy szam-e, s ennek fuggvenyeben kezelem      
    jle .szamjegy
    add eax,87 
    jmp .verem

.szamjegy:
    add eax,48 
    jmp .verem	

.verem:
push eax
inc ecx
jmp .hex_loop

.nullaszama:
mov edx,8
sub edx,ecx
jmp .kiir0
.zero:
mov edx,8
jmp .kiir0
.kiir0:
cmp edx,0
je .vegeeee
mov eax,'0'
call mio_writechar
dec edx
jmp .kiir0



.vegeeee:
pop eax
call mio_writechar
dec ecx
cmp ecx,0
je .end
jmp .vegeeee

.end:
pop ebx
ret