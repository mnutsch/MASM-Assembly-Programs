TITLE Program03     (program03_nutsch.asm)

; Author: Matt Nutsch
; CS271-400 / Program03                 
; Date: 2-8-2017
; Description:
; Write and test a MASM program to perform the following tasks: 
; 1. Display the program title and programmer’s name. 
; 2. Get the user’s name, and greet the user. 
; 3. Display instructions for the user. 
; 4. Repeatedly prompt the user to enter a number.  
; Validate the user input to be in [-100, -1] (inclusive).  
; Count and accumulate the valid user numbers until a non-negative 
; number is entered.  (The nonnegative number is discarded.) 
; 5. Calculate the (rounded integer) average of the negative numbers. 
; 6. Display: i. the number of negative numbers entered  
; (Note: if no negative numbers were entered, display a 
; special message and skip to iv.) ii. the sum of negative 
; numbers entered iii. the average, rounded to the nearest 
; integer (e.g. -20.5 rounds to -20) iv. a parting message 
; (with the user’s name) 

INCLUDE Irvine32.inc

;constants
UPPER_LIMIT = 0
LOWER_LIMIT = -101

.data

; variables
userName	BYTE	33 DUP(0)	;string to be entered by the user
userInput	DWORD	?			;integer to be entered by the user
programDesc	BYTE	"Welcome to the Integer Accumulator by Matt Nutsch.", 0
prompt_1	BYTE	"What's your name? ", 0
prompt_2a	BYTE	"Please enter numbers in [-100, -1].", 0
prompt_2b	BYTE	"Enter a non-negative number when you are finished to see results.", 0
prompt_2c	BYTE	"Enter number: ", 0
string_1	BYTE	"You entered ", 0
string_1b	BYTE	" valid numbers.", 0
string_2	BYTE	"The sum of your valid numbers is ", 0
string_3	BYTE	"The rounded average is ", 0
string_4	BYTE	"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ", 0
string_4b	BYTE	".", 0
invalidValue	BYTE	"Out of range. ", 0
inputCount	DWORD	?			;integer to track the number of values entered
inputSum	DWORD	?			;integer to hold total of values
inputAverage	DWORD	?			;integer to hold average of values
divRemainder	DWORD	?			;integer to hold the remainder

string_5	BYTE	"First check passed.", 0
string_6	BYTE	"Performing Calculations.", 0
string_7	BYTE	"The input sum is: ", 0
string_8	BYTE	"The user input is: ", 0
string_9	BYTE	"Decrementing the Average.", 0
string_10	BYTE	"The remainder from division is ", 0

string_11	BYTE	"Hello, ", 0

.code
main PROC

;initialize values
	mov		inputSum, 0
	mov		inputCount, 0
	mov		inputAverage, 0
	mov		userInput, 0

Introduction PROC
; output program title
	mov		edx, OFFSET programDesc
	call	WriteString
	call	CrLF
Introduction ENDP

UserInstructions PROC
; prompt for user's name
	mov		edx, OFFSET prompt_1
	call	WriteString
UserInstructions ENDP

GetUserData PROC
; read user's name 
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString
	
	;say hello
	mov		edx, OFFSET string_11
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLF

; prompt for the number from LOWER_LIMIT-UPPER_LIMIT
	mov		edx, OFFSET prompt_2a
	call	WriteString
	call	CrLF
	mov		edx, OFFSET prompt_2b
	call	WriteString
	call	CrLF

	jmp		WithinRange

PerformCalculations:
	;add value to the sum
	mov		eax, inputSum
	mov		ebx, userInput
	add		eax, ebx
	mov		inputSum, eax

	;increment the count
	mov		eax, inputCount
	mov		ebx, 1
	add		eax, ebx
	mov		inputCount, eax
	
	;calculate a new average
	mov		edx, 0
	mov		eax, inputSum
	cdq
	mov		ebx, inputCount
	cdq		
	idiv	ebx
	mov		InputAverage, eax ;quotient
	mov		divRemainder, edx ;remainder

	jmp		WithinRange

InvalidInput:
	;if the user inputs a number less than -100
	mov		edx, OFFSET invalidValue
	call	WriteString
	call	CrLF
WithinRange:
	mov		userInput, 0
	mov		edx, OFFSET prompt_2c
	call	WriteString
; read the number input as n
	call	ReadInt
	mov		userInput, eax

	;compare userInput to LOWER_LIMIT
	mov		eax, userInput
	cmp		eax, LOWER_LIMIT 
	;if userInput is greater than LOWER_LIMIT then go to the next step in comparison
	jg	GreaterThanLowerLimit

	mov		eax, userInput
	cmp		eax, LOWER_LIMIT
	;if userInput is less than LOWER_LIMIT then prompt and read again
	jle	InvalidInput

	jmp SkipOver

GreaterThanLowerLimit:

	;compare userInput to UPPER_LIMIT 
	mov		eax, userInput
	cmp		eax, UPPER_LIMIT 
	;if userInput is greater than UPPER_LIMIT then go to label and read more
	jl	PerformCalculations

SkipOver:

GetUserData ENDP

continueProgram:

;report count
	mov		edx, OFFSET string_1
	call	WriteString
	mov		eax, inputCount
	call	WriteDec
	mov		edx, OFFSET string_1b
	call	WriteString
	call	CrLF

;report sum
	mov		edx, OFFSET string_2
	call	WriteString
	mov		eax, inputSum
	call	WriteInt
	call	CrLF

;round the average if appropriate
	mov		eax, divRemainder ;moving remainder to eax
	cmp		eax, -4 ;comparing remainder and -4
	;if remainder is less than -4 then decrement the average
	jl	DecrementAverage
	
	jmp		FinishCalculation; skip over this part if we don't want to decrement the average
DecrementAverage:
	mov		eax, InputAverage
	mov		ebx, -1
	add		eax, ebx
	mov		InputAverage, eax
FinishCalculation:

;report average
	mov		edx, OFFSET string_3
	call	WriteString
	mov		eax, inputAverage
	call	WriteInt
	call	CrLF

;thank the user
	mov		edx, OFFSET string_4
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET string_4b
	call	WriteString
	call	CrLF

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
