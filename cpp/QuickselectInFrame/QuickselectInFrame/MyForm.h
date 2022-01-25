#pragma once

#include <direct.h>
#include <iostream>
#include <fstream>
#include <string>
#include <thread>
#include <vector>
#include <chrono>
#include <conio.h>
#include "QuickselectLib.h"
#include <msclr\marshal_cppstd.h>

//Niezb�dna biblioteka do podpi�cia funkcji asm
#include <windows.h>
//Podpi�ta funkcja asm
extern "C" __int64 _stdcall quickselect(__int64* len, __int64* numList, __int64* k, __int64* sortBiggest);



namespace QuickselectInFrame {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for MyForm
	/// </summary>
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Button^ buttonStart;
	private: System::Windows::Forms::Label^ labelTitle;
	protected:

	protected:


	private: System::Windows::Forms::TextBox^ textBoxFile;

	private: System::Windows::Forms::Label^ labelCore;
	private: System::Windows::Forms::Label^ labelFile;
	private: System::Windows::Forms::Label^ label1;

	private: System::Windows::Forms::Label^ label2;

	private: System::Windows::Forms::ComboBox^ comboBoxCore;
	private: System::Windows::Forms::Label^ labelError;
	private: System::Windows::Forms::ComboBox^ comboBoxDesc;
	private: System::Windows::Forms::Label^ labelTime;
	private: System::Windows::Forms::Label^ labelCppAsm;
	private: System::Windows::Forms::ComboBox^ comboBoxCppAsm;



	private: System::Windows::Forms::TextBox^ textBoxK;












	protected:

	private:

		//Zarz�dza wielow�tkowym dzia�aniem assemblera
		static void quickselectASMMan(__int64* dataLength, __int64* tab, __int64* k, __int64* biggest, int threedID, int numberOfElements)
		{
			//Wywo�uje funkcj� assemblera po kolei tyle razy ile podano 
			for (int i = 0; i < numberOfElements; i++)
			{	
				//Wywo�uje funkcj� odpowiedzialn� za obs�ug� assemblera 
				quickselectAsm(dataLength, tab,k , biggest, threedID + i);
			}
		}


		//Zarz�dza wielow�tkowym dzia�aniem CPP
		static void quickselectCPPMan(int dataLength, int* tab, int k, bool biggest, int threedID, int numberOfElements)
		{
			//Wywo�uje funkcj� cpp po kolei tyle razy ile podano 
			for (int i = 0; i < numberOfElements; i++)
			{
				//Wywo�uje funkcj� odpowiedzialn� za obs�ug� cpp 
				quickselectCpp(dataLength, tab, k, biggest,true,"", threedID + i);
			}
		}

		//Obs�uguje algorytm quicksort w j�zyku cpp
		static void quickselectCpp(int dataLength, int tab[], int k, bool biggest,bool qError,std::string qErrorMsg,int threadID)
		{
			int resoult = quicselect(dataLength, tab, k, biggest, qError, qErrorMsg);

			std::fstream f1;
			f1.open(".\\CPP\\Wynik" + std::to_string(threadID + 1) + ".txt", std::ios::out);
			f1 << resoult;
			f1.close();
		}

		//Obs�uguje algorytm quicksort w j�zyku asm
		static void quickselectAsm(__int64* len, __int64* numList, __int64* k, __int64* sortBiggest,int threadID)
		{
			__int64 resoult = quickselect(len, numList, k, sortBiggest);

			std::fstream f1;
			f1.open("ASM\\Wynik" + std::to_string(threadID + 1) + ".txt", std::ios::out);
			f1 << resoult;
			f1.close();
		}


		//Konwertuje specyficzny string Windows Fomrms do normalnego stringa
		std::string sStringToString(System::String^ sString)
		{
			msclr::interop::marshal_context context;
			std::string standardString = context.marshal_as<std::string>(sString);
			return standardString;
		}

		//Konwertuje normalny string do s[ecywicznego string Windows Forms
		System::String^ stringtosstring(std::string string)
		{
			msclr::interop::marshal_context context;
			System::String^ systemString = context.marshal_as<System::String^>(string);
			return systemString;
		}

