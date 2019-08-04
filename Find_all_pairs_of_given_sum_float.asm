section .data
mes1: db "Enter Number :", 0Ah
len1: equ $-mes1
mes2: db "Perimeter is :", 0Ah
len2: equ $-mes2
format1: db "%lf", 0
format2: db "%lf", 10

section .bss
num: resw 1
a: resq 1
b: resq 1
c: resq 1
tmp: resq 1
fr:resq 1
sq:resq 1
r1:resq 1
r2:resq 1
array:resq 100
size:resw 1
len:resw 1
digit:resw 1
i:resw 1
j:resw 1
k:resq 1
sum:resq 1
kk:resq 1
x: resq 100
section .text
global main:
extern scanf
extern printf

main:
fld1
mov dword[x],10000
fidiv dword[x]
fstp dword[x]
call read
mov ax,word[size]
mov word[len],ax

call readarray

call read_float
fstp qword[k]

fld qword[k]
fstp qword[kk]

mov word[i],0

 fori:
mov ax,word[size]
sub ax,1
cmp ax,word[i]
je EXIT

mov ax,word[i]
add ax,1
mov word[j],ax

forj:

mov ax,word[size]

cmp ax,word[j]
je goo2

movzx ecx,word[i]
fld qword[array+8*ecx]

movzx ecx,word[j]
fld qword[array+8*ecx]

fadd ST1
ffree ST1
fsub qword[kk]
fabs
fcomp dword[x]
fstsw ax
sahf
jae goo

movzx ecx,word[i]
fld qword[array+8*ecx]
call print_float
ffree ST0
movzx ecx,word[j]
fld qword[array+8*ecx]
call print_float
ffree ST0


goo:
inc word[j]

jmp forj
goo2:
inc word[i]

jmp fori


EXIT:
mov eax, 1
mov ebx, 0
int 80h



read_float:
push ebp
mov ebp, esp
sub esp, 8

lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp - 8]

mov esp, ebp
pop ebp
ret



print_float:
push ebp
mov ebp, esp
sub esp, 8

fst qword[ebp - 8]
push format2
call printf
mov esp, ebp
pop ebp
ret


readarray:
pusha
mov word[i],0
arrayread:
cmp word[len],0
je readend
call read_float
movzx ecx,word[i]
fstp qword[array+8*ecx]
dec word[len]
inc word[i]
jmp arrayread
readend:
popa
ret

printarray:
pusha
mov word[i],0
arrayprint:
cmp word[len],0
je endprint
movzx ecx,word[i]
fld qword[array+8*ecx]
call print_float
ffree ST0
dec word[len]
inc word[i]
jmp arrayprint
endprint:
popa
ret


read:
pusha
mov word[size],0
scanfirst:

mov eax,3
mov ebx,0
mov ecx,digit
mov edx,1
int 80h

cmp word[digit],0Ah
je readend1
cmp word[digit],20h
je readend1

sub word[digit],30h

mov ax,word[size]
mov bx,10
mul bx
add ax,word[digit]
mov word[size],ax

jmp scanfirst

readend1:
popa
ret
