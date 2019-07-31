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
num0:resb 1
t0:resb 1
t1:resb 1

section .data
msg1: db "Enter the number of rows in the matrix : "
size1: equ $-msg1
msg2: db "Enter the elements one by one : "
size2: equ $-msg2
msg3: db "Enter the number of columns in the matrix : "
size3: equ $-msg3
tab: db 9 
newl: db 10 
er: db "Error",0ah
sr: equ $-er

section .text
global _start
_start:


mov byte[num0],0

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
mov word[a],cx
mov word[b],cx
mov word[c],cx
cmp word[c],0
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
cmp word[n],0
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



exchange:
pusha

mov word[i],0
mov word[j],0

sub word[a],1
add word[b],1

mov dx,0
mov ax,word[a]
mov bx,2
mul bx
mov word[a],ax

mov ax,word[b]
mov bx,2
mul bx
mov word[b],ax


mov ebx,m1
mov ecx,m1
movzx edx,word[a]
add ebx,edx

mov eax,0
mov edx,0


loopi:


mov ah,0
mov dl,0
mov ax,word[ebx]
mov dx,word[ecx]
mov word[ebx],0
mov word[ecx],0
mov word[ebx],dx
mov word[ecx],ax

movzx eax,word[a]
movzx edx,word[b]
add ebx,eax
add ecx,edx

sub word[c],1
cmp word[c],0
ja loopi

popa

mov eax,4
mov ebx,1
mov ecx,newl
mov edx,1
int 80h



arrayprint:

mov dl,0
;mov byte[temp],0
;mov byte[nod],0
mov eax,0
mov ebx,m1
mov word[i],0
mov word[j],0

for3:
mov word[j],0
for4:
mov dx,word[ebx+2*eax]
mov word[num],dx
;cmp word[num],0
;je print




pusha

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


print:

mov ah,0
mov al,byte[num]
mov bl,10
div bl

mov byte[t0],al
mov byte[t1],ah
;cmp byte[nod],0
;je end4

add byte[t0],30h
add byte[t1],30h

;dec byte[nod]
;pop dx
;mov byte[temp],dl
;add byte[temp],30h

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

end4:
popa

pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
inc eax
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb for4
pusha
mov eax,4
mov ebx,1
mov ecx,newl
mov edx,1
int 80h
popa
inc word[i]
mov cx,word[i]
cmp cx,word[m]
jb for3

exit:
mov eax,1
mov ebx,0
int 80h

error:

mov eax,4
mov ebx,1
mov ecx,er
mov edx,sr
int 80h

jmp exit


