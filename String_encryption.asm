section .data

msg1:db "Enter the string:"
size1: equ $-msg1
msg2:db 10
msg3:db "Output:"
size3:equ $-msg3
section .bss

string: resb 100
len:resw 1
temp resb 1
section .text
global _start:

_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h


call read_string

Encode:

mov ebx,string
pusha

loop_encode:


cmp byte[ebx],0
je end_loop

cmp byte[ebx],'A'
jb lo

cmp byte[ebx],'z'
ja lo

cmp byte[ebx],'z'
je z

cmp byte[ebx],'Z'
je Z

cmp byte[ebx],'Z'
jna inc

cmp byte[ebx],'a'
jb lo

inc:

add byte[ebx],1
jmp lo


z:
mov byte[ebx],'a'
jmp lo

Z:
mov byte[ebx],'A'
jmp lo

lo:
inc ebx

jmp loop_encode

end_loop:
popa 

mov eax,4
mov ebx,1
mov ecx,string
mov edx,100
int 80h

mov eax,1
mov ebx,0
int 80h

read_string:

mov ebx,string
pusha

loop_read:

push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx

cmp byte[temp],10
je end_read

mov al,byte[temp]
mov byte[ebx],al

inc word[len]
inc ebx
jmp loop_read

end_read:
mov byte[ebx],0
popa
ret
