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
quickselect proc a: QWORD, b: QWORD

;MOV rax, [rdx]
;ADD rax,[rdx+4]
;ADD rax,[rdx+8]
MOV rax, 1
ret

quickselect endp
end ; End of ASM file
