.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
myList DWORD 1,5,3,8,33,1,6,9,4,2 ; Lista
len DWORD 8 ; D³ugoœæ listy -1 bo ostatniego elementu nie ma z czym porónaæ
lenD DWORD ? ;Tu zapisywana jest lokalizacja du¿ej pêli
lenS DWORD 9 ;Do wyœwietlania
jed DWORD 4 ;4 bajty w pamiêci potrzebne do dodania by uzyskaæ kolejny element listy

.code
main PROC 

	;Iteruje przez listê, do ogl¹dania przez Watch
		mov eax, -1		;Inkrememntuje na pocz¹tku wiêc musi byæ od ujemnej
		mov ebx, offset myList		;Lokalizacja pierwszego elememtu listy w pamiêci
	razp:
		inc eax
		mov edx, [ebx]		;Wrzuca do edx wartoœæ spod adresu ebx (lsita)

		add ebx, 4		;Dodaje 4 czyli przechodzi do kolejnego elementu listy
		cmp eax,lenS	;Porónuje pozcyjê w liœcie z jej d³ugoœci¹
		jne razp	;Je¿eli liczby s¹ ró¿ne to wykonuje skok



		;W³aœciwy algorytm sortowania b¹belkowego
		mov eax, -1		;Inkrememntuje na pocz¹tku wiêc musi byæ od ujemnej
		mov ebx, OFFSET myList		;Lokalizacja pierwszego elememtu listy w pamiêci
		mov lenD, 0		;Ustawia d³ugoœæ du¿ej pêtli na 0

	skok:
		inc eax
		mov edx , [ebx]

		cmp [ebx + 4], edx		;Porónuje element listy z kolejnym elementem
		Ja wieksze		;Je¿eli pierwszy element (ebx + 4) jest wiêkszy od kolejntego to wykonuje skok
	powr:
		add ebx,jed		;Dodaje 4 bajty czyli przechodzi do kolejnego elementu listy
		cmp eax,len		;Porównuje pozycjê w liœcie z jej d³ugoœci¹
		jne skok	;Je¿eli liczby s¹ ró¿ne to wykonuje skok

		;Je¿eli liczby s¹ takie same to ozancza ¿e ma³a pêtla siê skoñczy³a
		mov eax, lenD	;Do eax ³aduje iloœæ iteracja duej pêtli bo nie mo¿na porównywaæ dwóch zmiennych jedna musi byæ rejestrem a eax i tak skoñczy³o swoj¹ pracê na t¹ pêtlê
		cmp eax,len
		je koniec	;Je¿eli iloœæ iteracji jest równa d³ugoœci to koniec algorytmu
		mov eax, -1 ;Przygotowuje do kolejnej iteracji du¿ej pêtli
		add lenD,1
		mov ebx, offset myList
		jmp skok

	wieksze:	;Zamienia miejscami elementy listy 
		mov ecx, edx	;W ecx zapisuje obecn¹ wartoœæ edx
		mov edx,[ebx + 4]	;Do wy¿szego edx ³aduje kolejny element tablicy
		mov [ebx], edx	  ;Pod adres obecnego ebx ³adujemy obecne edx
		add ebx, 4		;Przechodzi do kolejnego elementu tablicy
		mov [ebx], ecx		;Pod adres elementu ³aduje zapisan¹ wartoœæ
		sub ebx, 4		;Cofa do poprzedniej wartoœci
		jmp powr	;Skok bezwarunkowy






;Po zakoñczeniu dzia³ania algorytmu wyœwietla elementy nowej isty które mo¿na obserwowaæ w Watch
	koniec:

		mov eax, -1
		mov ebx, offset myList
		sub ebx, 4
	razj:
		inc eax
		mov edx, [ebx]

		add ebx, 4
		cmp eax,lenS
		jne razj
  
	main ENDP

END main
