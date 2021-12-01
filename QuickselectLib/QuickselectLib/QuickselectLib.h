// QuickselectLib.h - Zawiera funkcje odpoiwadające za znajdowanie wybranego elementu metodą quicksort

#ifdef MATHLIBRARY_EXPORTS
#define QUICKSELECTLIB __declspec(dllexport)
#else
#define QUICKSELECTLIB __declspec(dllimport)
#endif

//Funkcja oblicza k największy lub najmniejszy element tablicy 
//len - dlugosc tablicy
//tab[] tablica z danymi
//k - element do znalezienia 
//biggest 
//      jeżeli true to funkcja szuka k największego elementu
//      jeżeli fasle to funkcja szuka k największego elementu
extern "C" QUICKSELECTLIB int quicselect(
    int len, int tab[], int k, bool sortBiggest, bool& isError, std::string & errorMsg);