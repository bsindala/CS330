	%include "along32.inc"

	;; Boniface Sindala
	;; CS330
	;; Programming Assignment 1
	;; This program reads in two integers, A and B
	;; and computes A * B + (A + B) / (A - B)
	;; Compile: nasm bsindala1.asm -o bsindala1.o -f elf32
	;; Link:    ./asm32 bsindala1
	;; Run:     ./bsindala1

	segment .data

	msg1 dq "Enter the first integer: ", 10, 13, 0
	msg2 dq "Please enter the second integer: ", 10, 13, 0
	msg3 dq "The sum (A+B) is: ", 10, 13, 0
	msg4 dq "The difference (A-B) is: ", 10, 13, 0
	msg5 dq "The product (A*B) is: ", 10, 13, 0
	msg6 dq "The quotient of (sum / difference) is: ", 10, 13, 0
	msg7 dq "FINAL ANSWER (A * B + (A + B) / (A - B)): ", 10, 13, 0
	msg8 dq "Error! The difference of the integers is zero. ", 10, 13, 0

	section .bss

	num1  resq 1		; First integer
	num2  resq 1		; Second integer
	sum1  resq 1 		; Summation of A + B
	diff1 resq 1 		; Difference of A - B
	prod1 resq 1 		; Product of A * B
	quot1 resq 1 		; Quotient of A / B
	final resq 1 		; Final answer A * B + (A + B) / (A - B)

	section .text

	global main

main:
	call Clrscr		; Clear Screen
	mov ecx, 0  		; ECX initialized to zero
        mov eax, ecx		; EAX initialized to zero
        mov [sum1], ecx         ; Initialize sum1
        mov [diff1], ecx        ; Initialize diff1
        mov [prod1], ecx        ; Initialize prod1
	mov [quot1], ecx	; Initialize quot1
	mov [final], ecx	; Initialize final

firstInt:	
	mov edx, msg1		; Move msg1 to edx
	call WriteString	; Write string to output
	call Crlf		; Next line
	call ReadInt		; Reads in the integer input
	mov [num1], eax		; Move the integer to num1
	call Crlf		; Next line

secondInt:
	mov edx, msg2 		; Move msg2 to edx
	call WriteString	; Write string to output
	call Crlf		; Next line
	call ReadInt		; Reads in the integer input
	cmp eax, [num1]		; Compare first and second integers
	je errorMsg		; Jump to error if equal
	mov [num2], eax		; Move the integer to num2
	call Crlf		; Next line

summation:
	mov edx, msg3		; Move msg3 to edx
	call WriteString      	; Write string to output
	call Crlf		; Next line
	mov eax, [num1]		; Move num1 to eax
	add eax, [num2]		; Do summation
	call WriteInt		; Write Integer to console
	mov [sum1], eax		; Move result to sum1
	call Crlf		; Next line

difference:
	mov edx, msg4		; Move msg4 to edx
	call WriteString      	; Write string to output
	call Crlf		; Next line
	mov eax, [num1]		; Move num1 to eax
	sub eax, [num2]		; Divide eax by num2
	jz errorMsg		; Jump to error if difference is 0
	call WriteInt		; Write integer to console
	mov [diff1], eax	; Move eax to diff1
	call Crlf		; Next line

product:
	mov edx, msg5		; Move msg5 to edx
	call WriteString      	; Write string to output
	call Crlf		; Next line
	mov eax, [num1]		; Move num1 to eax
	imul eax, [num2] 	; Multiply eax by num2
	call WriteInt		; Write integer to console
	mov [prod1], eax	; Move eax to prod1
	call Crlf		; Next line

quotient:
	mov edx, msg6		; Move msg6 to edx
	call WriteString      	; Write string to output
	call Crlf		; Next line
	cdq			; Sign extend eax to edx for division
	mov ebx, [diff1]	; Move diff1 to ebx
	mov eax, [sum1]		; Move sum1 to eax
	idiv ebx  		; Divide eax by ebx
	call WriteInt		; Write integer to console
	mov [quot1], eax	; Move eax to quot1
	call Crlf		; Next line
	call Crlf		; Next line

finalAnswer:
	mov edx, msg7   	; Move msg7 to edx
	call WriteString      	; Write string to output
	call Crlf		; Next line
	mov eax, [prod1]	; Move prod1 to eax
	add eax, [quot1]	; Add prod1 and quot1
	call WriteInt		; Write integer to console
	mov [final], eax	; Move eax to final
	call Crlf		; Next line
	call Crlf		; Next line
	
	call ExitProc		; Exit

errorMsg:
	call Crlf		; Next line
	mov edx, msg8 		; Move msg8 to edx
	call WriteString	; Write string to console
	call Crlf		; Next line
	call Crlf		; Next line
	jmp firstInt		; Jump to firstInt
