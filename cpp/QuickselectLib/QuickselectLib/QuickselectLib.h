// QuickselectLib.h - Zawiera funkcje odpoiwadaj¹ce za znajdowanie wybranego elementu metod¹ quicksort

#ifdef MATHLIBRARY_EXPORTS
#define QUICKSELECTLIB __declspec(dllexport)
#else
#define QUICKSELECTLIB __declspec(dllimport)
#endif

//Funkcja oblicza k najwiêkszy lub najmniejszy element tablicy 
//len - dlugosc tablicy
//tab[] tablica z danymi
//k - element do znalezienia 
//biggest 
//      je¿eli true to funkcja szuka k najwiêkszego elementu
//      je¿eli fasle to funkcja szuka k najwiêkszego elementu
extern "C" QUICKSELECTLIB int quicselect(
    int len, int tab[], int k, bool sortBiggest, bool& isError, std::string & errorMsg);