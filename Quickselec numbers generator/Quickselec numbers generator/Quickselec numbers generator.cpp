#include <iostream>
#include <fstream>

int main()
{
    int numberOdRecords = 1000;
    std::fstream f1;
    f1.open("numbers.txt", std::ios::out);
    srand(time(NULL));

    f1 << numberOdRecords << std::endl;

    int record;
    for (int i = 0; i < numberOdRecords - 1; i++)
    {
        record = rand() % 100000;
        f1 << record;
        if (i != numberOdRecords - 2)
        {
            f1 << std::endl;
        }
        //std::cout << i << ". " << record << std::endl;
    }

    f1.close();

}
