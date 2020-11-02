/* -- Laboratory work #4
 * -- F1: D = (SORT(A + B) + C) *(MA*ME)
 * -- F2: ML = SORT(MF + MG*MH)
 * -- F3: T = (O + P)*(MP * MS)
 * -- Date 11.11.2020
 */
#include <iostream>
#include "Data.h"
#include <omp.h>
Data data = Data(4);
void F1();
void F2();
void F3();
int main() {
	std::cout << "Lab5 has started.\n" << std::endl;
	omp_set_num_threads(3);
#pragma omp parallel sections num_threads(3)
	{
		#pragma omp sections
		{
			#pragma omp section
			{
				F1();
			}
			#pragma omp section
			{
				F2();
			}
			#pragma omp section
			{
				F3();
			}
		}
	}
	std::cout << "Lab5 has finished.\n" << std::endl;
	return 0;
}
void F1() {
	std::cout << "F1 started.\n" << std::endl;
	int n = data.getN();
	int* A = new int[n];
	int* B = new int[n];
	int* C = new int[n];
	int** MA = new int* [n];
	int** ME = new int* [n];
	for (int i = 0; i < n; i++)
	{
		MA[i] = new int[n];
		ME[i] = new int[n];
	}
	int* D;
	data.VectorFill(A);
	data.VectorFill(B);
	data.VectorFill(C);
	data.MatrixFill(MA);
	data.MatrixFill(ME);
	D = data.Func1(A, B, C, MA, ME);
	std::cout << "D = \n";
	data.VectorOutput(D);
	delete[] A;
	delete[] B;
	delete[] C;
	for (int i = 0; i < n; i++)
	{
		delete[] MA[i];
		delete[] ME[i];
	}
	delete[] MA;
	delete[] ME;
	delete[] D;
	std::cout << "F1 ended.\n";
}
void F2() {
	std::cout << "F2 started.\n" << std::endl;
	int n = data.getN();
	int** MF = new int* [n];
	int** MG = new int* [n];
	int** MH = new int* [n];
	for (int i = 0; i < n; i++)
	{
		MF[i] = new int[n];
		MG[i] = new int[n];
		MH[i] = new int[n];
	}
	int** ML;
	data.MatrixFill(MF);
	data.MatrixFill(MG);
	data.MatrixFill(MH);
	ML = data.Func2(MF, MG, MH);
	std::cout << "ML = \n" << std::endl;
	data.MatrixOutput(ML);
	for (int i = 0; i < n; i++)
	{
		delete[] MF[i];
		delete[] MG[i];
		delete[] MH[i];
		delete[] ML[i];
	}
	delete[] MF;
	delete[] MG;
	delete[] MH;
	delete[] ML;
	std::cout << "F2 ended.\n";
}
void F3() {
	std::cout << "F3 started.\n" << std::endl;
	int n = data.getN();
	int* O = new int[n];
	int* P = new int[n];
	int** MP = new int* [n];
	int** MS = new int* [n];
	for (int i = 0; i < n; i++)
	{
		MP[i] = new int[n];
		MS[i] = new int[n];
	}
	int* T;
	data.VectorFill(O);
	data.VectorFill(P);
	data.MatrixFill(MP);
	data.MatrixFill(MS);
	T = data.Func3(O, P, MP, MS);
	std::cout << "T = \n" << std::endl;
	data.VectorOutput(T);
	delete[] O;
	delete[] P;
	for (int i = 0; i < n; i++)
	{
		delete[] MP[i];
		delete[] MS[i];
	}
	delete[] T;
	std::cout << "F3 ended.\n";
}