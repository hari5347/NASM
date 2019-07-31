section .bss

array1: resw 200
n: resw 1
d: resw 1
m: resw 1
d0: resb 1
d1: resb 1
e: resw 1
o: resw 1
temp: resb 2
num: resw 1
nod: resb 1

section .data

msg: db 'Enter the number:'
size: equ $-msg
newl: db 10
size1: equ $-newl
msg1: db 'Even Count:'
s1: equ $-msg1
msg2: db 'Odd Count:'
s2: equ $-msg2
msg3: db 'n:'
s3: equ $-msg3

global _start
_start:

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,s3
int 80h

;mov eax,3
;mov ebx,0
;mov ecx,d0
;mov edx,1
;int 80h

;mov eax,3
;mov ebx,0
;mov ecx,d1
;mov edx,2
;int 80h

;sub byte[d0],30h
;sub byte[d1],30h

;mov al,byte[d0]
;mov bl,10
;mul bl
;add al,byte[d1]


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


mov ebx,array1

arread:

push ebx

mov eax,4
mov ebx,1
mov ecx,msg
mov edx,size
int 80h

;mov eax,3
;mov ebx,0
;mov ecx,d0
;mov edx,1
;int 80h

;mov eax,3
;mov ebx,0
;mov ecx,d1
;mov edx,2
;int 80h

;sub byte[d0],30h
;sub byte[d1],30h

;mov al,byte[d0]
;mov bl,10
;mul bl
;add al,byte[d1]
;mov byte[d],al

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

pop ebx

mov cx,word[num]
mov word[ebx],cx
add ebx,4

dec word[n]
cmp word[n],0

ja arread

mov ebx,array1

mov word[e],0
mov word[o],0

evenodd:
mov dx,0
mov ax,word[ebx]

push ebx

mov bx,2
div bx

cmp dx,0
je even

add word[o],1
jmp loop

even:
add word[e],1

loop:

pop ebx

add ebx,4
dec word[m]
cmp word[m],0

ja evenodd

mov cx,word[e]
mov word[num],cx

pusha
;mov bl,10
;div bl

;mov byte[d0],al
;mov byte[d1],ah

;add byte[d0],30h
;add byte[d1],30h

mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,s1
int 80h

;mov eax,4
;mov ebx,1
;mov ecx,d0
;mov edx,1
;int 80h

;mov eax,4
;mov ebx,1
;mov ecx,d1
;mov edx,1
;int 80h

mov byte[nod],0

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
popa



mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h

mov ax,word[o]
mov word[num],ax
pusha
;mov bl,10
;div bl

;mov byte[d0],al
;mov byte[d1],ah

;add byte[d0],30h
;add byte[d1],30h

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,s2
int 80h

;mov eax,4
;mov ebx,1
;mov ecx,d0
;mov edx,1
;int 80h

;mov eax,4
;mov ebx,1
;mov ecx,d1
;mov edx,1
;int 80h
mov byte[nod],0

div1:

cmp word[num],0
je print1
inc byte[nod]

mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp div1

print1:

cmp byte[nod],0
je end3

dec byte[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print1

end3:
mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h

popa


mov eax,4
mov ebx,1
mov ecx,newl
mov edx,size1
int 80h


mov eax,1
mov ebx,0
int 80h

