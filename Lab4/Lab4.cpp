/* -- Laboratory work #4
 * -- F1: D = (SORT(A + B) + C) *(MA*ME)
 * -- F2: ML = SORT(MF + MG*MH)
 * -- F3: T = (O + P)*(MP * MS)
 * -- Date 11.11.2020
 */
#include <iostream>
#include <windows.h>
#include "Data.h"
Data data = Data(2);
void F1();
void F2();
void F3();
int main() {
	DWORD tid1, tid2, tid3;
	HANDLE T1, T2, T3;
	std::cout << "Lab4 started." << std::endl;
	Sleep(1500);
	T1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)F1, NULL, 0, &tid1);
	T2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)F2, NULL, 0, &tid2);
	T3 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)F3, NULL, 0, &tid3);
	SetThreadPriority(T1, 3);
	SetThreadPriority(T2, 1);
	SetThreadPriority(T3, 2);
	WaitForSingleObject(T1, INFINITE);
	WaitForSingleObject(T2, INFINITE);
	WaitForSingleObject(T3, INFINITE);
	CloseHandle(T1);
	CloseHandle(T2);
	CloseHandle(T3);
	std::cout << "Lab4 end." << std::endl;
	return 0;
}
void F1() {
	std::cout << "F1 has started.\n" << std::endl;
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
	data.VectorFillsOne(A);
	data.VectorFillsOne(B);
	data.VectorFillsOne(C);
	data.MatrixFillsOne(MA);
	data.MatrixFillsOne(ME);
	D = data.Func1(A, B, C, MA, ME);
	//Sleep(1500);
	std::cout << "D = " << std::endl;
	data.VectorOutput(D);
	std::cout << "F1 finished.\n";
	delete[] A;
	delete[] B;
	delete[] C;
	for (int i = 0; i < n; i++) {
		delete[] MA[i];
		delete[] ME[i];
	}
	delete[] MA;
	delete[] ME;
	delete[] D;
}
void F2() {
	std::cout << "F2 has started." << std::endl;
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
	data.MatrixFillsOne(MF);
	data.MatrixFillsOne(MG);
	data.MatrixFillsOne(MH);
	ML = data.Func2(MF, MG, MH);
	//Sleep(1500);
	std::cout << "ML = \n" << std::endl;
	data.MatrixOutput(ML);
	std::cout << "F2 finished.\n" << std::endl;
	for (int i = 0; i < n; i++){
		delete[] MF[i];
		delete[] MG[i];
		delete[] MH[i];
		delete[] ML[i];
	}
	delete[] MF;
	delete[] MG;
	delete[] MH;
	delete[] ML;
}
void F3() {
	std::cout << "F3 has started." << std::endl;
	int n = data.getN();
	int* O = new int[n];
	int* P = new int[n];
	int** MP = new int* [n];
	int** MS = new int* [n];
	for (int i = 0; i < n; i++){
		MP[i] = new int[n];
		MS[i] = new int[n];
	}
	int* T;
	data.VectorFillsOne(O);
	data.VectorFillsOne(P);
	data.MatrixFillsOne(MP);
	data.MatrixFillsOne(MS);
	T = data.Func3(O,P,MP,MS);
	//Sleep(1500);
	std::cout << "T = " << std::endl;
	data.VectorOutput(T);
	std::cout << "F3 finished.\n" << std::endl;
	delete[] O;
	delete[] P;
	for (int i = 0; i < n; i++) {
		delete[] MP[i];
		delete[] MS[i];
	}
	delete[] MP;
	delete[] MS;
	delete[] T;
}