; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

INCLUDE Irvine32.inc
INCLUDE macros.inc

.data
result dword ?

.code
main proc

	beginning:
	call Init
	
	;Prompt user to enter two unsigned integers
	mWrite "Please enter a positive integer: "
	call ReadInt
	push eax

	mWrite "Please enter another positive integer: "
	call ReadInt
	push eax
	call crlf

	;Prompt user to enter the type of operation needed
	;1 for +, 2 for -, 3 for *, 4 for /
	mWrite "Please enter a number: "
	call crlf
	mWrite "1 - add"
	call crlf
	mWrite "2 - subtract"
	call crlf
	mWrite "3 - multiply"
	call crlf
	mWrite "4 - divide"
	call crlf
	choice:
	call ReadInt

	;reads the inputted number.
	;jumps to the specific operation requested.

	cmp al,1
	je addition

	cmp al,2
	je subtraction
	
	cmp al,3
	je multiplication

	cmp al,4
	je division
	
	jmp choice ;re-enter input if invalid.

	addition:
		call AddProc1
		jmp retry
	subtraction:
		call SubProc2
		jmp retry
	multiplication:
		call MulProc3
		jmp retry
	division:
		call DivProc4
		jmp retry

	;retry query
	retry:
		add esp,8 ;pops the two inputted numbers out.
		call crlf
		mWrite "retry? (1 for yes, 0 for no)"
		call crlf
		call ReadInt
		
		cmp al,1
		je beginning ;loop if user inputted 1
		
		invoke ExitProcess,0
main endp

AddProc1 proc
	;create stack frame
	;in case any operands need to be pushed
	;to another function
	push ebp
	mov ebp,esp	

	;accesses the two values
	;inputted by user.
	mov ebx,[ebp+8]
	mov eax,[ebp+12]

	;performs the desired operation.
	add eax,ebx
	mWRite "Result: "
	call WriteInt
	mov result,eax
	pop ebp
	ret
AddProc1 endp

SubProc2 proc
	;create stack frame
	;in case any operands need to be pushed
	;to another function
	push ebp
	mov ebp,esp	

	;accesses the two values
	;inputted by user.
	mov ebx,[ebp+8]
	mov eax,[ebp+12]

	;performs the desired operation.
	sub eax,ebx
	mWRite "Result: "
	call WriteInt
	mov result,eax
	pop ebp
	ret
SubProc2 endp

MulProc3 proc
	;create stack frame
	;in case any operands need to be pushed
	;to another function
	push ebp
	mov ebp,esp	

	;accesses the two values
	;inputted by user.
	mov ebx,[ebp+8]
	mov eax,[ebp+12]

	;performs the desired operation.
	mul ebx
	mWRite "Result: "
	call WriteInt
	mov result,eax
	pop ebp
	ret
MulProc3 endp

DivProc4 proc
	;create stack frame
	;in case any operands need to be pushed
	;to another function
	push ebp
	mov ebp,esp	

	;accesses the two values
	;inputted by user.
	mov ebx,[ebp+8]
	mov eax,[ebp+12]

	;performs the desired operation.
	div ebx
	mWRite "Result: "
	call WriteInt
	mov result,eax
	pop ebp
	ret
DivProc4 endp

Init proc
	;sets the general purpose registers to 0.
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0
	ret
Init endp

end main