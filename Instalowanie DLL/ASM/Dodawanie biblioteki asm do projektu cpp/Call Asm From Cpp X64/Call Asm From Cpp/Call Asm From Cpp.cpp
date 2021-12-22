#include <windows.h>
#include <iostream>

extern "C"  int _stdcall MyProc1(int p1, int* p2);

int main()
{
	int a = 3,z = 0;
	int* tab = new int[3];
	tab[0] = 10;
	tab[1] = 20;
	tab[2] = 30;
	//std::cout << "Size x: " << sizeof(x) << std::endl << std::endl;
	//£aduje funkcje MyProc1 z biblioteki JALib.dll napisanej w asm w sposób statyczny
		//Funkcja przyk³adowa pobiera³a dwie zmienne int i zwraca³a ich sumê
	z = MyProc1(a, tab);

	std::cout << "Wynik: " << z << std::endl << std::endl;
}
