#include <iostream>
#include <fstream>

int quicselect(int len, int tab[], int k, bool biggest)
{
    k--;
    if (len > k)
    {
        int j, currLen = len;
        while (currLen != k)
        {
            j = currLen - 1;
            for (int i = 0; i <= j; i++)
            {
                if (((biggest) and (tab[i] > tab[j])) or ((not biggest) and (tab[i] < tab[j])))
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
        std::cout << std::endl << "Nie ma tylu elementów w ³añcuchu" << std::endl;
        return 0;
    }
}


int* readTxtFile(std::string fileName, int& dataLength)
{
    std::fstream file;
    file.open(fileName, std::ios::in);

    file >> dataLength;
    int* data = new int[dataLength];

    int i = 0;
    while (file >> data[i]) { i++; }

    file.close();

    return data;
}


int main()
{
    int tab[5] = { 9,3,1,5,2 };
    int dataLength = 0;
    int* data = readTxtFile("numbers.txt", dataLength);

    std::cout<<quicselect(dataLength,data,5,true);
}
