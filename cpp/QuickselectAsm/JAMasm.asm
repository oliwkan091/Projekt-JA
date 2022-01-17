;.386
;.model flat, stdcall									
;.stacnth 8096

;ExitProcess PROTO, dwExitCode:QWORD

.data

													;Sent parameters
length QWORD ?											;Tab length 
numbers QWORD ?											;Numbers Tab
nth QWORD ?												;Nth element to be found
bigSmall QWORD ?										;Sort ASC or DSC 0 - DSC (looks for the smalles one) 1 - ASC (looks for the bigges one)

													;Program varibles 
VarCurLength QWORD ?									;Pivot - current position in a big loop
VarCurLengthAddr QWORD ?								;Addres of a pivot element in big loop
i QWORD ?												;Pivot - Current possistion in samll loop
AddresI QWORD ?											;Addres of a pivot element in small loop
nul QWORD 0												;const 0
one QWORD 1												;const 1

.code
			
													;Main loop

quicnthselect PROC lengthArg: QWORD, numbersArg: QWORD, nthArg: QWORD, bigSmallArg: QWORD
	
														;From here program loads given parameters, some are being saved to registers and some are set on stack
														;Registers type RAX are too big to be sent via value so values are set on stack and the first element addres is being sent 
														;So at the beginning it is nessesary to take all the elements form stack 
	MOV rax, [rcx]
	MOV length, rax
	MOV rax, rdx
	MOV numbers, rax
	MOV rax, [r8]
	MOV nth, rax
	MOV rax, [r9]
	MOV bigSmall, rax


	MOV rax, nth
	CMP rax, nul										;Checking if the n number is not null
	JS smallEnd											;If the number is netgative jums to smallEnd because position cannot be negative
	JZ smallEnd											;If the number is null jums to smallEnd because position cannot be null
	CMP rax, length										;If the number is not longer the the array length because it cannot be
	JA bigEnd											;If number is to big jums to bigEnd
	DEC nth												;Decrease n by one beacuse array starts from 0
	MOV rax, length
	MOV VarCurLength, rax								;Saves the array length to VarCurLength
	MOV rbx, numbers									;It is impossible to copy data from one varible to another, it must be done via register
	MOV VarCurLengthAddr, rbx							;Loads first element addres
	IMUL rax, 8											;Multiplies the number of array elements by 8 bites
	ADD VarCurLengthAddr, rax							;Adds the length of array to its position and jumps to the end 

	bigLoop:										;Big loop makes numbers of moves equal to the length of number array  
		MOV rax, VarCurLength
		CMP rax, nth									;Checks if the wanted number wasn’t already found 
		JE programEnd									;If VarCurLength is equal to nth program exits because the wanted number was found 
		DEC VarCurLength								;With every loop decrements the VarCurLength and moves pivot to the beginning of the array 
		SUB VarCurLengthAddr, 8							;Decrements the pivot address to 
		MOV i, 0										;Nulls I before the small loop
		MOV rax, numbers
		MOV AddresI, rax
		MOV rax, [AddresI + 8]							;Loads next value to the arrays 

		
		smallLoop:									;The small loop iterates as many times as many elements are from beginning to pivot 
			MOV rax, i	
			CMP rax, VarCurLength						;Checks if the small loop didn’t finished yet 
			JE bigLoop									;If finished jumps to the big loop
			MOV rax, bigSmall	
			CMP rax,one									;Checks if we are looking for the smallest or the biggest number 
			JE isBiggest								;if equals to 1 program looks for the biggest number 
			JB notIsBiggest								;if equals to 0 program looks fot the smalles number 

		loopBack:									;Returning point form function that edits the array elements (isBiggest or notIsBiggest) 
			INC i										;Increments by 1
			ADD AddresI, 8								;Every time the loop repeats moves address to the next pools of array
			JMP smallLoop								;Unconditional jump to the small loop


	isBiggest:										;Calculate for the biggest number
		MOV rcx, AddresI								;Loads element address to the register  IMPORTANT it is impossible to save value to the given address directly, it must by saved by register  
		MOV rax, [rcx]									;Loads current I address 
		MOV rcx, VarCurLengthAddr						;Loads j address to the register 
		MOV rbx, [rcx]									;Loads current address to the VarCurLength
		CMP rax, rbx									;Compares that the i number is smaller or equal to the VarCurLength number 
		JB loopBack										;If I is smaller goes back to the small loop 
		JE loopBack										;If I is equal goes back to the small loop

													;If I is bigger continues 

		MOV rcx, AddresI								;Loads i address because only via register it is possible to use addres 
		MOV [rcx], rbx	;Pod i wpisuje VarCurLength		;Loads for i element the value of j element 
		MOV rcx, VarCurLengthAddr						;Loads j addres to register 
		MOV [rcx], rax	;Pod VarCurLength wpisuje i		;Loads to j element value of i element 
		JMP loopBack									;Go back 

													
	notIsBiggest:									;Calculate for the smallest number
		MOV rcx, AddresI								;Loads element address to the register
		MOV rax, [rcx]									;Loads current element address to i
		MOV rcx, VarCurLengthAddr						;Loads j address to the register 
		MOV rbx, [rcx]									;Loads current address to VarCurLength
		CMP rax, rbx									;Compares if the number under I smaller or equal to the number under VarCurLength
		JA loopBack										;If i is bigger go back to the small loop 
		JE loopBack										;If i is equal  go back to the small loop 

														;If i is smaller go back to the small loop 

		MOV rcx, AddresI								;Loads i address to register 
		MOV [rcx], rbx	;Pod i wpisuje VarCurLength		;Loads j value to I address 
		MOV rcx, VarCurLengthAddr						;Loads j address to register 
		MOV [rcx], rax	;Pod VarCurLength wpisuje i		;Loads I value to j element 
		JMP loopBack									;Go back 

	
	bigEnd:											;If nth element is to big  
		MOV rax, -1										;Info in register that the number was to big 
		JMP	finito								

	smallEnd:										;If given nth element is to small 
		MOV rax, nth
		MOV rax, -2										;Info in register that the number was to small 
		JMP finito

	
	programEnd:										;If the program ends with no errors  
		MOV rax, nth									;Loads the nth element from a list to show element thet was found. It is saved to the RDX register 
		IMUL rax, 8
		MOV rbx,  numbers
		ADD rbx,rax
		MOV rax, [rbx]
		jmp finito
	 

	finito:											;Ending the program and returning the result  		
		ret
		

quicnthselect ENDP

END 