		//Wczytuje plik z danymi i przepisuje do tablicy int�w
		int* readTxtFile(std::string fileName, int &dataLength,int &fileError)
		{
			std::fstream file;
			file.open(fileName, std::ios::in);

			if (file.good())
			{
				try
				{
					file >> dataLength;
					int* data = new int[dataLength];
					std::string dataLine;

					int i = 0;
					while (file >> dataLine)
					{
						if (i == dataLength) { fileError = 3; return nullptr; }

						data[i] = std::stoi(dataLine);
						i++;
					}

					file.close();

					if (i != dataLength) 
					{ 
						fileError = 3;
						return nullptr;
					}

					return data;

				}
				catch (std::exception e)
				{
					file.close();
					fileError = 2;
					return nullptr;
				}
			}
			fileError = 1;
			return nullptr;
		}

		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container^ components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->buttonStart = (gcnew System::Windows::Forms::Button());
			this->labelTitle = (gcnew System::Windows::Forms::Label());
			this->textBoxFile = (gcnew System::Windows::Forms::TextBox());
			this->labelCore = (gcnew System::Windows::Forms::Label());
			this->labelFile = (gcnew System::Windows::Forms::Label());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->textBoxK = (gcnew System::Windows::Forms::TextBox());
			this->comboBoxCore = (gcnew System::Windows::Forms::ComboBox());
			this->labelError = (gcnew System::Windows::Forms::Label());
			this->comboBoxDesc = (gcnew System::Windows::Forms::ComboBox());
			this->labelTime = (gcnew System::Windows::Forms::Label());
			this->labelCppAsm = (gcnew System::Windows::Forms::Label());
			this->comboBoxCppAsm = (gcnew System::Windows::Forms::ComboBox());
			this->SuspendLayout();
			// 
			// buttonStart
			// 
			this->buttonStart->AutoSizeMode = System::Windows::Forms::AutoSizeMode::GrowAndShrink;
			this->buttonStart->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 16.2F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->buttonStart->Location = System::Drawing::Point(191, 241);
			this->buttonStart->Margin = System::Windows::Forms::Padding(2);
			this->buttonStart->Name = L"buttonStart";
			this->buttonStart->Size = System::Drawing::Size(84, 37);
			this->buttonStart->TabIndex = 0;
			this->buttonStart->Text = L"Start";
			this->buttonStart->UseVisualStyleBackColor = true;
			//this->buttonStart->Click += gcnew System::EventHandler(this, &MyForm::buttonStart_Click);
			this->buttonStart->MouseClick += gcnew System::Windows::Forms::MouseEventHandler(this, &MyForm::buttonStart_Click);
			// 
			// labelTitle
			// 
			this->labelTitle->AutoSize = true;
			this->labelTitle->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 25.8F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->labelTitle->Location = System::Drawing::Point(128, 28);
			this->labelTitle->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelTitle->Name = L"labelTitle";
			this->labelTitle->Size = System::Drawing::Size(199, 39);
			this->labelTitle->TabIndex = 1;
			this->labelTitle->Text = L"Quickselect";
			this->labelTitle->Click += gcnew System::EventHandler(this, &MyForm::label1_Click);
			// 
			// textBoxFile
			// 
			this->textBoxFile->Location = System::Drawing::Point(371, 133);
			this->textBoxFile->Margin = System::Windows::Forms::Padding(2);
			this->textBoxFile->Name = L"textBoxFile";
			this->textBoxFile->Size = System::Drawing::Size(76, 20);
			this->textBoxFile->TabIndex = 3;
			// 
			// labelCore
			// 
			this->labelCore->AutoSize = true;
			this->labelCore->Location = System::Drawing::Point(25, 117);
			this->labelCore->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelCore->Name = L"labelCore";
			this->labelCore->Size = System::Drawing::Size(250, 13);
			this->labelCore->TabIndex = 4;
			this->labelCore->Text = L"Podaj ilo�� w�tk�w do obs��u�enia algorytmu (1-64)";
			this->labelCore->Click += gcnew System::EventHandler(this, &MyForm::label2_Click);
			// 
			// labelFile
			// 
			this->labelFile->AutoSize = true;
			this->labelFile->Location = System::Drawing::Point(25, 140);
			this->labelFile->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelFile->Name = L"labelFile";
			this->labelFile->Size = System::Drawing::Size(151, 13);
			this->labelFile->TabIndex = 5;
			this->labelFile->Text = L"Podaj nazw� pliku txt z danymi";
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(25, 164);
			this->label1->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(142, 13);
			this->label1->TabIndex = 7;
			this->label1->Text = L"Jaki element chcesz znale��";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(25, 187);
			this->label2->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(92, 13);
			this->label2->TabIndex = 10;
			this->label2->Text = L"Kt�ry w kolejno�ci";
			// 
			// textBoxK
			// 
			this->textBoxK->Location = System::Drawing::Point(371, 180);
			this->textBoxK->Margin = System::Windows::Forms::Padding(2);
			this->textBoxK->Name = L"textBoxK";
			this->textBoxK->Size = System::Drawing::Size(76, 20);
			this->textBoxK->TabIndex = 11;
			// 
			// comboBoxCore
			// 
			this->comboBoxCore->FormattingEnabled = true;
			this->comboBoxCore->Items->AddRange(gcnew cli::array< System::Object^  >(64) {
				L"1", L"2", L"3", L"4", L"5", L"6", L"7", L"8",
					L"9", L"10", L"11", L"12", L"13", L"14", L"15", L"16", L"17", L"18", L"19", L"20", L"21", L"22", L"23", L"24", L"25", L"26",
					L"27", L"28", L"29", L"30", L"31", L"32", L"33", L"34", L"35", L"36", L"37", L"38", L"39", L"40", L"41", L"42", L"43", L"44",
					L"45", L"46", L"47", L"48", L"49", L"50", L"51", L"52", L"53", L"54", L"55", L"56", L"57", L"58", L"59", L"60", L"61", L"62",
					L"63", L"64"
			});
			this->comboBoxCore->Location = System::Drawing::Point(371, 109);
			this->comboBoxCore->Margin = System::Windows::Forms::Padding(2);
			this->comboBoxCore->Name = L"comboBoxCore";
			this->comboBoxCore->Size = System::Drawing::Size(76, 21);
			this->comboBoxCore->TabIndex = 13;
			// 
			// labelError
			// 
			this->labelError->AutoSize = true;
			this->labelError->Location = System::Drawing::Point(95, 317);
			this->labelError->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelError->Name = L"labelError";
			this->labelError->Size = System::Drawing::Size(16, 13);
			this->labelError->TabIndex = 14;
			this->labelError->Text = L"---";
			// 
			// comboBoxDesc
			// 
			this->comboBoxDesc->FormattingEnabled = true;
			this->comboBoxDesc->Items->AddRange(gcnew cli::array< System::Object^  >(2) { L"Najwi�kszy", L"Najmniejszy" });
			this->comboBoxDesc->Location = System::Drawing::Point(371, 156);
			this->comboBoxDesc->Margin = System::Windows::Forms::Padding(2);
			this->comboBoxDesc->Name = L"comboBoxDesc";
			this->comboBoxDesc->Size = System::Drawing::Size(76, 21);
			this->comboBoxDesc->TabIndex = 15;
			// 
			// labelTime
			// 
			this->labelTime->AutoSize = true;
			this->labelTime->Location = System::Drawing::Point(95, 340);
			this->labelTime->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelTime->Name = L"labelTime";
			this->labelTime->Size = System::Drawing::Size(16, 13);
			this->labelTime->TabIndex = 16;
			this->labelTime->Text = L"---";
			// 
			// labelCppAsm
			// 
			this->labelCppAsm->AutoSize = true;
			this->labelCppAsm->Location = System::Drawing::Point(25, 211);
			this->labelCppAsm->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->labelCppAsm->Name = L"labelCppAsm";
			this->labelCppAsm->Size = System::Drawing::Size(53, 13);
			this->labelCppAsm->TabIndex = 17;
			this->labelCppAsm->Text = L"Jaki j�zyk";
			// 
			// comboBoxCppAsm
			// 
			this->comboBoxCppAsm->FormattingEnabled = true;
			this->comboBoxCppAsm->Items->AddRange(gcnew cli::array< System::Object^  >(2) { L"CPP", L"ASM" });
			this->comboBoxCppAsm->Location = System::Drawing::Point(371, 204);
			this->comboBoxCppAsm->Margin = System::Windows::Forms::Padding(2);
			this->comboBoxCppAsm->Name = L"comboBoxCppAsm";
			this->comboBoxCppAsm->Size = System::Drawing::Size(76, 21);
			this->comboBoxCppAsm->TabIndex = 18;
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(479, 385);
			this->Controls->Add(this->comboBoxCppAsm);
			this->Controls->Add(this->labelCppAsm);
			this->Controls->Add(this->labelTime);
			this->Controls->Add(this->comboBoxDesc);
			this->Controls->Add(this->labelError);
			this->Controls->Add(this->comboBoxCore);
			this->Controls->Add(this->textBoxK);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->label1);
			this->Controls->Add(this->labelFile);
			this->Controls->Add(this->labelCore);
			this->Controls->Add(this->textBoxFile);
			this->Controls->Add(this->labelTitle);
			this->Controls->Add(this->buttonStart);
			this->Margin = System::Windows::Forms::Padding(2);
			this->Name = L"MyForm";
			this->Text = L"MyForm";
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private: System::Void label2_Click(System::Object^ sender, System::EventArgs^ e) {}
	private: System::Void label1_Click(System::Object^ sender, System::EventArgs^ e) {}

		private: System::Void buttonStart_Click(System::Object^ sender, System::Windows::Forms::MouseEventArgs^ e)
		{
	//Po naci�ni�ciu przycisku "START"

			//Je�eli dosz�o do b��du podczas wprowadzania danych to true
			bool qError = false;
			bool wasDataLoaded = false;

			//comboBoxCore - Sprawdza ile w�tk�w ma zosta� wykorzystanych (1 - 64)
			int threadsNumber;
			try 
			{
				threadsNumber = std::stoi(sStringToString(comboBoxCore->Text));
				if ((threadsNumber < 1) || (threadsNumber > 64))
				{
					qError = true;
					labelError->Text = "Z�a ilo�� w�tk�w";
				}
			}
			catch (std::exception e)
			{
				qError = true;
				labelError->Text = "Prosze wybrac ilosc z rdzeni z podanych";
			}

			//textBoxFile - Sprawdza plik z danymi
			int dataLength;
			int* tab = nullptr;
			int readError = 0;
			if (!qError)
			{
				tab = readTxtFile(sStringToString(textBoxFile->Text), dataLength, readError);
				wasDataLoaded = true;

				if (readError == 1)
				{
					labelError->Text = "Nie ma takiego pliku";
					qError = true;
				}
				else if (readError == 2)
				{
					labelError->Text = "Baza danych jest b��dna";
					qError = true;
				}
				else if (readError == 3)
				{
					labelError->Text = "Podana d�ugo�� bazy danych na pierwszym polu jest nieprawid�owa" ;
					qError = true;
				}
			}

			//comboBoxDesc - Sprawdza czy szukana warto�� jest najmniejsza czy najwi�ksza
			bool desc;
			if (comboBoxDesc->Text != "Najmniejszy" && comboBoxDesc->Text != "Najwi�kszy")
			{
				labelError->Text = "Prosz� wybra� jaki element jest do znalezienia";
				qError = true;
			}
			else
			{
				if (sStringToString(comboBoxDesc->Text) == "Najmniejszy") { desc = true; }
				else { desc = false; }
			}

			//textBoxK - Sprawdza jaka liczba ma zosta� znaleziona (najmniejsza, najwi�ksza)
			int k;
			if (!qError)
			{
				try
				{
					k = std::stoi(sStringToString(textBoxK->Text));

					if ((k <= 0) || (k > dataLength))
					{
						labelError->Text = "k przekracza ilosc danych";
						qError = true;
					}
				}
				catch (std::exception e)
				{
					labelError->Text = "To nie jest liczba";
					qError = true;
				}
			}

			//comboBoxCppAsm - Sprawdza w jakim j�zyku ma zosta� wykonany algorytm
			if (!qError)
			{
				if (comboBoxCppAsm->Text != "CPP" && comboBoxCppAsm->Text != "ASM")
				{
					qError = true;
					labelError->Text = "Prosz� wybra� j�zyk";
				}
			}


			//Je�eli nie by�o �adnego b��du przechodzi do algorytmu
			if (!qError)
			{
				labelError->Text = "Obliczanie";
				labelError->Refresh();

				//Sekcja Cpp
				if (comboBoxCppAsm->Text == "CPP")
				{
						//Je�eli nie ma to tworzy folder
						mkdir("CPP\\");

						std::string qErrorMsg;

						int sortBiggest;
						if (sStringToString(comboBoxDesc->Text) == "Najmniejszy") { sortBiggest = 1; }
						else { sortBiggest = 0; }

						//Sta�a liczba wykona�
						int threads64 = 64;

						//Rozdziela ilo�� wywo�a� dla w�tku
						int modulo = threads64 % threadsNumber;
						int devided = threads64 / threadsNumber;
						int* elementTab = new int[threadsNumber];

						for (int i = 0; i < threadsNumber; i++)
						{
							elementTab[i] = devided;
							//Je�eli dzielenie jest nieca�kowite to trzeba doda� po jednym wykonaniu w miar� po r�wno 
							if (i < modulo)
							{
								elementTab[i] += 1;
							}
						}

						//Numer do zpaisu danych 
						int startElement = 0;
						//Zaczyna liczy� czas
						auto start = std::chrono::high_resolution_clock::now();

						for (int i = 0; i < threadsNumber; i++)
						{
							if (elementTab[i] != 0)
							{
								std::thread th(quickselectCPPMan, dataLength, tab, k, sortBiggest, startElement, elementTab[i]);
								th.join();
								startElement += elementTab[i];
							}
						}
						//Jak wszystkie w�tki si� zako�cz� podsumowuje czas
						auto stop = std::chrono::high_resolution_clock::now();
						auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
						auto milisec = duration.count();
						std::fstream fz;
						fz.open("TimeRes.txt", std::ios::out);
						fz << milisec;
						fz << "\n";
						fz.close();
						labelTime->Text = "Czas trwanie: " + milisec + " milisekund";
				}
				//Sekcja Asm
				else if (comboBoxCppAsm->Text == "ASM")
				{

					//Je�eli nie ma to tworzy folder
					mkdir("ASM\\");

					__int64* sortBiggest = nullptr;
					if (sStringToString(comboBoxDesc->Text) == "Najmniejszy") { sortBiggest = new __int64(1); }
					else { sortBiggest = new __int64(0); }

					__int64* len = new __int64(dataLength);
					__int64* numList = new __int64[*len];
					for (int j = 0; j < *len; j++)
					{
						numList[j] = tab[j];
					}
					__int64* k2 = new __int64(k);

					//Sta�a liczba wykona�
					int threads64 = 64;

					//Rozdziela ilo�� wywo�a� dla w�tku
					int modulo = threads64 % threadsNumber;
					int devided = threads64 / threadsNumber;
					int* elementTab = new int[threadsNumber];

					for (int i = 0; i < threadsNumber; i++)
					{
						elementTab[i] = devided;
						//Je�eli dzielenie jest nieca�kowite to trzeba doda� po jednym wykonaniu w miar� po r�wno 
						if (i < modulo)
						{
							elementTab[i] += 1;
						}
					}

					//Numer do zpaisu danych 
					int startElement = 0;
					//Zaczyna liczy� czas
					auto start = std::chrono::high_resolution_clock::now();

					for (int i = 0; i < threadsNumber; i++)
					{
						if (elementTab[i] != 0)
						{
							std::thread th(quickselectASMMan, len, numList, k2, sortBiggest, startElement, elementTab[i]);
							th.join();
							startElement += elementTab[i];
						}
					}

					auto stop = std::chrono::high_resolution_clock::now();
					auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
					auto milisec = duration.count();

					std::fstream fz;
					fz.open("TimeRes.txt", std::ios::out);
					fz << milisec;
					fz << "\n";
					fz.close();

					labelTime->Text = "Czas trwanie: " + milisec + " milisekund";
					
					//Nigdy nie jest nullptr
					delete[] elementTab;
					delete len;
					delete k2;
					delete[] numList;
					delete sortBiggest;
				}

				labelError->Text = "Zako�czono";
			}

			//Je�eli jakie� dane zosta�y wczytane to je usuwa by nie za�mieca� pami�ci 
			if (wasDataLoaded)
			{
				wasDataLoaded = false;

				if (tab != nullptr)
				{
					delete[] tab;
				}
			}
		}


	};
}