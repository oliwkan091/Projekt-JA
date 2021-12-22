;*******************************************************************************
;* Laboratory 1 simple assembly procedure call *
;* *
;* Standard Windows memory model *
;*******************************************************************************
;.model flat, stdcall
.code
;*******************************************************************************
;* *
;* Assembler procedure MyProc1 changes Flags register *
;* *
;* Input: x: DWORD (C++ int type), y: DWORD (C++ int type) *
;* Output: z: DWORD (C++ int type) in the EAX register *
;* *
;*******************************************************************************
MyProc1 proc a: QWORD, b: QWORD

MOV rax, [rdx]
ADD rax,[rdx+4]
ADD rax,[rdx+8]
ret

MyProc1 endp
end ; End of ASM file
