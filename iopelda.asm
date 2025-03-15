;Futo Evelin,feim2349,lab4,
%include 'strings.inc'
%include 'iostr.inc'
%include 'mio.inc'
%include 'ionum.inc'
section .text
global main


main:
xor ebx,ebx
mov eax,decimalis
call mio_writestr
call mio_writeln

call ReadInt     ;beolvasom az elso szamot decimalisan
jc .beolvasdec   
jnc .folyt
.beolvasdec:     ;ha hiba van, kiirom, hogy "Hiba ", s beolvasom egy masik szamot
mov eax,hiba
call mio_writestr
call mio_writeln
call ReadInt

.folyt:          ;ha nincs hiba, akkor folytatom az eredeti szammal
call mio_writeln
mov ebx,eax      ;ebx-be elmentem a szamot


mov eax,decimalisankiirva ;kiirom a szamot decimalisan
call mio_writestr
call mio_writeln
mov eax,ebx
call WriteInt             

call mio_writeln          ;kiiratom a szamot hexadecimalisan
mov eax,hexakiirva
call mio_writestr
call mio_writeln
mov eax,ebx
call WriteHex             

call mio_writeln         ;kiiratom a szamot binarisan
mov eax,binarisan
call mio_writestr
call mio_writeln
mov eax,ebx
mov [elsoszam],eax       ;lementem az elso szamot
call WriteBin
;----------------------------------
xor ebx,ebx
call mio_writeln          ;beolvasom a hexadecimalis szamot
mov eax,hexabeolvas     
call mio_writestr
call mio_writeln
               
call ReadHex
jc .beolvashex           ;ha hiba van, ujrakerem a szamot
jnc .folyt2
.beolvashex:
mov eax,hiba
call mio_writestr
call mio_writeln
call ReadHex

.folyt2:                ;ha nincs hiba, folytatom az eredeti szammal
push eax
mov eax,decimalisankiirva
call mio_writestr
call mio_writeln
pop eax
mov ebx,eax
call WriteInt           ;kiiratom a szamot decimalisan

call mio_writeln
mov eax,hexakiirva
call mio_writestr
call mio_writeln

mov eax,ebx
call WriteHex          ;kiiratom a szamot hexadecimalisan

call mio_writeln
mov eax,binarisan
call mio_writestr
call mio_writeln

mov eax,ebx
mov [masodikszam],eax ;elmentem a szamot
call WriteBin
call mio_writeln
;-----------------------------------------------------------------------
mov eax,binarisbeolvas ;beolvasom a szamot binarisan, ugyanugy ellenorzom, hogy hibas-e, mert ha igen akkor ujat kerek
call mio_writestr
call mio_writeln
          
call ReadBin
jc .beolvasbin
jnc .folyt3
.beolvasbin:
mov eax,hiba
call mio_writestr
call mio_writeln
call ReadBin
.folyt3:        ;ha nem hibas, folytatom az eredeti szammal
push eax

call mio_writeln
mov eax,decimalis
call mio_writestr
call mio_writeln

pop eax
mov ebx,eax
call WriteInt ;kiiratom decimalisan

call mio_writeln

mov eax,hexakiirva
call mio_writestr
call mio_writeln

mov eax,ebx
call WriteHex ;kiiratom hexadecimalisan

call mio_writeln
mov eax,binarisan
call mio_writestr
call mio_writeln

mov eax,ebx
mov [harmadikszam],eax ;elmentem a szamot
call WriteBin

;----------------------------------------------------------------------
xor ebx,ebx     ;elvegzem a muveleteket
xor eax,eax
mov eax,[elsoszam]
add ebx,eax

mov eax,[masodikszam]
add ebx,eax

mov eax,[harmadikszam]
add ebx,eax


call mio_writeln
mov eax,decosszeg
call mio_writestr
call mio_writeln


mov eax,ebx
call WriteInt   ;az eredmenyt kiiratom decimalisan

call mio_writeln
mov eax,hexosszeg
call mio_writestr
call mio_writeln

mov eax,ebx
call WriteHex ;az eredmenyt kiiratom hexadecimalisan

call mio_writeln
mov eax,binosszeg
call mio_writestr
call mio_writeln

mov eax,ebx
call WriteBin ;az eredmenyt kiiratom binarisan
;--------------------------------------------------------------------------

ret


section .data
decimalis db 'kerem a decimalis szamot',0
decimalisankiirva db 'decimalisan',0
hexakiirva db 'hexadecimalisan ',0
binarisan db 'binarisan ',0
hexabeolvas db 'kerem a hexadecimalis szamot ',0
binarisbeolvas db 'kerem a binaris szamot',0
decosszeg db 'decimalis osszeg ',0
hexosszeg db 'hexa osszeg ',0
binosszeg db 'binaris osszeg ',0
elsoszam dd 0,0
masodikszam dd 0,0
harmadikszam dd 0,0
hiba db 'Hiba ',0