	%include "along32.inc"
	
	;; ****************************************************************;;
	;; Boniface Sindala                                                ;;
	;; CS330                                                           ;;
	;; Dr. Ragib Hassan                                                ;;
	;; Programming Assignment 5                                        ;;
	;; December 1, 2015                                                ;;
	;; For the equation AX^2 + BC + C = 0                              ;;
	;; the program uses the quadratic equation to compute              ;;
	;; the value X, given A, B, and C.                                 ;;
	;; The program uses floating point math.                           ;;
        ;; Compile: nasm bsindala5.asm -o bsindal5.o -f elf32              ;;
	;; Link:    ./asm32 bsindala5                                      ;;
	;; Run:     ./bsindala5                                            ;;
	;; ****************************************************************;;

	section .data

	fmt1       db    "%lf", 0
	fmt2       db    10,"Val: %lf", 10
	a          dq    0
	b          dq    0
	c          dq    0
	bs         dq    0
	temp       dq    0
	ac         dq    0
	d          dq    0
	msg1       dq    "Enter the three values and press enter: ", 10, 13, 0
	msg2       dq    "There is no real solution, (Solution is imaginery)!", 10, 13, 0

	section .text

	global main

	extern printf
	extern scanf

getfloat:
	push ebp		; Push the base pointer into the stack
	mov ebp, esp		; Move the stack pointer to the base pointer
	sub esp, 8		; Subtract 8 bytes from the stack pointer
	lea eax, [ebp - 8]	; Load Effeective Address for memory address calculations
	push eax		; Push eax onto stack
	push fmt1		; Format the value to float
	call scanf		; Call scanf
	add esp, 8		; Add 8 bytes to stack pointer

	fld qword [ebp - 8] 	; Load value on a stack
	mov esp, ebp		; Move the base pointer to the stack pointer
	pop ebp			; Pop the base pointer
	ret			; Return statement

putfloat:
	push ebp 		; Push the base pointer
	mov ebp, esp		; Move the stack pointer to the base pointer
	sub esp, 8		; Subtract 8 bytes from the stack pointer
	fst qword [ebp - 8] 	; Store the real number in the memory allocated
	push fmt2 		; Format value to float
	call printf		; Call printf
	add esp, 12		; Add 12 bytes to stack pointer
	mov esp, ebp 		; Move the base pointer to the stack pointer
	pop ebp 		; Pop the base pointer
	ret 			; Return statement

main:
	call Crlf		; Go to next line
	mov edx, msg1		; Move the msg1 to edx
	call WriteString	; Writes the string output
	call getfloat		; Call function getfloat
	call getfloat		; Call function getfloat
	call getfloat		; Call function getfloat
	mov dword[temp], 0	; Initialize the temp variable
	fxch st2		; Exchange registers
	fild dword[temp]	; Load the temp value
	fadd st0, st2		; Add values on stack 0 and 2
	fmul st0, st0		; Multiply the sum by itself
	fxch st3		; Exchange registers
	fmul st0, st1		; Multiply the product on stack 0 and value on stack 1
	fadd st0, st0		; Add the product with itself
	fadd st0, st0		; Add the sum with itself
	fsub st3, st0		; Subtract value on stack 0 from stack 3
	fxch st3		; Exchange registers
	ftst			; Compare stack 0 to 0
	fstsw ax		; ax = status word
	sahf			; Flags = ah
	jb noRealSolution	; Call noRealSolution if less than 0
	fsqrt 			; Square root the sum
	mov dword[temp], 0	; Initialize the temp
	fild dword[temp]	; Add the temp value to the stack
	fsub st0, st3		; Subtract value on stack 3 from stack 0
	fsub st0, st1		; Subtract value on stack 1 from stack 0
	mov dword[temp], 2	; Move 2 to temp
	fild dword[temp] 	; Add the temp value to the stack
	fmul st0, st3		; Multiply value in stack 3 with stack 0
	fdiv st1, st0		; Divide value in stack 0 from stack 1
	fxch st1		; Exhange registers
	call putfloat		; Call putfloat
	fmul st0, st1		; Multiply value in stack 0 with stack 1
	fadd st0, st2		; Add value in stack 0 with stack 2
	fadd st0, st2		; Add value in stack 0 with stack 2
	fdiv st0, st1		; Divide value in stack 0 with stack 1
	call putfloat		; Call putfloat
	call Crlf		; Go to next line

exit:
	mov eax, 1		; Initialize eax to 1
	int 80h			; Interrupt

noRealSolution:
	call Crlf		; Go to next line
	mov edx, msg2		; Move msg2 to edx
	call WriteString 	; Write the string to console
	call Crlf		; Go to next line
	call Crlf 		; Go to next line
	call exit		; Exit Program
