#include <windows.h>
#include <iostream>

extern "C" int _stdcall MyProc1(DWORD x, DWORD y);

int main()
{
	std::cout << "Start" << std::endl << std::endl;

	int x = 3, y = 4, z = 0;
	//£aduje funkcje MyProc1 z biblioteki JALib.dll napisanej w asm w sposób statyczny
		//Funkcja przyk³adowa pobiera³a dwie zmienne int i zwraca³a ich sumê
	z = MyProc1(x, y);

	std::cout << "Wynik: " << z << std::endl << std::endl;
}
