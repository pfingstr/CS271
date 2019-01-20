TITLE Program 1     (program_1.asm)

; Author: Robert Pfingsten
; Last Modified: 1/19/19
; OSU email address: pfingstr@oregonstate.edu
; Course number/section: 271
; Project Number: 1                 Due Date: 1/20/19
; Description:	Description:
; Write and test a MASM program to perform the following tasks:
; 1. Display your name and program title on the output screen.
; 2. Display instructions for the user.
; 3. Prompt the user to enter two numbers.
; 4. Calculate the sum, difference, product, (integer) quotient and remainder of the numbers.
; 5. Display a terminating message. 

INCLUDE Irvine32.inc

;(insert constant definitions here)

.data
;output data
output_name					BYTE		"ROBERT PFINGSTEN ", 0   
output_title					BYTE		"PROGRAM #1", 0
output_instruction				BYTE		"PLEASE ENTER 2 NUMBERS AND WE WILL DO SOME MATH WITH THEM : ", 0
output_num1					BYTE		"FIRST NUMBER : ", 0
output_num2					BYTE		"SECOND NUMBER : ", 0
output_exit					BYTE		"GOODBYE", 0															
output_equals					BYTE		" = ", 0
output_sum					BYTE		" + ", 0
output_difference				BYTE		" - ", 0
output_product					BYTE		" * ", 0
output_quotient					BYTE		" / ", 0
output_remainder				BYTE		" REMAINDER", 0
output_error					BYTE		"ERROR", 0
;input data
input_num1					DWORD		?
input_num2					DWORD		?
;calculated values
calc_sum					DWORD		?
calc_difference					DWORD		?
calc_product					DWORD		?
calc_quotient					DWORD		?
calc_remainder					DWORD		?


.code
main PROC
;Display your name 
	mov edx, OFFSET output_name
	call WriteString

;and program title.
	mov edx, OFFSET output_title
	call WriteString
	call CrLf

;Display instructions for the user.
	mov edx, OFFSET output_instruction
	call   WriteString
	call   CrLf

;Prompt the user to enter two numbers.
;prompt the user to enter first number
	mov edx, OFFSET output_num1
	call WriteString

;read the first number
	call ReadInt
	mov input_num1, eax
	call CrLf

;prompt the user to enter second number
	mov edx, OFFSET output_num2
	call WriteString
	
   
;read the second number
	call ReadInt
	mov input_num2, eax
	mov eax, input_num2
	call CrLf

;compare the numbers
	cmp eax, input_num1
	jg Error
	jle Math

Error:
;print the error message
	mov edx, OFFSET output_error
	call WriteString
	call CrLf

;jump to end_of_program
	jg end_of_program

Math:
;calculate sum
	mov eax, input_num1
	add eax, input_num2
	mov calc_sum, eax

;calculate difference
	mov eax, input_num1
	sub eax, input_num2
	mov calc_difference, eax

;calculate product
	mov eax, input_num1
	mov ebx, input_num2
	mul ebx
	mov calc_product, eax

;calculate quotient and remainder
	mov edx, 0
	mov eax, input_num1
	cdq
	mov ebx, input_num2
	cdq
	div ebx
	mov calc_quotient, eax
	mov calc_remainder, edx

;print sum
	mov eax, input_num1
	call WriteDec
	mov edx, OFFSET output_sum
	call WriteString
	mov eax, input_num2
	call WriteDec
	mov edx, OFFSET output_equals
	call WriteString
	mov eax, calc_sum
	call WriteDec
	call CrLf

;print difference
	mov eax, input_num1
	call WriteDec
	mov edx, OFFSET output_difference
	call WriteString
	mov eax, input_num2
	call WriteDec
	mov edx, OFFSET output_equals
	call WriteString
	mov eax, calc_difference
	call WriteDec
	call CrLf

;print product
	mov eax, input_num1
	call WriteDec
	mov edx, OFFSET output_product
	call WriteString
	mov eax, input_num2
	call WriteDec
	mov edx, OFFSET output_equals
	call WriteString
	mov eax, calc_product
	call WriteDec
	call CrLf

;print quotient
	mov eax, input_num1
	call WriteDec
	mov edx, OFFSET output_quotient
	call WriteString
	mov eax, input_num2
	call WriteDec
	mov edx, OFFSET output_equals
	call WriteString
	mov eax, calc_quotient
	call WriteDec
	mov edx, OFFSET output_remainder
	call WriteString
	mov edx, OFFSET output_equals
	call WriteString
	mov eax, calc_remainder
	call WriteDec
	call CrLf

end_of_program:
	call CrLf
	mov edx, OFFSET output_exit
	call WriteString
	call CrLf

exit	; exit to operating system
main ENDP
; (insert additional procedures here)
END main
