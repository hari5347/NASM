section .data

msg1:db "Enter the string:"
size1: equ $-msg1
msg2:db "Vowel Count:"
size2:equ $-msg2
msg3:db 10

section .bss

string: resb 100
temp: resb 1
count: resw 1
num: resw 1
nod: resb 1


section .text
global _start:

_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h


call read_string

count_vowels:

mov ebx,string
pusha

loop_count:

cmp byte[ebx],0
je end_count

A:
cmp byte[ebx],'A'
jne E
add word[count],1
E:
cmp byte[ebx],'E'
jne I
add word[count],1
I:
cmp byte[ebx],'I'
jne O
add word[count],1
O:
cmp byte[ebx],'O'
jne U
add word[count],1
U:
cmp byte[ebx],'U'
jne a
add word[count],1
a:
cmp byte[ebx],'a'
jne e
add word[count],1
e:
cmp byte[ebx],'e'
jne i
add word[count],1
i:
cmp byte[ebx],'i'
jne o
add word[count],1
o:
cmp byte[ebx],'o'
jne u
add word[count],1
u:
cmp byte[ebx],'u'
jne incr
add word[count],1
incr:
inc ebx
jmp loop_count

end_count:

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h

mov dx,word[count]
mov word[num],dx
call print_num

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,1
int 80h

popa
 
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
