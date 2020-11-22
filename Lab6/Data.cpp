#include "Data.h"
#include <iostream>
#include <omp.h>
int n;
Data::Data(int n) {
	n = n;
}
int Data::getN() {
	return n;
}
void Data::VectorFill(int* A) {
	for (int i = 0; i < n; i++) {
		A[i] = 1;
	}
}
void Data::MatrixFill(int** MA) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			MA[i][j] = 1;
		}
	}
}
void Data::VectorOutput(int* A) {
	for (int i = 0; i < n; i++) {
		std::cout << A[i] << " " << std::endl;
	}
}
void Data::MatrixOutput(int** MA) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			std::cout << MA[i][j] << " " << std::endl;
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
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			for (int k = 0; k < n; k++) {
				if(MA[i][j]> MA[i][k]){
					a = MA[i][j];
					MA[i][j] = MA[i][k];
					MA[i][k] = a;
				}
			}
		}
	}
}
int* Data::VectorSum(int*A,int* B){
	for(int i =0;i<n;i++){
		A[i] += B[i];
	}
	return A;
}
int** Data::MatrixSum(int** MA, int** MB) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			MA[i][j] += MB[i][j];
		}
	}
	return MA;
}
int* Data::VectorMatrixMult(int* A, int** MA) {
	int a = 0;
	int* M = new int [n];
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			a += A[j] * MA[j][i];
		}
		M[i] = a;
	}
	return M;
}
int** Data::MatrixMult(int** MA, int** MB) {
	int** MI = new int* [n];
	for (int i = 0; i < n; i++) {
		MI[i] = new int[n];
		for (int j = 0; j < n; j++) {
			MI[i][j] = 0;
			for (int k = 0; k < n; k++) {
				MI[i][j] = MA[i][k] * MB[k][i];
			}
		}
	}
	return MI;
}
int* Data::Func1(int* A, int* B, int* C, int** MA, int** ME) {
	int* V = VectorSum(A, B);
	VectorSort(V);
	int** MV = MatrixMult(MA, ME);
	int* D = VectorSum(V, C);
	D = VectorMatrixMult(D, MV);
	delete[] V;
	for (int i = 0; i < n; i++) {
		delete[] MV[i];
	}
	delete[] MV;
	return D;
}
int** Data::Func2(int** MF, int** MG, int** MH) {
	int** MU = MatrixMult(MG, MH);
	int** ML = MatrixSum(MF, MU);
	MatrixSort(ML);
	for (int i = 0; i < n; i++)
	{
		delete[] MU[i];
	}
	delete[] MU;
	return ML;
}
int* Data::Func3(int* O, int* P, int** MP, int** MS) {
	int* Y = VectorSum(O, P);
	int** MY = MatrixMult(MP, MS);
	int* T = VectorMatrixMult(Y, MY);
	for (int i = 0; i < n; i++)	{
		delete[] MY[i];
	}
	delete[] MY;
	delete[] Y;
	return T;
}