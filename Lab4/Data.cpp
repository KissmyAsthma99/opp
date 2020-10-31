#include <iostream>
#include "Data.h"
int n;
Data::Data(int n) {
	n = n;
}
int Data::getN() {
	return n;
}
void Data::VectorFillsOne(int* A) {
	for (int i = 0; i < n; i++)
	{
		A[i] = 5;
	}
}
void Data::MatrixFillsOne(int** MA) {
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			MA[i][j] = 5;
		}
	}
}
void Data::VectorSort(int* A) {
	int a;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			if (A[i] > A[j]) {
				a = A[i];
				A[i] = A[j];
				A[j] = a;
			}
		}
	}
}
void Data::MatrixSort(int** MA) {
	int a;
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			for (int k = 0; k < n; k++)
			{
				if (MA[i][j] > MA[i][k]) {
					a = MA[i][j];
					MA[i][j] = MA[i][k];
					MA[i][k] = a;
				}
			}
		}
	}
}
void Data::VectorOutput(int* A) {
	for (int i = 0; i < n; i++)
	{
		std::cout << A[i] << " " << std::endl;
	}
}
void Data::MatrixOutput(int** MA) {
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++) {
			std::cout << MA[i][j] << " ";
		}
		std::cout << "\n";
	}
	std::cout << "\n";
}
int* Data::VectorAdd(int* A, int* B) {
	int* Z = new int[n];
	for (int i = 0; i < n; i++)
	{
		Z[i] = A[i] + B[i];
	}
	return Z;
}
int* Data::VectorMatrixMult(int* A, int** MA) {
	int* Z = new int[n];
	int a;
	for (int i = 0; i < n; i++) {
		a = 0;
		for (int j = 0; j < n; j++) {
			a = A[i] * MA[i][j];
		}
		Z[i] = a;
	}
	return Z;
}
int** Data::MatrixAdd(int** MA, int** MB) {
	int** MZ = new int* [n];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			MZ[i][j] = MA[i][j] + MB[i][j];
		}
	}
	return MZ;
}
int** Data::MatrixMult(int** MA, int** MB) {
	int** MZ = new int* [n];
	for (int i = 0; i < n; i++)
	{
		MZ[i] = new int[n];
		for (int j = 0; j < n; j++)
		{
			MZ[i][j] = 0;
			for (int k = 0; k < n; k++)
			{
				MZ[i][j] = MA[i][k] * MB[k][j];
			}
		}
	}
	return MZ;
}
int* Data::Func1(int* A, int* B, int* C, int** MA, int** ME) {
	int* D = VectorAdd(A, B);
	VectorSort(D);
	int** MJ = MatrixMult(MA, ME);
	int* E = VectorAdd(D, C);
	D = VectorMatrixMult(E, MJ);
	delete[] E;
	for (int i = 0; i < n; i++) {
		delete[] MJ[i];
	}
	delete[] MJ;
	return D;
}
int** Data::Func2(int** MF, int** MG, int** MH) {
	int** MN = MatrixMult(MG, MH);
	int** ML = MatrixAdd(MF, MN);
	MatrixSort(ML);
	return ML;
}
int* Data::Func3(int* O, int* P, int** MP, int** MS) {
	int* I = VectorAdd(O, P);
	int** MD = MatrixMult(MP, MS);
	int* T = VectorMatrixMult(I, MD);
	return T;
}