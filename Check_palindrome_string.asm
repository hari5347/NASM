section .data

msg1:db "Enter the string:"
size1: equ $-msg1
msg2:db 10
msg3:db "Palindrome"
size3: equ $-msg3
msg4:db "Not Palindrome"
size4: equ $-msg4


section .bss

string: resb 100
temp: resb 1
count: resw 1
num: resw 1
nod: resb 1
len:resw 1
len1:resw 1
i:resw 1

section .text
global _start:

_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h


call read_string

mov dx,0
mov ax,word[len]
mov bx,2
div bx
mov word[len1],ax


palindrome_check:

mov ebx,string
mov ecx,string
sub word[len],1
movzx edx,word[len]
add ecx,edx

loop_pal:


mov dl,byte[ecx]
cmp dl,byte[ebx]
jne end_loop

inc ebx
dec ecx

inc word[i]
mov dx,word[len1]
cmp word[i],dx
jb loop_pal

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
int 80h

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,1
int 80h


mov eax,1
mov ebx,0
int 80h

end_loop:

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,size4
int 80h

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,1
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


print_num:

pusha
cmp word[num],0
jne go

mov eax,4
mov ebx,1
mov ecx,num
mov edx,2
int 80h

popa 
ret

go:

extract_no:

cmp word[num],0
je print_no

mov dx,0
inc byte[nod]
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_no

print_no:
cmp byte[nod],0
je end_print

dec byte[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

jmp print_no

end_print:

popa 
ret
