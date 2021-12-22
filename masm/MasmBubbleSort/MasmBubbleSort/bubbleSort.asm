.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
myList DWORD 1,5,3,8,33,1,6,9,4,2 ; Lista
len DWORD 8 ; D�ugo�� listy -1 bo ostatniego elementu nie ma z czym por�na�
lenD DWORD ? ;Tu zapisywana jest lokalizacja du�ej p�li
lenS DWORD 9 ;Do wy�wietlania
jed DWORD 4 ;4 bajty w pami�ci potrzebne do dodania by uzyska� kolejny element listy

.code
main PROC 

	;Iteruje przez list�, do ogl�dania przez Watch
		mov eax, -1		;Inkrememntuje na pocz�tku wi�c musi by� od ujemnej
		mov ebx, offset myList		;Lokalizacja pierwszego elememtu listy w pami�ci
	razp:
		inc eax
		mov edx, [ebx]		;Wrzuca do edx warto�� spod adresu ebx (lsita)

		add ebx, 4		;Dodaje 4 czyli przechodzi do kolejnego elementu listy
		cmp eax,lenS	;Por�nuje pozcyj� w li�cie z jej d�ugo�ci�
		jne razp	;Je�eli liczby s� r�ne to wykonuje skok



		;W�a�ciwy algorytm sortowania b�belkowego
		mov eax, -1		;Inkrememntuje na pocz�tku wi�c musi by� od ujemnej
		mov ebx, OFFSET myList		;Lokalizacja pierwszego elememtu listy w pami�ci
		mov lenD, 0		;Ustawia d�ugo�� du�ej p�tli na 0

	skok:
		inc eax
		mov edx , [ebx]

		cmp [ebx + 4], edx		;Por�nuje element listy z kolejnym elementem
		Ja wieksze		;Je�eli pierwszy element (ebx + 4) jest wi�kszy od kolejntego to wykonuje skok
	powr:
		add ebx,jed		;Dodaje 4 bajty czyli przechodzi do kolejnego elementu listy
		cmp eax,len		;Por�wnuje pozycj� w li�cie z jej d�ugo�ci�
		jne skok	;Je�eli liczby s� r�ne to wykonuje skok

		;Je�eli liczby s� takie same to ozancza �e ma�a p�tla si� sko�czy�a
		mov eax, lenD	;Do eax �aduje ilo�� iteracja duej p�tli bo nie mo�na por�wnywa� dw�ch zmiennych jedna musi by� rejestrem a eax i tak sko�czy�o swoj� prac� na t� p�tl�
		cmp eax,len
		je koniec	;Je�eli ilo�� iteracji jest r�wna d�ugo�ci to koniec algorytmu
		mov eax, -1 ;Przygotowuje do kolejnej iteracji du�ej p�tli
		add lenD,1
		mov ebx, offset myList
		jmp skok

	wieksze:	;Zamienia miejscami elementy listy 
		mov ecx, edx	;W ecx zapisuje obecn� warto�� edx
		mov edx,[ebx + 4]	;Do wy�szego edx �aduje kolejny element tablicy
		mov [ebx], edx	  ;Pod adres obecnego ebx �adujemy obecne edx
		add ebx, 4		;Przechodzi do kolejnego elementu tablicy
		mov [ebx], ecx		;Pod adres elementu �aduje zapisan� warto��
		sub ebx, 4		;Cofa do poprzedniej warto�ci
		jmp powr	;Skok bezwarunkowy






;Po zako�czeniu dzia�ania algorytmu wy�wietla elementy nowej isty kt�re mo�na obserwowa� w Watch
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
