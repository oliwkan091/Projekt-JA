#include <iostream>
#include <fstream>
#include <vector>
#include <thread>
#include <chrono>
#include "QuickselectLib.h"



void sortFunc(int dataLength, int tab[], int k, bool biggest)
{
    std::cout << quicselect(dataLength, tab, k, biggest) << std::endl;
}

int* readTxtFile(std::string fileName, int& dataLength)
{
    std::fstream file;
    file.open(fileName, std::ios::in);
    if (file.good())
    {
        file >> dataLength;
        std::cout << dataLength << std::endl;
        int* data = new int[dataLength];

        int i = 0;
        while (file >> data[i]) { i++; }

        file.close();

        return data;
    }
    else
    {
        std::cout << "Plik nie istnieje";
        return nullptr;
    }
}

int main()
{
    //int tab[5] = { 1,8,4,5,3 };
    std::string fileName = "numbers.txt";
    int threadsNumber = 500;
    int dataLength;
    int k = 3;
    bool biggest = true;
    int* tab = readTxtFile(fileName, dataLength);
    std::vector <std::thread> threadList;
    for (int i = 0; i < threadsNumber; i++)
    {
        threadList.push_back(std::thread(sortFunc, dataLength, tab, k, biggest));
    }

    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < threadsNumber; i++)
    {
        if (threadList[i].joinable())
        {
            threadList[i].join();
        }
    }

    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    auto milisec = duration.count();
    std::cout << "mikrosekundy: " << milisec << std::endl;
    std::cout << "sekundy: " << milisec/1000000<< std::endl;

    return 0;
}