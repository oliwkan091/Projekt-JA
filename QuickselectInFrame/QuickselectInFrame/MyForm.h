#pragma once

#include <iostream>
#include <fstream>
#include <string>
#include <thread>
#include <vector>
#include <chrono>
#include "QuickselectLib.h"
#include <msclr\marshal_cppstd.h>

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



	private: System::Windows::Forms::TextBox^ textBoxK;












	protected:

	private:

		static void sortFunc(int dataLength, int tab[], int k, bool biggest,bool qError,std::string qErrorMsg,int threadID)
		{
			int resoult = quicselect(dataLength, tab, k, biggest, qError, qErrorMsg);

			std::fstream f1;
			f1.open("Wynik" + std::to_string(threadID) + ".txt", std::ios::out);
			f1 << resoult;
			f1.close();
		}


		std::string sStringToString(System::String^ sString)
		{
			//System::String^ managedString = "test";

			msclr::interop::marshal_context context;
			std::string standardString = context.marshal_as<std::string>(sString);
			return standardString;
		}

		System::String^ stringtosstring(std::string string)
		{
			//system::string^ managedstring = "test";

			msclr::interop::marshal_context context;
			System::String^ systemString = context.marshal_as<System::String^>(string);
			return systemString;
		}

		//int quicselect(int len, int tab[], int k, bool sortBiggest, bool& isError, std::string& errorMsg)
		//{
		//	//Tablice zaczynaja sie od o elementu nie pierwszego
		//	k--;
		//	if (len > k || k < 1)
		//	{
		//		int j, currLen = len;
		//		while (currLen != k)
		//		{
		//			j = currLen - 1;
		//			for (int i = 0; i <= j; i++)
		//			{
		//				if (((sortBiggest) && (tab[i] > tab[j])) || ((!sortBiggest) && (tab[i] < tab[j])))
		//				{
		//					int temp = tab[i];
		//					tab[i] = tab[j];
		//					tab[j] = temp;
		//				}
		//			}

		//			currLen--;
		//		}


		//		return tab[currLen];
		//	}
		//	else
		//	{
		//		errorMsg = "Element poza lancuchem";
		//		isError = true;
		//		return 0;
		//	}
		//}


		int* readTxtFile(std::string fileName, int& dataLength,bool &fileError)
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


						//label1->Text = stringtosstring(dataLine);
						data[i] = std::stoi(dataLine);

						i++;
					}

					file.close();
					return data;

				}
				catch (std::exception e)
				{
					file.close();
					fileError = true;
					return nullptr;
				}
			}
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
			this->SuspendLayout();
			// 
			// buttonStart
			// 
			this->buttonStart->AutoSizeMode = System::Windows::Forms::AutoSizeMode::GrowAndShrink;
			this->buttonStart->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 16.2F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->buttonStart->Location = System::Drawing::Point(191, 239);
			this->buttonStart->Margin = System::Windows::Forms::Padding(2);
			this->buttonStart->Name = L"buttonStart";
			this->buttonStart->Size = System::Drawing::Size(84, 37);
			this->buttonStart->TabIndex = 0;
			this->buttonStart->Text = L"Start";
			this->buttonStart->UseVisualStyleBackColor = true;
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
			this->labelCore->Text = L"Podaj iloœæ w¹tków do obs³³u¿enia algorytmu (1-64)";
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
			this->labelFile->Text = L"Podaj nazwê pliku txt z danymi";
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(25, 164);
			this->label1->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(142, 13);
			this->label1->TabIndex = 7;
			this->label1->Text = L"Jaki element chcesz znaleŸæ";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(25, 187);
			this->label2->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(92, 13);
			this->label2->TabIndex = 10;
			this->label2->Text = L"Który w kolejnoœci";
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
			//this->labelError->Click += gcnew System::EventHandler(this, &MyForm::labelError_Click);
			// 
			// comboBoxDesc
			// 
			this->comboBoxDesc->FormattingEnabled = true;
			this->comboBoxDesc->Items->AddRange(gcnew cli::array< System::Object^  >(2) { L"Najwiêkszy", L"Najmniejszy" });
			this->comboBoxDesc->Location = System::Drawing::Point(371, 156);
			this->comboBoxDesc->Margin = System::Windows::Forms::Padding(2);
			this->comboBoxDesc->Name = L"comboBoxDesc";
			this->comboBoxDesc->Size = System::Drawing::Size(76, 21);
			this->comboBoxDesc->TabIndex = 15;

			for (int i = 0; i < 64; i++)
			{
				this->comboBoxCore->Items->Add(i + 1);
			}

			this->comboBoxCore->SelectedIndex = 0;
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
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(479, 385);
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
		bool qError = false;

		int threadsNumber;
		try 
		{
			threadsNumber = std::stoi(sStringToString(comboBoxCore->Text));
		}
		catch (std::exception e)
		{
			qError = true;
			labelError->Text = "Prosze wybrac ilosc z rdzeni z podanych";
		}

		int dataLength;
		int* tab = nullptr;
		if (!qError)
		{
			tab = readTxtFile(sStringToString(textBoxFile->Text), dataLength,qError);
			if (qError)
			{
				labelError->Text = "Baza danych jest b³êdna";
			}else if (tab == nullptr)
			{
				labelError->Text = "Nie ma takiego pliku";
				qError = true;
			}
		}

		bool desc;
		if (sStringToString(comboBoxDesc->Text) == "Najmniejszy") { desc = true; }
		else { desc = false; }

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


		if (!qError)
		{
			labelError->Text = "Obliczanie";
			labelError->Refresh();

			std::vector <std::thread> threadList;
			std::string qErrorMsg;

			for (int i = 0; i < threadsNumber; i++)
			{
				threadList.push_back(std::thread(sortFunc, dataLength, tab, k, desc, qError, qErrorMsg, i));
			}

			auto start = std::chrono::high_resolution_clock::now();

			for (int i = 0; i < threadsNumber; i++)
			{
				threadList[i].join();
			}

			auto stop = std::chrono::high_resolution_clock::now();
			auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
			auto milisec = duration.count();

			labelTime->Text = "Czas trwanie: " + milisec + " milisekund";
			//std::cout << "mikrosekundy: " << milisec << std::endl;
			//std::cout << "sekundy: " << milisec / 1000000 << std::endl;

			//labelError->Text = "mikrosekundy: " + milisec;

			if (tab != nullptr)
			{
				delete[] tab;
			}

			labelError->Text = "Zakoñczono";
		}

		/*for (int i = 0; i < 64; i++)
		{
			this->comboBoxCore->Items->Add(i + 1);
		}

		this->comboBoxCore->SelectedIndex = 0;*/
	}	
};
}