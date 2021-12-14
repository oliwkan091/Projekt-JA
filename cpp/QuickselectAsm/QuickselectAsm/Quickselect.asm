;.386
.model flat, stdcall
;.stack 4096

;ExitProcess PROTO, dwExitCode:DWORD

.data

				;Te dane przyjd¹ w parametrach funkcj wiêc normalnie trzeba je usun¹æ
len DWORD 7												;D³ugoœæ tablicy
numList DWORD 5,3,7,33,1,4,9							;Tablica
k DWORD 7												;Który element jest do znalezienia
sortBiggest DWORD 0										;Czy najwiêkszy czy najmniejszy 0 - malej¹co (szuka najmniejszej) 1 - rosn¹co (szuka najwiêklszej)

													;Zmienne programu
currLen DWORD ?											;Piwot czyli obecna pozycja w du¿ej pêtli od koñca
currLenAddr DWORD ?										;Aders na który wskazuje piwot czyli pozycja du¿ej pêtli
i DWORD ?												;Pozycja w ma³ej pêtli od pocz¹rtku
iAddr DWORD ?											;Adres pozycji ma³ej pêtli
zer DWORD 0												;Wartoœæ Zero
jed DWORD 1												;Wartoœæ Jeden

.code
				;To bêdzie g³ówna funkcjam g³ówna procedura zamiast main
				;quickselect PROC len: DWORD, numList: DWORD, k: DWORD, sortBiggest: DWORD
				;To bêdzie koniec g³ównej procedury zamiast main
				;quickselect ENDP

