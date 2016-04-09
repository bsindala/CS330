	%include "along32.inc"

	;; Boniface Sindala
	;; CS330
	;; Dr. Ragib Hassan
	;; 
	;; Programming Assignment 3
	;; 
	;; Program to reads in a 32 bit value in hexadecimal.
	;; Prints 1) The position of the least significant 1 bit set.
	;;        2) The position of the most significant 1 bit set.
	;;        3) The total number of 1 bit sets.
	;; 
	;; Compile: nasm bsindala3.asm -o bsindala3.o -f elf32
	;; Link:    ./asm32 bsindala3
	;; Run:     ./bsindala3

	section .data

	msg1 : db "Enter a 32 bit hexadecimal value: ", 0
	msg2 : db "Position of least significant 1 bit set: ", 0
	msg3 : db "Position of most significant 1 bit set: ", 0
	msg4 : db "The total number of 1 bit sets: ", 0

	section .text

	global main

main:
	mov edx, msg1		; Move msg1 to edx
	call WriteString 	; Write msg1 console
	call ReadHex		; Read hexadecimal
	push eax		; Push value of eax

	bsf eax, eax		; Searches for LSB in eax
	mov edx, msg2		; Move msg2 to edx
	call WriteString	; Write msg2 to console
	call WriteInt		; Prints LSB to console
	call Crlf		; New line

	pop eax			; Restores value of eax
	push eax		; Stores value of eax again
	bsr eax, eax		; Searches of MSB in eax
	mov edx, msg3		; Move msg3 to edx
	call WriteString	; Write msg3 to console
	call WriteInt		; Prints MSB to console
	call Crlf		; New line

	pop eax			; Restores the value of eax
	mov ecx, 0		; Initialize ecx

loopBit:			; Find count of total 1 bit sets
	test eax, eax		; Does "mental" bitwise AND of eax with itself, without altering eax
	jz exit			; If eax AND eax sets 0 flag, jumps to exit
	mov ebx, eax		; Move eax to ebx
	dec ebx			; Decrement ebx
	and eax, ecx		; AND operation on eax and ebx, eax decremented by 1
	inc ecx			; Increments ecx (Count)
	jmp loopBit		; Loop back

exit:
	mov eax, ecx		; Move count to eax
	mov edx, msg4		; Move msg4 to edx
	call WriteString	; Write msg4 to console
	call WriteInt		; Print number of 1 bit sets
	call Crlf		; New line
	int 80h			
