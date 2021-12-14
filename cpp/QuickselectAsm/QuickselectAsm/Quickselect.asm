;.386
.model flat, stdcall
;.stack 4096

;ExitProcess PROTO, dwExitCode:DWORD

.data

				;Te dane przyjd� w parametrach funkcj wi�c normalnie trzeba je usun��
len DWORD 7												;D�ugo�� tablicy
numList DWORD 5,3,7,33,1,4,9							;Tablica
k DWORD 7												;Kt�ry element jest do znalezienia
sortBiggest DWORD 0										;Czy najwi�kszy czy najmniejszy 0 - malej�co (szuka najmniejszej) 1 - rosn�co (szuka najwi�klszej)

													;Zmienne programu
currLen DWORD ?											;Piwot czyli obecna pozycja w du�ej p�tli od ko�ca
currLenAddr DWORD ?										;Aders na kt�ry wskazuje piwot czyli pozycja du�ej p�tli
i DWORD ?												;Pozycja w ma�ej p�tli od pocz�rtku
iAddr DWORD ?											;Adres pozycji ma�ej p�tli
zer DWORD 0												;Warto�� Zero
jed DWORD 1												;Warto�� Jeden

.code
				;To b�dzie g��wna funkcjam g��wna procedura zamiast main
				;quickselect PROC len: DWORD, numList: DWORD, k: DWORD, sortBiggest: DWORD
				;To b�dzie koniec g��wnej procedury zamiast main
				;quickselect ENDP

