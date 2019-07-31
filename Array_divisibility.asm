section .bss

array1: resw 100
n: resw 1
m: resw 1
num: resw 1
a: resw 1
b: resw 1
nod: resb 1
temp: resb 2
 
section .data

msg: db 'Enter the number:'
size: equ $-msg
newl: db 10
size1: equ $-newl
er: db 10, 'Error',0ah 
size3: equ $-er
msg1: db 'a:'
s1: equ $-msg1
msg2: db 'b:'
s2: equ $-msg2
msg3:db 'n:'
s3: equ $-msg3

global _start
_start:

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,s3
int 80h

read1:

pusha
mov word[num],0

l1:

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end1

mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp l1

end1:

popa

mov cx,word[num]
mov word[n],cx
mov word[m],cx


mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,s1
int 80h

mov ecx,0

read2:

pusha
mov word[num],0

l2:

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end2

mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp l2

end2:

popa

mov cx,word[num]
mov word[a],cx
cmp word[a],0
je error



mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,s2
int 80h

mov ecx,0

read3:

pusha
mov word[num],0

l3:

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end3

mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp l3

end3:

popa

mov cx,word[num]
mov word[b],cx
cmp word[b],0
je error


mov ebx,array1

arread:

push ebx

mov eax,4
mov ebx,1
mov ecx,msg
mov edx,size
int 80h

mov ecx,0

read4:

pusha
mov word[num],0

l4:

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end4

mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp l4

end4:

popa

mov cx,word[num]


pop ebx
mov word[ebx],cx
add ebx,4

dec word[n]
cmp word[n],0

ja arread

mov ebx,array1


arrdiv:

mov dx,0
mov ax,word[ebx]
cmp word[ebx],0
push ebx
je loop

div word[a]


cmp dx,0
je if
jne loop


if:
pop ebx
mov ax,word[ebx]
div word[b]
cmp dx,0
pusha
je if2
jne loop

if2:
popa
mov cx,word[ebx]
mov word[num],cx


pusha

div:

cmp word[num],0
je print
inc byte[nod]

mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp div

print:

cmp byte[nod],0
je end5

dec byte[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print

end5:
mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h

popa


loop:


add ebx,4

dec word[m]
cmp word[m],0

ja arrdiv

exit:

mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h

mov eax,1
mov ebx,0
int 80h

error:

mov eax,4
mov ebx,1
mov ecx,er
mov edx,size3
int 80h

jmp exit
