section .data
msg1:db "Enter rows size: "
len1:equ $-msg1
msg2:db "Enter columns size: "
len2:equ $-msg2
msg3:db "Enter the elements: ",0ah
len3:equ $-msg3
msg4:db "Rotated by 90 matrix is: ",0ah
len4:equ $-msg4
space:db ' '
newline:db 10
	
section .bss
num:resw 1
i:resb 1
j:resb 1
m:resb 1
n:resb 1
temp:resb 1
nod:resb 1
array:resb 100
num1:resb 1

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
call read_num
mov al,byte[num]
mov byte[m],al
	
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
call read_num
mov al,byte[num]
mov byte[n],al
	
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
	
mov ebx,array
mov byte[i],0
	
while1:
mov byte[j],0
while2:
push ebx
call read_num
mov dl,byte[num]
pop ebx
mov eax,0
mov al,byte[i]
mov cl,byte[n]
mul cl
add al,byte[j]
mov ecx,ebx
add ecx,eax
mov byte[ecx],dl
inc byte[j]
mov al,byte[n]
cmp byte[j],al
jb while2

inc byte[i]
mov al,byte[m]
cmp byte[i],al
jb while1
	
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h
			
mov ebx,array
mov byte[j],0
while5:
mov al,byte[m]
dec al
mov byte[i],al
while6:
push ebx
mov eax,0
mov al,byte[i]
mov cl,byte[n]
mul cl
add al,byte[j]
mov ecx,ebx
add ecx,eax
mov al,byte[ecx]
mov byte[num],al
call print_num
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
pop ebx
dec byte[i]
cmp byte[i],0
jge while6
push ebx
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
pop ebx
inc byte[j]
mov al,byte[n]
cmp byte[j],al
jb while5
	
mov eax,1
mov ebx,0
int 80h
		
read_num:
	pusha
	mov word[num], 0
	loop_read:
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	cmp byte[temp],10
	sete al
	cmp byte[temp],' '
	sete bl
	or al,bl
	cmp al,1
	je end_read
	mov ax, word[num]
	mov bx, 10
	mul bx
	mov bl,byte[temp]
	sub bl,30h
	mov bh,0
	add ax,bx
	mov word[num],ax
	jmp loop_read
	end_read:
	popa
	ret


print_num:
pusha
cmp word[num], 0
jne go
add word[num], 30h
mov eax, 4
mov ebx, 1
mov ecx, num
mov edx, 2
int 80h
popa
ret
go:
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print_no
end_print:
popa		
ret
	
	

