TITLE Program01     (program01.asm)

; Author: Matt Nutsch
; CS271 / Program01                 Date: 01/13/2017
; Description: This program will introduce the programmer, 
; get two values from the user, perform a calculation, and report the result.

INCLUDE Irvine32.inc

;constants
MULTIPLE_FACTOR = 7

.data

;variables
userName	BYTE	33 DUP(0)	;string to be entered by the user
userInput	DWORD	?			;integer to be entered by the user
userInput_2	DWORD	?			;integer to be entered by the user
mathResult	DWORD	?			;integer to store results
mathResult_2	DWORD	?			;integer to store results
intro_1		BYTE	"Hi. I was written by Matt Nutsch.", 0
prompt_1	BYTE	"What's your name? ", 0
prompt_2	BYTE	"Enter a number: ", 0
prompt_3	BYTE	"Enter another number: ", 0
result_1	BYTE	"The result of multiplication is ", 0
result_3	BYTE	"The result of addition is ", 0
result_4	BYTE	"The result of subtraction is ", 0
result_5	BYTE	"The remainder from division is ", 0
result_6	BYTE	"The quotient from division is ", 0
string_1	BYTE	"Adding the numbers ", 0
string_2	BYTE	"Subtracting the numbers ", 0
string_3	BYTE	"Multiplying the numbers ", 0
string_4	BYTE	"Dividing the numbers ", 0
string_5	BYTE	" and ", 0

result_2	BYTE	"!", 0
goodBye		BYTE	"Goodbye ", 0

.code
main PROC

;introduce programmer
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLF

;get user name
	mov		edx, OFFSET prompt_1
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString

;get user value 1
	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov		userInput, eax

;get user value 2
	mov		edx, OFFSET prompt_3
	call	WriteString
	call	ReadInt
	mov		userInput_2, eax

;announcing addition
	mov		edx, OFFSET string_1
	call	WriteString
	mov		eax, userInput
	call	WriteDec
	mov		edx, OFFSET string_5
	call	WriteString
	mov		eax, userInput_2
	call	WriteDec
	call	CrLf

;sum - ADD
	mov		eax, userInput
	mov		ebx, userInput_2
	add		eax, ebx
	mov		mathResult, eax

;report add result
	mov		edx, OFFSET result_3
	call	WriteString
	mov		eax, mathResult
	call	WriteDec
	mov		edx, OFFSET result_2
	call	WriteString
	call	CrLf
	call	CrLf

;announcing subtraction
	mov		edx, OFFSET string_2
	call	WriteString
	mov		eax, userInput
	call	WriteDec
	mov		edx, OFFSET string_5
	call	WriteString
	mov		eax, userInput_2
	call	WriteDec
	call	CrLf

;subtract - SUB
	mov		eax, userInput
	mov		ebx, userInput_2
	sub		eax, ebx 
	mov		mathResult, eax

;report sub result
	mov		edx, OFFSET result_4
	call	WriteString
	mov		eax, mathResult
	call	WriteDec
	mov		edx, OFFSET result_2
	call	WriteString
	call	CrLf
	call	CrLf

;announcing multiplication
	mov		edx, OFFSET string_3
	call	WriteString
	mov		eax, userInput
	call	WriteDec
	mov		edx, OFFSET string_5
	call	WriteString
	mov		eax, userInput_2
	call	WriteDec
	call	CrLf

;multiply
	mov		eax, userInput
	mov		ebx, userInput_2
	mul		ebx
	mov		mathResult, eax

;report mult result
	mov		edx, OFFSET result_1
	call	WriteString
	mov		eax, mathResult
	call	WriteDec
	mov		edx, OFFSET result_2
	call	WriteString
	call	CrLf
	call	CrLf

;announcing division (modulus)
	mov		edx, OFFSET string_4
	call	WriteString
	mov		eax, userInput
	call	WriteDec
	mov		edx, OFFSET string_5
	call	WriteString
	mov		eax, userInput_2
	call	WriteDec
	call	CrLf

;divide (remainder) DIV
	mov		edx, 0
	mov		eax, userInput
	cdq
	mov		ebx, userInput_2
	cdq		
	div		ebx
	mov		mathResult, edx ;remainder
	mov		mathResult_2, eax ;quotient

;report div result
	mov		edx, OFFSET result_6
	call	WriteString
	mov		eax, mathResult_2
	call	WriteDec
	mov		edx, OFFSET result_2
	call	WriteString
	call	CrLf

	mov		edx, OFFSET result_5
	call	WriteString
	mov		eax, mathResult
	call	WriteDec
	mov		edx, OFFSET result_2
	call	WriteString
	call	CrLf
	call	CrLf

;say good-bye
	mov		edx, OFFSET goodBye
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
