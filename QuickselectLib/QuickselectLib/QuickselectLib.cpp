// QuickselectLib.cpp : Definiuje funkcje weksportowane do DLL
#include "pch.h" // use stdafx.h in Visual Studio 2017 and earlier
#include <iostream>
#include "QuickselectLib.h"

//Cialo funkcji
int quicselect(int len, int tab[], int k, bool sortBiggest,bool &isError,std::string &errorMsg)
{
    //Tablice zaczynaja sie od o elementu nie pierwszego
    k--;
    if (len > k or k < 1)
    {
        int j, currLen = len;
        while (currLen != k)
        {
            j = currLen - 1;
            for (int i = 0; i <= j; i++)
            {
                if (((sortBiggest) and (tab[i] > tab[j])) or ((not sortBiggest) and (tab[i] < tab[j])))
                {
                    int temp = tab[i];
                    tab[i] = tab[j];
                    tab[j] = temp;
                }
            }

            currLen--;
        }


        return tab[currLen];
    }
    else
    {
        isError = true;
        errorMsg = "Element poza lancuchem";
        return 0;
    }
}
