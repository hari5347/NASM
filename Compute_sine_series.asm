section .data:
two:dq 2.000000
format1:db "%lf",0
format2:db "formula:%lf",10,0
format3:db "function:%lf",10,0

section .bss
d:resw 1
sum:resw 1
temp:resw 1
n:resd 1
i:resw 1
j:resw 1
t:resd 1
a:resq 1
x:resq 1
e:resq 1
f:resq 1
y:resq 1
val:resq 1
section .text
global main
extern scanf
extern printf

print:
push ebp
mov ebp,esp
sub esp,8
fst qword[ebp-8]
push format2
call printf
mov esp,ebp
pop ebp
ret

print11:
push ebp
mov ebp,esp
sub esp,8
fst qword[ebp-8]
push format3
call printf
mov esp,ebp
pop ebp
ret

read:
push ebp
mov ebp,esp
sub esp,8
lea eax,[esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp,ebp
pop ebp
ret


main:
fldpi
fmul qword[two]
call read
fprem
FST qword[x]
FSIN
call print11
call free
mov dword[n],1
call free
FLD1
FSTP qword[a]
fldz
fstp qword[val]
call free
loopu:
FILD dword[n]
fstp qword[f]
call factorial

call exponent

fld qword[e]
fdiv qword[f]
fmul qword[a]

fld qword[val]
fadd st1
fstp qword[val]
fldz

fcomip st1
je endu

call free
fld qword[a]
fchs
fstp qword[a]
add dword[n],2
jmp loopu

endu:
fld qword[val]
call print




exit:
mov eax,1
mov ebx,0
int 80h


factorial:
call free
fld qword[f]
starti:
fld qword[f]
fld1
fsubr st1
fld1
fcomip st1
jnb endfac
fst qword[f]
fmul st2
ffree st2
ffree st1
jmp starti
endfac:
fstp qword[f]
fstp qword[f]
fstp qword[f]
ret


read5:
pusha
mov word[sum],0
read1:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp word[d],10
je exitr
cmp word[d],20h
je exitr
sub word[d],30h
mov ax,word[sum]
mov cx,10
mul cx
add ax,word[d]
mov word[sum],ax
jmp read1
exitr:
popa
ret


array:
pusha
mov ax,word[n]
mov word[temp],ax
mov ebx,a
loopify:
cmp word[temp],0
je exitloopify
call read
FSTP qword[ebx]
add ebx,8
dec word[temp]
jmp loopify
exitloopify:
popa
ret



indexj:
pusha
mov ax,word[j]
mov cx,8
mul cx
mov word[t],ax
popa
ret

indexi:
pusha
mov ax,word[i]
mov cx,8
mul cx
mov word[t],ax
popa
ret

exponent:
call free
fld qword[x]
mov ecx,dword[n]
cmp ecx,1
je endpow
dec ecx
po:
fmul qword[x]
loop po
fstp qword[e]
ret
endpow:
fstp qword[e]
ret



arrayprint:
pusha
mov ax,word[n]
mov word[temp],ax
mov ebx,a
loopprint:
cmp word[temp],0
je exitloopprint
FLD qword[ebx]
call print
add ebx,8
dec word[temp]
jmp loopprint
exitloopprint:
popa
ret


free:
pusha
FFREE ST0
FFREE ST1
FFREE ST2
FFREE ST3
FFREE ST4
FFREE ST5
FFREE ST6
FFREE ST7
popa
ret

