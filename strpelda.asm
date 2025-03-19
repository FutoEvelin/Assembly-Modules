;Futo Evelin,feim2349,lab4
%include 'strings.inc'
%include 'iostr.inc'
%include 'mio.inc'
%include 'ionum.inc'
section .text
global main
main:
mov eax,beolvas
call mio_writestr
call NewLine

;beolvasunk egy stringet,amit aztan ki is irtam
mov ebp,esp ;lementem a veremmutatot
sub esp,256
mov esi,esp
mov ecx,256
call ReadStr
mov [str_a],esi ;az str_a-ba lementem a memoriacimet

;kiirjuk a hosszat
call mio_writeln
call StrLen
call WriteInt

;kiirjuk a tomoritett formajat
mov esi,[str_a]
mov edi,[str_a]

call mio_writeln
call StrCompact
mov esi,edi
call WriteStr
;kiirjuk a tomoritett formajat kisbetukre alakitva
mov esi,[str_a] ;esi-ben a tomoritett forma
call StrLower
call mio_writeln
;esiben a szo
call WriteStr
call mio_writeln

;beolvassuk a masodik stringet
mov eax,beolvas2
call mio_writestr
call mio_writeln

mov ebp,esp ;veremmutato beallitasa
sub esp,256
mov esi,esp
mov ecx,256
call ReadStr
mov [str_b],esi ;az str_b-be lementem a memoriacimet
mov edi,esp; editol kezdodojon
call NewLine
;---------
;kiirjuk a hosszat
call StrLen
call WriteInt
call NewLine

;kiirjuk a tomoritett formajat
mov esi,[str_b]
mov edi,[str_b]

call StrCompact
mov esi,edi ;ediben van
call WriteStr
;kiirjuk a tomoritett formajat nagybetukre alakitva
mov esi,[str_b]
call NewLine
;ediben van a nagybetusse alakitando szo
call StrUpper
;esiben a szo nagybetus formaja
call WriteStr

;létrehozunk a memóriában egy új stringet: az első 
;string nagybetűs verziójához hozzáfűzzük
; a második string kisbetűs verzióját
mov esi,[str_a]
call StrUpper

mov esi,[str_b]
call StrLower

call NewLine
mov esi,[str_b]
mov edi,[str_a]
call StrCat
mov esi,edi
call WriteStr
call NewLine
call StrLen
call WriteInt
ret

section .data
beolvas db "olvasd be a stringet: ",0
beolvas2 db "olvasd be a masodik stringet: ",0
section .bss
str_a resb 256
str_b resb 256