main PROC
	
	MOV eax, k
	CMP eax, zer										;Sprawdza czy k nie jest zerem
	JS toSmall											;Je�eli k jest mniejsze od 0 (tutaj sprawdza czy jest znakowane bo tylko licznby ujemne s� znakowane) to koniec programu bo nie ma pozycji ujemnej
	JZ toSmall											;Je�eli k jest 0 to koniec bo nie ma pozycji zero
	CMP eax, len										;Sprawdza czy k nie jest d�u�sze od tablicy bo nie ma takiej pozycji
	JA toBig											;Je�eli jest wi�ksze to skok

	DEC k												;Obni�a k o jeden bo tablica jest od 0

	MOV eax, len
	MOV currLen, eax									;Wpisuje d�ugo�� tablicy do currLen

	MOV currLenAddr, OFFSET numList						;�aduje pozycj� pierwszego elementu w tablicy
	IMUL eax, 4											;Mno�y ilo�� p�l w tablicy razy 4 bajty
	ADD currLenAddr, eax								;Dodaje do pozycji tablicy jej d�ugo�� i skacze do ostatniego elemetu

	
	bigLoop:										;Du�a p�tla wykonuje si� tyle razy jak odleg�a jest liczba 
		MOV eax, currLen
		CMP eax, k										;Por�wnuje czy nie zosta�a ju� odnaleziona szukana liczba k
		JE koniec										;Je�eli currLen jest r�wne k to koniec bo liczba zosta�a znjaleziona

		DEC currLen										;Przy ka�dym powt�rzeniu dekrementuje currLen bo przs�wa biwot do pocz�tku tablicy
		SUB currLenAddr, 4								;Dekrementuje te� adres pivota
		MOV i, 0										;Zeruje i przez ma�� p�tl�
		MOV iAddr, OFFSET numList						;Do zmiennej iteracji wrzuca adres pierwszego elementu tablicy
		MOV eax, [iAddr + 4]							;�aduje warto�� o 1 wy�szego elementu tablicy 

		
		smallLoop:									;Ma�a p�tla powtarza si� tyle razy ile jest element�w od pocz�tku tablicy do pivota

			MOV eax, i	
			CMP eax, currLen							;Sprawdza czy ma�a p�tla nie dobieg�a do ko�ca tablicy 
			JE bigLoop									;Je�eli to koniec to skacze do du�ej p�tli

			MOV eax, sortBiggest	
			CMP eax,jed									;Sprawdza czy szukamy liczby najmniejsze czy najwi�kszej
			JE isBiggest								;Je�eli 1 to najwi�ksza
			JB notIsBiggest								;Je�eli 0 to najmniejsza

		returnPoint:								;Punkt powrtu z funkcji edycji element�w tablicy (zamiany)

			INC i										;Inkrementuje o 1
			ADD iAddr, 4								;Za ka�dym powt�rzeniem przes�wa adres do kolejnego pola w tablicy
			JMP smallLoop								;Bezwarunkowy skok do ma�ej p�tli



	
	isBiggest:										;Obliczenia dla liczby najwi�kszej
		MOV ecx, iAddr									;UWAGA ZAPISA� WARTO�� POD DANYM ADRESEM MO�NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA�ADOWA� DO REJESTU.	�aduje adres elementu i do rejestru 
		MOV eax, [ecx]									;�aduje adres obecnego elementu i
		MOV ecx, currLenAddr							;�aduje adres j do rejestru
		MOV ebx, [ecx]									;�aduje adres obecnego element ucurrLen	

		CMP eax, ebx									;Por�wnuje czy liczba pod i jest mniejsz lub r�wna od liczby pod adresem currLen
		JB returnPoint									;Je�eli i jest mniejsze to wraca do ma�ej p�tli
		JE returnPoint									;Je�eli i jest r�wne to raca do ma�ej p�tli

														;Je�eli jest i jest wi�ksze to kontynuuje

		MOV ecx, iAddr									;�aduje adres elementu i bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [ecx], ebx	;Pod i wpisuje currLen			;�aduje pod element i warto�� elementu j
		MOV ecx, currLenAddr							;�aduje adres elementu j bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [ecx], eax	;Pod currLen wpisuje i			;�aduje pod element j warto�� elementu i

		JMP returnPoint									;Wraca

													
	notIsBiggest:									;Oblicznia dla liczby najmniejszej
		MOV ecx, iAddr									;UWAGA ZAPISA� WARTO�� POD DANYM ADRESEM MO�NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA�ADOWA� DO REJESTU.	�aduje adres elementu i do rejestru 
		MOV eax, [ecx]									;�aduje adres obecnego elementu i
		MOV ecx, currLenAddr							;�aduje adres j do rejestru
		MOV ebx, [ecx]									;�aduje adres obecnego element ucurrLen	

		CMP eax, ebx									;Por�wnuje czy liczba pod i jest mniejsz lub r�wna od liczby pod adresem currLen
		JA returnPoint									;Je�eli i jest wi�ksze to wraca do ma�ej p�tli
		JE returnPoint									;Je�eli i jest r�wne to raca do ma�ej p�tli

														;Je�eli jest i jest mnijesze to kontynuuje

		MOV ecx, iAddr									;�aduje adres elementu i bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [ecx], ebx	;Pod i wpisuje currLen			;�aduje pod element i warto�� elementu j
		MOV ecx, currLenAddr							;�aduje adres elementu j bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [ecx], eax	;Pod currLen wpisuje i			;�aduje pod element j warto�� elementu i

		JMP returnPoint									;Wraca

	
	toBig:											;Je�eli wyznaczone k b�dzie z du�e 
		MOV edx, -1										;Inforacja do mnie �e nie mo�na u�y� algorytmu
		JMP	koniecErr								

	toSmall:										;Je�eli wyznaczone k b�dzie za ma�e
		MOV edx, -1										;Inforacja do mnie �e nie mo�na u�y� algorytmu
		JMP koniecErr

	
									;WSZYSTKO DO USUNIECIA PO PODIPIECIU
									;WYMAGANY ZWROT WYNIKU
									;ERRORY NIE SA OBS�UGIWANE W TEJ FUNKCJI
	koniec:											;Kiedy algorytm si� zako�czy	
		MOV eax, k									;Wczytuje k element z listy by wy�witli� szukany element, Tu wpisuje go do rejestru edx
		IMUL eax, 4
		MOV ebx, OFFSET numList
		ADD ebx,eax
		MOV edx, [ebx]
		ADD eax, 1

		JMP wyl

	wyl:
		MOV eax, OFFSET numList
		MOV ebx, zer
		MOV ecx, len
		MOV currLen, ecx
		INC currLen
		;DEC currLen

	wylJmp:

		CMP ebx,  currLen
		JE koniecErr

		MOV edx, [eax]
		ADD eax,4
		INC ebx
		JMP wylJmp

	koniecErr:
	Add eax, 1

main ENDP

END main