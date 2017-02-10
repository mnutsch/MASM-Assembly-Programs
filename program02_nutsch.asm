TITLE Program02     (program02_nutsch.asm)

; Author: Matt Nutsch
; CS271-400 / Program02                 
; Date: 1-22-2017
; Description: This program will: introduce the programmer;
; read an integer between 1 and 46;
; read user's name
; output user's name
; validate the user input (n);
; calculate and display all of the Fibonacci numbers up to and including the nth term
; (results displayed 5 terms per line with at least 5 spaces between terms);
; display a parting message that includes the user's name, and terminate the program.

INCLUDE Irvine32.inc

;constants
UPPER_LIMIT = 46

.data

; variables
userName	BYTE	33 DUP(0)	;string to be entered by the user
userInput	DWORD	?			;integer to be entered by the user
programTitle	BYTE	"Program 2: Fibonacci Numbers", 0
programDesc	BYTE	"This program will calculalate Fibonacci numbers", 0
intro_1		BYTE	"Hi. I was written by Matt Nutsch.", 0
prompt_1	BYTE	"What's your name? ", 0
prompt_2	BYTE	"Enter a number from 1 and ", 0
prompt_2b	BYTE	": ", 0
string_1	BYTE	"Calculating Fibonacci Numbers...", 0
string_2	BYTE	"Thank you for using the program ", 0
string_3	BYTE	".", 0
resultsCertified	BYTE	"Results certified by Matt Nutsch.", 0
goodBye		BYTE	"Goodbye ", 0
stringBlanks	BYTE	"     ", 0
val1	DWORD	?	;used for calculating Fibonacci values
val2	DWORD	?	;used for calculating Fibonacci values
valTemp	DWORD	?	;used for calculating Fibonacci values
outputCount	DWORD	?	;used to determine when to start a new line
mathResult	DWORD	?	;used for determining when to start a new line
invalidValue	BYTE	"Out of range. ", 0

.code
main PROC

Introduction PROC
; output program title
	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLF
	mov		edx, OFFSET programDesc
	call	WriteString
	call	CrLF
; output  programmer’s name
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLF
Introduction ENDP

UserInstructions PROC
; prompt for user's name
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	CrLF
UserInstructions ENDP

GetUserData PROC

;label for reading user name
; read user's name 
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString

;label for reading int loop
jmp		GetInput
OutOfRange:
	mov		edx, OFFSET invalidValue
	call	WriteString
GetInput:
; prompt for the number from 1-UPPER_LIMIT
	mov		edx, OFFSET prompt_2
	call	WriteString
	mov		eax, UPPER_LIMIT
	call	WriteDec
	mov		edx, OFFSET prompt_2b
	call	WriteString
	call	CrLF
; read the number input as n
	call	ReadInt
	mov		userInput, eax
; if the input is not an integer from 1-UPPER_LIMIT then repeat
	;compare userInput to UPPER_LIMIT
	cmp		eax, UPPER_LIMIT 
	;if userInput is greater than UPPER_LIMIT then go to label
	jg	OutOfRange
	;compare userInput to 1
	cmp		eax, 1 
	;if userInput is less than 0 then go to label
	jl	OutOfRange	
GetUserData ENDP

DisplayFibs PROC
;calculate and display all of the Fibonacci numbers up to n
;5 per line with 5 spaces in between each
;set the initial values
	mov		val1, 0
	mov		val2, 1
	mov		outputCount, 0
;announce what is happening
	call	CrLF
	mov		edx, OFFSET string_1
	call	WriteString
	call	CrLF
;output the initial 1
	mov eax, 1
	call	WriteDec
	mov		edx, OFFSET stringBlanks
	call	WriteString
;set ecx loop counter to n - 1
	mov		eax, userInput
	mov		ebx, 1
	sub		eax, ebx
	mov     ecx, eax
;define start point
OutputValues:
	;increment counter
		inc outputCount
	;start a new line if remainder of division by 5 is 0
		mov		eax, outputCount
		cdq
		mov		ebx, 5
		cdq		
		div		ebx
		mov		mathResult, edx ;remainder of dividing by 5
		cmp		edx, 0 ;check if the value of mathResult is 0
		jne		ContinueRow
		call	CrLF
ContinueRow:
	;calculate new fibonacci value 
		;valTemp = val1 + val2
		mov		eax, val1
		mov		ebx, val2
		add		eax, ebx
		mov		valTemp, eax
		;val1 = val2
		mov		ebx, val2
		mov		val1, ebx
		;val2 = valTemp
		mov		ebx, valTemp
		mov		val2, ebx
	;output val2
	mov		eax, val2
	call	WriteDec
	mov		edx, OFFSET stringBlanks
	call	WriteString
;reset loop
	loop	OutputValues
DisplayFibs ENDP

Farewell PROC
;display a parting message which includes the user's name
	call	CrLF	
	call	CrLF	
	mov		edx, OFFSET resultsCertified
	call	WriteString
	call	CrLF	
	mov		edx, OFFSET string_2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET string_3
	call	WriteString
	call	CrLF
	call	CrLF	
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLF
Farewell ENDP

	exit	; exit to operating system
main ENDP

END main
