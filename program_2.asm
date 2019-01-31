TITLE Program 2     (program_2.asm)

; Author: Robert Pfingsten
; Last Modified: 1/25/19
; OSU email address: pfingstr@oregonstate.edu
; Course number/section: 271
; Project Number: 2                 Due Date: 1/27/19
; Description:	OBJECTIVES	
;	1) Getting string input
;	2) Designing and implementing a counted loop
;	3) Designing and implementing a post-test loop
;	4) Keeping track of a previous value
;	5) Implementing data validation
;				REQUIREMENTS	
;	1) The programmer’s name and the user’s name must appear in the output.
;	2) The loop that implements data validation must be implemented as a post-test loop.
;	3) The loop that calculates the Fibonacci terms must be implemented using the MASM loop instruction.
;	4) The main procedure must be modularized into at least the following sections (procedures are not required
;	this time):
;		a. introduction
;		b. userInstructions
;		c. getUserData
;		d. displayFibs
;		e. farewell
;	5) Recursive solutions are not acceptable for this assignment. This one is about iteration.
;	6) The upper limit should be defined and used as a constant.
;	7) The usual requirements regarding documentation, readability, user-friendliness, etc., apply.
;	8) Submit your text code file (.asm) to Canvas by the due date.

INCLUDE Irvine32.inc

;(insert constant definitions here)

.data
;output data
output_my_name					BYTE		"ROBERT PFINGSTEN ", 0   
output_title					BYTE		"PROGRAM #2", 0
output_greeting					BYTE		"HELLO ", 0
output_instruction				BYTE		"PLEASE ENTER AN INTEGER [1..46] AND I WILL DISPLAY THAT NUMBER OF FIBONACCI TERMS: ", 0
output_what_name				BYTE		"WHAT IS YOUR NAME?: ", 0
output_exit						BYTE		"GOODBYE", 0															
output_error_low				BYTE		"ERROR! - THE NUMBER ENTERED IS TOO LOW ", 0
output_error_high				BYTE		"ERROR! - THE NUMBER ENTERED IS TOO HIGH ", 0
output_space					BYTE		" ", 0
output_fib_one					BYTE		"1", 0
output_fib_two					BYTE		"1 1", 0

;constants
upper_bound equ 46
lower_bound equ 1
MAX = 80

;input data
input_fib_num					DWORD		?
input_user_name					BYTE MAX+1 DUP (?) 

;initalized values
n_minus_1						DWORD		?
n_minus_2						DWORD		?



.code
main PROC
;Display your name 
	mov		edx, OFFSET output_my_name
	call	WriteString

;and program title.
	mov		edx, OFFSET output_title
	call	WriteString
	call	CrLf

;Ask user for name
	mov		edx, OFFSET output_what_name
	call	WriteString

;read the name
	mov		edx, OFFSET input_user_name
    mov		ecx, MAX            ;buffer size - 1
    call	ReadString

;Display greeting and name for the user.
	mov		edx, OFFSET output_greeting
	call	WriteString
	mov		edx, OFFSET input_user_name
	call	WriteString
	call	CrLf

Top:
;Display instructions for the user.
	mov		edx, OFFSET output_instruction
	call	WriteString
	call	CrLf

;read the number
	call	ReadInt
	mov		input_fib_num, eax
	call	CrLf
	   
;validate user data using post test loop for bounds
	cmp     eax, upper_bound
	jg      UpperBoundError			;jump if destination > source	
	cmp     eax, lower_bound
	jl		LowerBoundError			;jump if destination < source	
	je       FibOne				;jump if destination = source
	cmp      eax, 2
	je       FibTwo				;jump if destination = source

;For n > 2 print first 2 values
	mov     ecx, input_fib_num
	mov     eax, 1
	call    WriteDec
	dec     ecx
	mov     edx, OFFSET output_space
	call    WriteString
	call    WriteDec
	dec     ecx
	mov     edx, OFFSET output_space
	call    WriteString
	mov		n_minus_1, 1
	mov		n_minus_2, 1
	

FibonacciLoop:	
	 
	add		eax, n_minus_2
	mov		edx, n_minus_1
	mov		n_minus_2, edx
	mov		n_minus_1, eax	
	call    WriteDec
	mov     edx, OFFSET output_space
	call    WriteString
	loop	FibonacciLoop
	jmp		EndOfProgram

UpperBoundError:
	mov		edx, OFFSET output_error_high
	call	WriteString
	jmp		Top

LowerBoundError:
	mov		edx, OFFSET output_error_low
	call	WriteString
	jmp		Top

FibOne:
	mov		edx, OFFSET output_fib_one
	call	WriteString
	jmp		EndOfProgram

FibTwo:
	mov		edx, OFFSET output_fib_two
	call	WriteString
	jmp		EndOfProgram

EndOfProgram:
	call	CrLf
	mov		edx, OFFSET output_exit
	call	WriteString
	call	CrLf
exit									;exit to operating system
main ENDP
END main
