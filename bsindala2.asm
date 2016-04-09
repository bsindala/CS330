	%include "along32.inc"

	;; Boniface Sindala
	;; CS330
	;; Programming Assignment 2
	;; Program to read in N integers and compute the average.
	;; Displays how many integers were read and their average.
	;; Zero (0) shows end of integers and the zero (0) is not counted.
	;; Compile: nasm bsindala2.asm -o bsindala2.o -f elf32
	;; Link:    ./asm32 bsindala2
	;; Run:     ./bsindala2

	section .data
	val      dq       0
	fpval    dq       0.0
	four     dq       4
	msg1     dq       "Enter integer values, end by entering a 0: ", 10, 13, 0
	msg2     dq       "The integers entered are: ", 10, 13, 0
	msg3     dq       "The average is: ", 10, 13, 0
	msg4     dq       "Error! Please enter a valid integer. ", 10, 13, 0

	section .bss
	count    resq     1	; Declare count
	sum1     resq     1	; Declare the sum

	section .text

	global main

main:
	call Clrscr		; Clear screen
	mov ecx, 0		; Initialize ecx
	mov [count], ecx	; Initialize count
	mov [sum1], ecx		; Initialize sum

firstInt:
	mov edx, msg1		; Move msg1 to edx
	call WriteString	; Write msg1 to console
	call ReadInt		; Read integer
	jz errorMsg		; Jump to error if firstInt is 0
	inc ecx			; Increment count
	add [sum1], eax		; Add integer to sum
	jnz intLoop		; Jump to intLoop if not 0

errorMsg:
	call Clrscr		; Clear screen
	mov edx, msg4		; Move msg4 to edx
	call WriteString	; Write msg4 to console
	call Crlf		; Next line
	call Crlf		; Next line
	jmp firstInt		; Jump back to firstInt

intLoop:
	call ReadInt		; Read integer
	inc ecx			; Increment count
	add [sum1], eax		; Add integers to sum1
	cmp eax, 0		; Compare eax and 0
	jnz intLoop		; Loop for next integer if not 0
	dec ecx			; Decrement count if eax is 0
	mov [count], ecx	; Move ecx number to count
	jmp count1		; Jump to count1

count1:
	call Crlf		; Next line
	mov eax, [count]	; Move count to eax
	mov edx, msg2		; Move msg2 to edx
	call WriteString	; Write msg2 to console
	call WriteInt		; Write eax to console
	call Crlf		; Next line
	call Crlf 		; Next line
	jmp average		; Jump to average

average:
	mov eax, [sum1] 	; Move sum1 to eax
	cdq			; Sign extend eax into edx for division
	mov ebx, [count]	; Move count to ebx
	idiv ebx		; Divide eax by edx
	mov edx, msg3		; Move msg3 to edx
	call WriteString	; Write msg3 to console
	call WriteInt 		; Write eax to console
	call Crlf		; Next line
	call Crlf 		; Next line

	call ExitProc
