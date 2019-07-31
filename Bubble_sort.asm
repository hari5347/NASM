section .bss
d1:resb 1
d2:resb 1
n:resb 1
array1:resb 100
temp:resb 1
n1:resb 1
n2:resb 1
n3:resb 1
i:resb 1
j:resb 1

section .data
m1:db 'n:'
l1:equ $-m1
newl:db 10
ln:equ $-newl
m2:db 'Array:',0ah
l2:equ $-m2
m3:db 'Sorted Array:',0ah
l3:equ $-m3

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,m1
mov edx,l1
int 80h
mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,d2
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
sub byte[d1],30h
sub byte[d2],30h
mov al,byte[d1]
mov ah,0
mov bl,10
mul bl
add al,byte[d2]
mov byte[n],al
mov byte[n1],al
mov byte[n2],al
mov byte[n3],al
cmp byte[n],0
je exit
mov eax,4
mov ebx,1
mov ecx,m2
mov edx,l2
int 80h

mov ebx,array1

read:
push ebx
mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,d2
mov edx,1
int 80h
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
sub byte[d1],30h
sub byte[d2],30h
mov al,byte[d1]
mov ah,0
mov bl,10
mul bl
add al,byte[d2]
pop ebx
mov byte[ebx],al
add ebx,1
sub byte[n1],1
cmp byte[n1],0
jne read
mov byte[i],0
mov byte[j],0
sub byte[n2],1
for1:
 mov ecx,array1
 mov edx,array1
 cmp byte[n],1
 jne for2
 jmp print
for2:

 mov al,byte[j]
 cmp al,byte[n2]
 jb s1
 jmp s2
s1:
 add edx,1
 mov al,byte[edx]
 cmp byte[ecx],al
 jb iff
s3:
 add byte[j],1
 add ecx,1
 jmp for2
s2:
mov byte[j],0
sub byte[n],1

jmp for1
iff:

mov al,byte[edx]
mov bl,byte[ecx]
mov byte[edx],0
mov byte[ecx],0
mov ah,0
mov bh,0
mov byte[edx],bl
mov byte[ecx],al
jmp s3

print:
mov eax,4
mov ebx,1
mov ecx,m3
mov edx,l3
int 80h

mov edx,array1
l:
push edx
mov al,byte[edx]
mov ah,0
mov bl,10
div bl
mov byte[d1],al
mov byte[d2],ah
add byte[d1],30h
add byte[d2],30h
mov eax,4
mov ebx,1
mov ecx,d1
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,d2
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,newl
mov edx,1
int 80h
pop edx
add edx,1
sub byte[n3],1
cmp byte[n3],0
jne l
exit:
mov eax,1
mov ebx,0
int 80h



