section .data
spa:dw " "
len: equ $-spa
newl:dw "",0Ah
len1: equ $-newl
msg:dw "Error"
len2: equ $-msg


section .bss

d: resw 1
s: resw 1
ten: resw 1
t: resw 1
n1: resw 1
n2: resw 1
arr:resw 1
arr1:resw 500
arr2:resw 500
arr3:resw 500
r:resw 1
c:resw 1
r1:resw 1
c1:resw 1
r2:resw 1
c2:resw 1
i: resw 1
j: resw 1
k: resw 1
i1: resw 1
j1: resw 1
kk: resw 1
n: resw 1
o: resw 1
array:resd 1
dtemp:resd 1
sui:resw 1
t1:resw 1
t2:resw 1

section .text

global _start:
_start:

call read
mov ax,word[s]
mov word[r1],ax

call read
mov ax,word[s]
mov word[c1],ax

mov ax,word[r1]
mov cx,word[c1]
mul cx
mov word[n1],ax

movzx ecx,word[n1]
mov ebx,arr1
call arrayread
;movzx ecx,word[n1]
;mov ebx,arr1
;call arrayprint

mov ebx,arr1
mov ax,word[r1]
mov word[r],ax
mov ax,word[c1]
mov word[c],ax
call printmatrix
call enterprint


call read
mov ax,word[s]
mov word[r2],ax

call read
mov ax,word[s]
mov word[c2],ax

mov ax,word[c1]
mov cx,word[r2]
cmp ax,cx
jne error

mov ax,word[r2]
mov cx,word[c2]
mul cx
mov word[n2],ax

movzx ecx,word[n2]
mov ebx,arr2
call arrayread


mov ebx,arr2
mov ax,word[r2]
mov word[r],ax
mov ax,word[c2]
mov word[c],ax
call printmatrix
call enterprint



mov word[i1],0
fori1:

mov word[j1],0
forj1:


mov word[kk],0
mov word[sui],0
fork1:

mov edx,arr1
mov ax,word[c1]
mov word[n],ax
mov ax,word[i1]
mov word[i],ax
mov ax,word[kk]
mov word[j],ax
call ot

add edx,dword[o]

mov ax,word[edx]
mov word[t1],ax

mov edx,arr2
mov ax,word[c2]
mov word[n],ax
mov ax,word[kk]
mov word[i],ax
mov ax,word[j1]
mov word[j],ax
call ot

add edx,dword[o]

mov ax,word[edx]
mov cx,word[t1]
mul cx
mov word[t2],ax
mov ax,word[sui]
add ax,word[t2]
mov word[sui],ax


inc word[kk]
mov ax,word[kk]
cmp ax,word[c1]
jl fork1

mov edx,arr3
mov ax,word[c2]
mov word[n],ax
mov ax,word[i1]
mov word[i],ax
mov ax,word[j1]
mov word[j],ax
call ot

add edx,dword[o]

mov ax,word[sui]
mov word[edx],ax


inc word[j1]
mov ax,word[j1]
cmp ax,word[c2]
jl forj1


inc word[i1]
mov ax,word[i1]
cmp ax,word[r1]
jl fori1

mov ebx,arr3
mov ax,word[r1]
mov word[r],ax
mov ax,word[c2]
mov word[c],ax
call printmatrix
jmp exit


error:
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len2
int 80h


exit:

mov eax,1
mov ebx,0
int 80h



;movzx ecx,word[n]
;mov ebx,arr
arrayread:
pusha

 
enterarray:
push ecx 
push ebx
call read
mov ax,word[s]

pop ebx
mov word[ebx],ax
add ebx,2
pop ecx
loop enterarray
popa
ret

arrayprint:
pusha

printarray:
push ecx

mov ax,word[ebx]
mov word[s],ax
push ebx

call print
mov eax,4
mov ebx,1
mov ecx,spa
mov edx,len
int 80h
pop ebx
add ebx,2
pop ecx
loop printarray
popa
ret

read:
pusha
mov word[s],0
first:

mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp word[d],0Ah
je reade
cmp word[d],20h
je reade

sub word[d],30h

mov ax,word[s]
mov bx,10
mul bx
add ax,word[d]
mov word[s],ax

jmp first

reade:
popa
ret

print:
pusha
mov word[ten],1
mov dx,0
mov ax,word[s]
mov cx,10
div cx
mov word[t],ax

tens:
cmp word[t],0
je printf

mov dx,0
mov ax,word[t]
mov cx,10
div cx
mov word[t],ax

mov ax,word[ten]
mov bx,10
mul bx
mov word[ten],ax

jmp tens

printf:

mov dx,0
mov ax,word[s]
mov cx,word[ten]
div cx

mov word[d],ax
mov word[s],dx
add word[d],30h

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h

cmp word[ten],1
je printe

mov dx,0
mov ax,word[ten]
mov cx,10
div cx
mov word[ten],ax

jmp printf
printe:
popa 
ret

;i,j,n

ot:
pusha

mov ax,word[n]
mov cx,word[i]
mul cx

mov cx,word[j]
add ax,cx

mov cx,2
mul cx

mov word[o],ax

popa 
ret


;row,colm,array

printmatrix:
pusha
push ebx

mov ax,word[c]
mov word[n],ax
mov word[i],0
mov eax,4
mov ebx,1
mov ecx,newl
mov edx,len1
int 80h
forii:

mov word[j],0
forjj:
pop ebx
mov edx,ebx
push ebx

call ot

add edx,dword[o]

mov ax,word[edx]
mov word[s],ax
call print

mov eax,4
mov ebx,1
mov ecx,spa
mov edx,len
int 80h

inc word[j]
mov ax,word[j]
cmp ax,word[c]
jl forjj

mov eax,4
mov ebx,1
mov ecx,newl
mov edx,len1
int 80h

inc word[i]
mov ax,word[i]
cmp ax,word[r]
jl forii
pop ebx
popa 
ret

enterprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,newl
mov edx,len1
int 80h

popa
ret





















