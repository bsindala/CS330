	%include "along32.inc"

	;; ****************************************************************;;
	;; Boniface Sindala                                                ;;
	;; CS330                                                           ;;
	;; Dr. Ragib Hassan                                                ;;
	;; Programming Assignment 4                                        ;;
	;; November 10, 2015                                               ;;
	;; The Program is to read in N integers, terminated by a zero.     ;;
	;; The Program will then sort the integers in ascending order.     ;;
	;; The Program will give an error if no valid integer entered.     ;;
	;; The Program will give an error if there is an overflow.         ;;
        ;; Compile: nasm bsindala4.asm -o bsindala4.o -f elf32             ;;
	;; Link:    ./asm32 bsindala4                                      ;;
	;; Run:     ./bsindala4                                            ;;
	;; ****************************************************************;;

	section .data

	val      dq        0
	fpval    dq        0.0
	four     dq        4
	msg1     dq        "Enter integer values (positive or negative), end by entering a zero(0): ", 10, 13, 0
	msg2     dq        "The sorted order for integer values entered: ", 10, 13, 0
	msg3     dq        "Error! Please enter a valid integer.", 10, 13, 0
	msg4     dq        "Error (Overflow) ! Numbers entered exceed required size.", 10, 13, 0

	myArray times 100 dq 0	;Define array with a 100 elements all set to 0

	section .bss

	section .text

	global main

main:
	call Clrscr		        	;Clear the screen
	mov ecx, 0				;Initialize the ecx register
	mov ebx, 0				;Initialize the ebx register

firstInt:
         mov edx, msg1                	       ; Move the msg1 to edx register
         call WriteString             	       ; Writes the string output
         call ReadInt                          ; Reads in the integer input
         jz errorMsg                   	       ; Jump to errorMsg if integer is 0
         mov [myArray + (ecx * 4)], eax        ; Add integer to array
         inc ecx                               ; Increment count
         jnz integerLoop                       ; Jump to integerLoop

integerLoop:
         call ReadInt                          ; Reads in the integer input
         cmp ecx, 100                          ; Compare count to 100
         jg errorMsg2                          ; Jump to error if greater than 100
         cmp eax, 0                            ; Compare the integer to 0
         jz loopCount                          ; Display array
         mov [myArray + (ecx * 4)], eax        ; Add integer to array
         inc ecx                               ; Increment count
         jnz integerLoop                       ; Loop integerLoop

errorMsg:
         call Clrscr                           ; Clear the screen
         mov edx, msg3                         ; Move the msg3 to edx register
         call WriteString                      ; Writes the string output
         call Crlf                             ; Go to next line
         call Crlf                             ; Go to next line
         jmp firstInt                          ; Jump to firstInt

errorMsg2:
         call Crlf                             ; Go to the next line
         mov edx, msg4                         ; Move the msg4 to edx register
         call WriteString                      ; Write the string output
         call Crlf                             ; Go to next line
         call Crlf                             ; Go to next line
         jmp finish                            ; Jump to finish

loopCount:
         cmp ecx, 1                            ; Compare ecx to 1
         je dispOneElement                     ; Jump to one element if equal
         jl errorMsg                           ; Jump to errorMsg if less than one
         push ecx                              ; For numbers to print
         dec ecx                               ; decrement count

loopCount2:
         push ecx                              ; For the outer loop count
         mov ebx, 0                            ; ebx initialized to 0 for 0 based indexing

sortArray:
         mov eax, [myArray + (ebx * 4)]        ; Moves array value at current
         cmp [myArray + (ebx * 4) + 4], eax    ; Compares next value of array
         jg greaterLoop                        ; If greater it jumps to greaterLoop
         xchg eax, [myArray + (ebx * 4) + 4]   ; If less, exchanges the elements
         mov [myArray + (ebx * 4)], eax        ; Moves new value to current position

greaterLoop:
         inc ebx                               ; Increment ebx in order to iterate through array
         loop sortArray                        ; Loops the sorting array for next value
         pop ecx                               ; Pops the ecx previously pushed to reset counter
         loop loopCount2                       ; Loop the loop count2

setDisplay:
         mov ebx, 0                            ; Resets ebx
         pop ecx                               ; Pops the current ecx counter to determin number of WriteInt iterations
         call Crlf                             ; Go to the next line
         mov edx, msg2                         ; Move the msg2 to edx register
         call WriteString                      ; Write the string output

dispArray:
         mov eax, [myArray + (ebx)]            ; Move array values to eax
         call Crlf                             ; Go to the next line
         call WriteInt                         ; Write the integer
         add ebx, 4                            ; Add 4 to the ebx for next element
         loop dispArray                        ; Loop the display array function
         call Crlf                             ; Go to next line
         jmp finish                            ; Jump to finish

dispOneElement:
         call Crlf                             ; Go to next line
         mov edx, msg2                         ; Move the msg2 to edx register
         call WriteString                      ; Write the string output
         mov eax, [myArray + (ebx)]            ; Move array values to eax
         call Crlf                             ; Go to next line
         call WriteInt                         ; Write the integer
         call Crlf                             ; Go to the next line
         jmp finish                            ; Jump to finish

finish:
         call Crlf                             ; Go to next line
         int 80h                               ; Exit the process
	
