;******************************************************************************* 
;*								Quickselect									   * 
;*                                                                             * 
;*                             Oliwier Kania                                   *
;*																			   *
;*                          Oficjalna wersja 1.0                               *
;******************************************************************************* 


.data

													;Wartoœci przepisanych parametrów
len QWORD ?												;D³ugoœæ tablicy
numList QWORD ?											;Tablica
k QWORD ?												;Który element jest do znalezienia
sortBiggest QWORD ?										;Czy najwiêkszy czy najmniejszy 0 - malej¹co (szuka najmniejszej) 1 - rosn¹co (szuka najwiêklszej)

													;Zmienne programu
currLen QWORD ?											;Piwot czyli obecna pozycja w du¿ej pêtli od koñca
currLenAddr QWORD ?										;Aders na który wskazuje piwot czyli pozycja du¿ej pêtli
i QWORD ?												;Pozycja w ma³ej pêtli od pocz¹rtku
iAddr QWORD ?											;Adres pozycji ma³ej pêtli
zer QWORD 0												;Wartoœæ Zero
jed QWORD 1												;Wartoœæ Jeden

.code
			
													;G³ówna funkcja programu

quickselect PROC lenArg: QWORD, numListArg: QWORD, kArg: QWORD, SortBiggestArg: QWORD
	
														;Po kolei ³aduje przekazane parametry, które zapisane s¹ w wybranych rejestrach i na stosie do zmiennych
														;	poniewa¿ przekazywany jest adres wartoœci to trzeba siê wpierw dostaæ do danej
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
	JS toSmall											;Je¿eli k jest mniejsze od 0 (tutaj sprawdza czy jest znakowane bo tylko licznby ujemne s¹ znakowane) to algoEnd programu bo nie ma pozycji ujemnej
	JZ toSmall											;Je¿eli k jest 0 to algoEnd bo nie ma pozycji zero
	CMP rax, len										;Sprawdza czy k nie jest d³u¿sze od tablicy bo nie ma takiej pozycji
	JA toBig											;Je¿eli jest wiêksze to skok

	DEC k												;Obni¿a k o jeden bo tablica jest od 0

	MOV rax, len
	MOV currLen, rax									;Wpisuje d³ugoœæ tablicy do currLen

	MOV rbx, numList									;Nie mo¿na bezpoœrednio przepisaæ danych ze zemiennej do zmiennej, trzeba poœredniczyæ przez rejestr
	MOV currLenAddr, rbx								;£aduje pozycjê pierwszego elementu w tablicy
	IMUL rax, 8											;Mno¿y iloœæ pól w tablicy razy 8 bajty
	ADD currLenAddr, rax								;Dodaje do pozycji tablicy jej d³ugoœæ i skacze do ostatniego elemetu

	bigLoop:										;Du¿a pêtla wykonuje siê tyle razy jak odleg³a jest liczba 
		MOV rax, currLen
		CMP rax, k										;Porównuje czy nie zosta³a ju¿ odnaleziona szukana liczba k
		JE algoEnd										;Je¿eli currLen jest równe k to algoEnd bo liczba zosta³a znjaleziona

		DEC currLen										;Przy ka¿dym powtórzeniu dekrementuje currLen bo przsówa biwot do pocz¹tku tablicy
		SUB currLenAddr, 8								;Dekrementuje te¿ adres pivota
		MOV i, 0										;Zeruje i przez ma³¹ pêtl¹
		MOV rax, numList
		MOV iAddr, rax
		;MOV iAddr,  numList						;Do zmiennej iteracji wrzuca adres pierwszego elementu tablicy
		MOV rax, [iAddr + 8]							;£aduje wartoœæ o 1 wy¿szego elementu tablicy 

		
		smallLoop:									;Ma³a pêtla powtarza siê tyle razy ile jest elementów od pocz¹tku tablicy do pivota

			MOV rax, i	
			CMP rax, currLen							;Sprawdza czy ma³a pêtla nie dobieg³a do koñca tablicy 
			JE bigLoop									;Je¿eli to algoEnd to skacze do du¿ej pêtli

			MOV rax, sortBiggest	
			CMP rax,jed									;Sprawdza czy szukamy liczby najmniejsze czy najwiêkszej
			JE isBiggest								;Je¿eli 1 to najwiêksza
			JB notIsBiggest								;Je¿eli 0 to najmniejsza

		returnPoint:								;Punkt powrtu z funkcji edycji elementów tablicy (zamiany)

			INC i										;Inkrementuje o 1
			ADD iAddr, 8								;Za ka¿dym powtórzeniem przesówa adres do kolejnego pola w tablicy
			JMP smallLoop								;Bezwarunkowy skok do ma³ej pêtli



	
	isBiggest:										;Obliczenia dla liczby najwiêkszej
		MOV rcx, iAddr									;UWAGA ZAPISAÆ WARTOŒÆ POD DANYM ADRESEM MO¯NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA£ADOWAÆ DO REJESTU.	£aduje adres elementu i do rejestru 
		MOV rax, [rcx]									;£aduje adres obecnego elementu i
		MOV rcx, currLenAddr							;£aduje adres j do rejestru
		MOV rbx, [rcx]									;£aduje adres obecnego element ucurrLen	

		CMP rax, rbx									;Porównuje czy liczba pod i jest mniejsz lub równa od liczby pod adresem currLen
		JB returnPoint									;Je¿eli i jest mniejsze to wraca do ma³ej pêtli
		JE returnPoint									;Je¿eli i jest równe to raca do ma³ej pêtli

														;Je¿eli jest i jest wiêksze to kontynuuje

		MOV rcx, iAddr									;£aduje adres elementu i bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [rcx], rbx	;Pod i wpisuje currLen			;£aduje pod element i wartoœæ elementu j
		MOV rcx, currLenAddr							;£aduje adres elementu j bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [rcx], rax	;Pod currLen wpisuje i			;£aduje pod element j wartoœæ elementu i

		JMP returnPoint									;Wraca

													
	notIsBiggest:									;Oblicznia dla liczby najmniejszej
		MOV rcx, iAddr									;UWAGA ZAPISAÆ WARTOŒÆ POD DANYM ADRESEM MO¯NA TYLKO PRZEZ REJESTR, WPIERW TRZEBA DANY ADRES ZA£ADOWAÆ DO REJESTU.	£aduje adres elementu i do rejestru 
		MOV rax, [rcx]									;£aduje adres obecnego elementu i
		MOV rcx, currLenAddr							;£aduje adres j do rejestru
		MOV rbx, [rcx]									;£aduje adres obecnego element ucurrLen	

		CMP rax, rbx									;Porównuje czy liczba pod i jest mniejsz lub równa od liczby pod adresem currLen
		JA returnPoint									;Je¿eli i jest wiêksze to wraca do ma³ej pêtli
		JE returnPoint									;Je¿eli i jest równe to raca do ma³ej pêtli

														;Je¿eli jest i jest mnijesze to kontynuuje

		MOV rcx, iAddr									;£aduje adres elementu i bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [rcx], rbx	;Pod i wpisuje currLen			;£aduje pod element i wartoœæ elementu j
		MOV rcx, currLenAddr							;£aduje adres elementu j bo tylko przez rejestr mo¿na skorzystaæ z adresu
		MOV [rcx], rax	;Pod currLen wpisuje i			;£aduje pod element j wartoœæ elementu i

		JMP returnPoint									;Wraca

	
	toBig:											;Je¿eli wyznaczone k bêdzie z du¿e 
		MOV rax, -1										;Inforacja do mnie ¿e nie mo¿na u¿yæ algorytmu
		JMP	finalEnd								

	toSmall:										;Je¿eli wyznaczone k bêdzie za ma³e
		MOV rax, k
		MOV rax, -2										;Inforacja do mnie ¿e nie mo¿na u¿yæ algorytmu
		JMP finalEnd

	
	algoEnd:										;Kiedy algorytm siê zakoñczy i nie bêdzie b³êdu	
		MOV rax, k										;Wczytuje k element z listy by wyœwitliæ szukany element, Tu wpisuje go do rejestru rdx
		IMUL rax, 8
		MOV rbx,  numList
		ADD rbx,rax
		MOV rax, [rbx]

		jmp finalEnd	
	 

	finalEnd:									;Funkcja koñcz¹ca program i zwracaj¹ca wynik, zwracana jest zawartoœc rejestru RAX		
		ret											;Powrót do copp
		



quickselect ENDP

END 