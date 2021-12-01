#include <iostream>
#include <thread>

void func(std::string type)
{
	for (int i = 0; i < 1000; i++)
	{
		std::cout << type<< std::endl;
	}
}

void a(int x)
{

}

int main()
{

	std::thread z(a,1);
	z.join();
	/*std::thread t1(func,"si");
	std::thread t2(func,"hiii");
	std::thread t3(func,"zi");
	std::thread t4(func,"fi");
	t1.join();
	t2.join();
	t3.join();
	t4.join();*/
}