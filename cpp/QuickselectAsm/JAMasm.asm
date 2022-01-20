;******************************************************************************* 
;*								Quickselect									   * 
;*                                                                             * 
;*                             Oliwier Kania                                   *
;*																			   *
;*                          Oficjalna wersja 1.0                               *
;******************************************************************************* 


.data

													;Warto�ci przepisanych parametr�w
len QWORD ?												;D�ugo�� tablicy
numList QWORD ?											;Tablica
k QWORD ?												;Kt�ry element jest do znalezienia
sortBiggest QWORD ?										;Czy najwi�kszy czy najmniejszy 0 - malej�co (szuka najmniejszej) 1 - rosn�co (szuka najwi�klszej)

													;Zmienne programu
currLen QWORD ?											;Piwot czyli obecna pozycja w du�ej p�tli od ko�ca
currLenAddr QWORD ?										;Aders na kt�ry wskazuje piwot czyli pozycja du�ej p�tli
i QWORD ?												;Pozycja w ma�ej p�tli od pocz�rtku
iAddr QWORD ?											;Adres pozycji ma�ej p�tli
zer QWORD 0												;Warto�� Zero
jed QWORD 1												;Warto�� Jeden

.code
			
													;G��wna funkcja programu

quickselect PROC lenArg: QWORD, numListArg: QWORD, kArg: QWORD, SortBiggestArg: QWORD
	
														;Po kolei �aduje przekazane parametry, kt�re zapisane s� w wybranych rejestrach i na stosie do zmiennych
														;	poniewa� przekazywany jest adres warto�ci to trzeba si� wpierw dosta� do danej
	MOV rax, [rcx]
	MOV len, rax

	MOV rax, rdx
	MOV numList, rax

	MOV rax, [r8]
	MOV k, rax

	MOV rax, [r9]
	MOV sortBiggest, rax


	MOV rax, k
	CMP rax, zer										;Sprawdza czy k nie jest zerem
	JS toSmall											;Je�eli k jest mniejsze od 0 (tutaj sprawdza czy jest znakowane bo tylko licznby ujemne s� znakowane) to algoEnd programu bo nie ma pozycji ujemnej
	JZ toSmall											;Je�eli k jest 0 to algoEnd bo nie ma pozycji zero
	CMP rax, len										;Sprawdza czy k nie jest d�u�sze od tablicy bo nie ma takiej pozycji
	JA toBig											;Je�eli jest wi�ksze to skok

	DEC k												;Obni�a k o jeden bo tablica jest od 0

	MOV rax, len
	MOV currLen, rax									;Wpisuje d�ugo�� tablicy do currLen

	MOV rbx, numList									;Nie mo�na bezpo�rednio przepisa� danych ze zemiennej do zmiennej, trzeba po�redniczy� przez rejestr
	MOV currLenAddr, rbx								;�aduje pozycj� pierwszego elementu w tablicy
	IMUL rax, 8											;Mno�y ilo�� p�l w tablicy razy 8 bajty
	ADD currLenAddr, rax								;Dodaje do pozycji tablicy jej d�ugo�� i skacze do ostatniego elemetu

	bigLoop:										;Du�a p�tla wykonuje si� tyle razy jak odleg�a jest liczba 
		MOV rax, currLen
		CMP rax, k										;Por�wnuje czy nie zosta�a ju� odnaleziona szukana liczba k
		JE algoEnd										;Je�eli currLen jest r�wne k to algoEnd bo liczba zosta�a znjaleziona

		DEC currLen										;Przy ka�dym powt�rzeniu dekrementuje currLen bo przs�wa biwot do pocz�tku tablicy
		SUB currLenAddr, 8								;Dekrementuje te� adres pivota
		MOV i, 0										;Zeruje i przez ma�� p�tl�
		MOV rax, numList
		MOV iAddr, rax
		;MOV iAddr,  numList						;Do zmiennej iteracji wrzuca adres pierwszego elementu tablicy
		MOV rax, [iAddr + 8]							;�aduje warto�� o 1 wy�szego elementu tablicy 

		
		smallLoop:									;Ma�a p�tla powtarza si� tyle razy ile jest element�w od pocz�tku tablicy do pivota

			MOV rax, i	
			CMP rax, currLen							;Sprawdza czy ma�a p�tla nie dobieg�a do ko�ca tablicy 
			JE bigLoop									;Je�eli to algoEnd to skacze do du�ej p�tli

			MOV rax, sortBiggest	
			CMP rax,jed									;Sprawdza czy szukamy liczby najmniejsze czy najwi�kszej
			JE isBiggest								;Je�eli 1 to najwi�ksza
			JB notIsBiggest								;Je�eli 0 to najmniejsza

		returnPoint:								;Punkt powrtu z funkcji edycji element�w tablicy (zamiany)

			INC i										;Inkrementuje o 1
			ADD iAddr, 8								;Za ka�dym powt�rzeniem przes�wa adres do kolejnego pola w tablicy
			JMP smallLoop								;Bezwarunkowy skok do ma�ej p�tli



	
	isBiggest:										;Obliczenia dla liczby najwi�kszej
		MOV rcx, iAddr									;UWAGA ZAPISA� WARTO�� POD DANYM ADRESEM MO�NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA�ADOWA� DO REJESTU.	�aduje adres elementu i do rejestru 
		MOV rax, [rcx]									;�aduje adres obecnego elementu i
		MOV rcx, currLenAddr							;�aduje adres j do rejestru
		MOV rbx, [rcx]									;�aduje adres obecnego element ucurrLen	

		CMP rax, rbx									;Por�wnuje czy liczba pod i jest mniejsz lub r�wna od liczby pod adresem currLen
		JB returnPoint									;Je�eli i jest mniejsze to wraca do ma�ej p�tli
		JE returnPoint									;Je�eli i jest r�wne to raca do ma�ej p�tli

														;Je�eli jest i jest wi�ksze to kontynuuje

		MOV rcx, iAddr									;�aduje adres elementu i bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [rcx], rbx	;Pod i wpisuje currLen			;�aduje pod element i warto�� elementu j
		MOV rcx, currLenAddr							;�aduje adres elementu j bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [rcx], rax	;Pod currLen wpisuje i			;�aduje pod element j warto�� elementu i

		JMP returnPoint									;Wraca

													
	notIsBiggest:									;Oblicznia dla liczby najmniejszej
		MOV rcx, iAddr									;UWAGA ZAPISA� WARTO�� POD DANYM ADRESEM MO�NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA�ADOWA� DO REJESTU.	�aduje adres elementu i do rejestru 
		MOV rax, [rcx]									;�aduje adres obecnego elementu i
		MOV rcx, currLenAddr							;�aduje adres j do rejestru
		MOV rbx, [rcx]									;�aduje adres obecnego element ucurrLen	

		CMP rax, rbx									;Por�wnuje czy liczba pod i jest mniejsz lub r�wna od liczby pod adresem currLen
		JA returnPoint									;Je�eli i jest wi�ksze to wraca do ma�ej p�tli
		JE returnPoint									;Je�eli i jest r�wne to raca do ma�ej p�tli

														;Je�eli jest i jest mnijesze to kontynuuje

		MOV rcx, iAddr									;�aduje adres elementu i bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [rcx], rbx	;Pod i wpisuje currLen			;�aduje pod element i warto�� elementu j
		MOV rcx, currLenAddr							;�aduje adres elementu j bo tylko przez rejestr mo�na skorzysta� z adresu
		MOV [rcx], rax	;Pod currLen wpisuje i			;�aduje pod element j warto�� elementu i

		JMP returnPoint									;Wraca

	
	toBig:											;Je�eli wyznaczone k b�dzie z du�e 
		MOV rax, -1										;Inforacja do mnie �e nie mo�na u�y� algorytmu
		JMP	finalEnd								

	toSmall:										;Je�eli wyznaczone k b�dzie za ma�e
		MOV rax, k
		MOV rax, -2										;Inforacja do mnie �e nie mo�na u�y� algorytmu
		JMP finalEnd

	
	algoEnd:										;Kiedy algorytm si� zako�czy i nie b�dzie b��du	
		MOV rax, k										;Wczytuje k element z listy by wy�witli� szukany element, Tu wpisuje go do rejestru rdx
		IMUL rax, 8
		MOV rbx,  numList
		ADD rbx,rax
		MOV rax, [rbx]

		jmp finalEnd	
	 

	finalEnd:									;Funkcja ko�cz�ca program i zwracaj�ca wynik, zwracana jest zawarto�c rejestru RAX		
		ret											;Powr�t do copp
		



quickselect ENDP

END 