main PROC
	
	MOV eax, k
	CMP eax, zer										;Sprawdza czy k nie jest zerem
	JS toSmall											;Je¿eli k jest mniejsze od 0 (tutaj sprawdza czy jest znakowane bo tylko licznby ujemne s¹ znakowane) to koniec programu bo nie ma pozycji ujemnej
	JZ toSmall											;Je¿eli k jest 0 to koniec bo nie ma pozycji zero
	CMP eax, len										;Sprawdza czy k nie jest d³u¿sze od tablicy bo nie ma takiej pozycji
	JA toBig											;Je¿eli jest wiêksze to skok

	DEC k												;Obni¿a k o jeden bo tablica jest od 0

	MOV eax, len
	MOV currLen, eax									;Wpisuje d³ugoœæ tablicy do currLen

	MOV currLenAddr, OFFSET numList						;£aduje pozycjê pierwszego elementu w tablicy
	IMUL eax, 4											;Mno¿y iloœæ pól w tablicy razy 4 bajty
	ADD currLenAddr, eax								;Dodaje do pozycji tablicy jej d³ugoœæ i skacze do ostatniego elemetu

	
	bigLoop:										;Du¿a pêtla wykonuje siê tyle razy jak odleg³a jest liczba 
		MOV eax, currLen
		CMP eax, k										;Porównuje czy nie zosta³a ju¿ odnaleziona szukana liczba k
		JE koniec										;Je¿eli currLen jest równe k to koniec bo liczba zosta³a znjaleziona

		DEC currLen										;Przy ka¿dym powtórzeniu dekrementuje currLen bo przsówa biwot do pocz¹tku tablicy
		SUB currLenAddr, 4								;Dekrementuje te¿ adres pivota
		MOV i, 0										;Zeruje i przez ma³¹ pêtl¹
		MOV iAddr, OFFSET numList						;Do zmiennej iteracji wrzuca adres pierwszego elementu tablicy
		MOV eax, [iAddr + 4]							;£aduje wartoœæ o 1 wy¿szego elementu tablicy 

		
		smallLoop:									;Ma³a pêtla powtarza siê tyle razy ile jest elementów od pocz¹tku tablicy do pivota

			MOV eax, i	
			CMP eax, currLen							;Sprawdza czy ma³a pêtla nie dobieg³a do koñca tablicy 
			JE bigLoop									;Je¿eli to koniec to skacze do du¿ej pêtli

			MOV eax, sortBiggest	
			CMP eax,jed									;Sprawdza czy szukamy liczby najmniejsze czy najwiêkszej
			JE isBiggest								;Je¿eli 1 to najwiêksza
			JB notIsBiggest								;Je¿eli 0 to najmniejsza

		returnPoint:								;Punkt powrtu z funkcji edycji elementów tablicy (zamiany)

			INC i										;Inkrementuje o 1
			ADD iAddr, 4								;Za ka¿dym powtórzeniem przesówa adres do kolejnego pola w tablicy
			JMP smallLoop								;Bezwarunkowy skok do ma³ej pêtli



	
	isBiggest:										;Obliczenia dla liczby najwiêkszej
		MOV ecx, iAddr									;UWAGA ZAPISAÆ WARTOŒÆ POD DANYM ADRESEM MO¯NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA£ADOWAÆ DO REJESTU.	£aduje adres elementu i do rejestru 
		MOV eax, [ecx]									;£aduje adres obecnego elementu i
		MOV ecx, currLenAddr							;£aduje adres j do rejestru
		MOV ebx, [ecx]									;£aduje adres obecnego element ucurrLen	

		CMP eax, ebx									;Porównuje czy liczba pod i jest mniejsz lub równa od liczby pod adresem currLen
		JB returnPoint									;Je¿eli i jest mniejsze to wraca do ma³ej pêtli
		JE returnPoint									;Je¿eli i jest równe to raca do ma³ej pêtli

														;Je¿eli jest i jest wiêksze to kontynuuje

		MOV ecx, iAddr									;£aduje adres elementu i bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [ecx], ebx	;Pod i wpisuje currLen			;£aduje pod element i wartoœæ elementu j
		MOV ecx, currLenAddr							;£aduje adres elementu j bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [ecx], eax	;Pod currLen wpisuje i			;£aduje pod element j wartoœæ elementu i

		JMP returnPoint									;Wraca

													
	notIsBiggest:									;Oblicznia dla liczby najmniejszej
		MOV ecx, iAddr									;UWAGA ZAPISAÆ WARTOŒÆ POD DANYM ADRESEM MO¯NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA£ADOWAÆ DO REJESTU.	£aduje adres elementu i do rejestru 
		MOV eax, [ecx]									;£aduje adres obecnego elementu i
		MOV ecx, currLenAddr							;£aduje adres j do rejestru
		MOV ebx, [ecx]									;£aduje adres obecnego element ucurrLen	

		CMP eax, ebx									;Porównuje czy liczba pod i jest mniejsz lub równa od liczby pod adresem currLen
		JA returnPoint									;Je¿eli i jest wiêksze to wraca do ma³ej pêtli
		JE returnPoint									;Je¿eli i jest równe to raca do ma³ej pêtli

														;Je¿eli jest i jest mnijesze to kontynuuje

		MOV ecx, iAddr									;£aduje adres elementu i bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [ecx], ebx	;Pod i wpisuje currLen			;£aduje pod element i wartoœæ elementu j
		MOV ecx, currLenAddr							;£aduje adres elementu j bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [ecx], eax	;Pod currLen wpisuje i			;£aduje pod element j wartoœæ elementu i

		JMP returnPoint									;Wraca

	
	toBig:											;Je¿eli wyznaczone k bêdzie z du¿e 
		MOV edx, -1										;Inforacja do mnie ¿e nie mo¿na u¿yæ algorytmu
		JMP	koniecErr								

	toSmall:										;Je¿eli wyznaczone k bêdzie za ma³e
		MOV edx, -1										;Inforacja do mnie ¿e nie mo¿na u¿yæ algorytmu
		JMP koniecErr

	
									;WSZYSTKO DO USUNIECIA PO PODIPIECIU
									;WYMAGANY ZWROT WYNIKU
									;ERRORY NIE SA OBS£UGIWANE W TEJ FUNKCJI
	koniec:											;Kiedy algorytm siê zakoñczy	
		MOV eax, k									;Wczytuje k element z listy by wyœwitliæ szukany element, Tu wpisuje go do rejestru edx
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