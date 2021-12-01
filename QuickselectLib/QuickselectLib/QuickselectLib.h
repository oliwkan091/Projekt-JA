// QuickselectLib.h - Zawiera funkcje odpoiwadaj�ce za znajdowanie wybranego elementu metod� quicksort

#ifdef MATHLIBRARY_EXPORTS
#define QUICKSELECTLIB __declspec(dllexport)
#else
#define QUICKSELECTLIB __declspec(dllimport)
#endif

//Funkcja oblicza k najwi�kszy lub najmniejszy element tablicy 
//len - dlugosc tablicy
//tab[] tablica z danymi
//k - element do znalezienia 
//biggest 
//      je�eli true to funkcja szuka k najwi�kszego elementu
//      je�eli fasle to funkcja szuka k najwi�kszego elementu
extern "C" QUICKSELECTLIB int quicselect(
    int len, int tab[], int k, bool sortBiggest, bool& isError, std::string & errorMsg);