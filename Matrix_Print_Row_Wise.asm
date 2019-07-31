section .bss
num: resw 1 
nod: resb 1 
temp: resb 2
m1: resw 200
m: resw 1
n: resw 1
i: resw 1
j: resw 1
a:resw 1
b:resw 1
c:resw 1
d:resw 1
t0:resb 1
t1:resb 1

section .data
msg1: db "Enter the number of rows in the matrix : "
size1: equ $-msg1
msg2: db "Enter the elements one by one(row by row) : "
size2: equ $-msg2
msg3: db "Enter the number of columns in the matrix : "
size3: equ $-msg3
tab: db 9 
newl: db 10 
space: db 32 
er: db "Error",0ah
sr:equ $-er

section .text
global _start
_start:




mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

mov ecx,0

read:

pusha
mov word[num],0

l:

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
jmp l

end1:

popa

mov cx,word[num]
mov word[m],cx
mov word[b],cx
cmp word[b],0
je error

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
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
mov word[n],cx
mov word[a],cx
mov word[c],cx
mov word[d],cx
cmp word[d],0
je error


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h

mov eax,0
mov ebx,m1
mov word[i],0
mov word[j],0

for1:
mov word[j],0

for2:
 
read1:

pusha
mov word[num], 0

l1:

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
jmp l1

end3:

popa

mov dx,word[num]
mov word[ebx+2*eax],dx
inc eax
inc word[j]
mov cx,word[j]
cmp cx,word[n]
jb for2
inc word[i]
mov cx,word[i]
cmp cx,word[m]
jb for1

add word[d],1

mov dx,0
mov ax,word[d]
mov bx,2
mul bx
mov word[d],ax


mov word[i],0
mov word[j],0
sub word[a],1
mov word[num],0
mov dx,0
mov ax,word[a]
mov bx,2
mul bx
mov word[a],ax
movzx edx,word[a]



mov ebx,m1
pusha

lo1:

mov word[num],0
mov ax,word[ebx]
mov word[num],ax

;call printnumb

pusha

mov ah,0
mov al,byte[num]
mov bl,10
div bl

mov byte[t0],al
mov byte[t1],ah

add byte[t0],30h
add byte[t1],30h

mov eax,4
mov ebx,1
mov ecx,t0
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,t1
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa


add ebx,2
add word[i],1
mov dx,word[i]
cmp dx,word[n]
jb lo1

movzx edx,word[a]
add ebx,edx
pusha
mov word[j],0
sub word[b],1
cmp word[b],0
ja lo2
jmp endl

lo2:
popa
mov word[num],0
mov cx,word[ebx]
mov word[num],cx

;call printnumb
pusha

mov ah,0
mov al,byte[num]
mov bl,10
div bl

mov byte[t0],al
mov byte[t1],ah

add byte[t0],30h
add byte[t1],30h

mov eax,4
mov ebx,1
mov ecx,t0
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,t1
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa

sub ebx,2
pusha
add word[j],1
mov dx,word[j]
cmp dx,word[n]
jb lo2

popa
movzx edx,word[d]
add ebx,edx
mov word[i],0
sub word[b],1
cmp word[b],0
ja lo1

endl:

mov eax,1
mov ebx,0
int 80h

error:

mov eax,4
mov ebx,1
mov ecx,er
mov edx,sr
int 80h
jmp endl

;printnumb:

;pusha

;div:

;cmp word[num],0
;je print
;inc byte[nod]

;mov dx,0
;mov ax,word[num]
;mov bx,10
;div bx
;push dx
;mov word[num],ax
;jmp div

;print:

;cmp byte[nod],0
;je end4


;dec byte[nod]
;pop dx
;mov byte[temp],dl
;add byte[temp],30h

;mov eax,4
;mov ebx,1
;mov ecx,temp
;mov edx,1
;int 80h
;jmp print

;end4:
;mov eax,4
;mov ebx,1
;mov ecx,space
;mov edx,1
;int 80h

;popa
;ret
