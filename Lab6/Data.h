#pragma once
class Data
{
public:
	int getN();
	Data(int n);
	void VectorFill(int* A);
	void MatrixFill(int** MA);
	void VectorOutput(int* A);
	void MatrixOutput(int** MA);
	int* Func1(int* A, int* B, int* C, int** MA, int** ME);
	int** Func2(int** MF, int** MG, int** MH);
	int* Func3(int* O, int* P, int** MP, int** MS);
private:
	int n;
	void VectorSort(int* A);
	void MatrixSort(int** MA);
	int* VectorSum(int* A, int* B);
	int** MatrixSum(int** MA, int** MB);
	int* VectorMatrixMult(int* A, int** MA);
	int** MatrixMult(int** MA, int** MB);
};