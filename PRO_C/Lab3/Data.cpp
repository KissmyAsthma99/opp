#include <windows.h>
#include <iostream>
#include "Data.h"
vector VectorFill() {
	vector ves = new int[N];
	for (int i = 0; i < N; i++)
		ves[i] = 1;
	return ves;
}
matrix MatrixFill() {
	matrix flynn = new vector[N];
	for (int i = 0; i < N; i++)
		flynn[i] = new int[N];
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			flynn[i][j] = 1;
	return flynn;
}
matrix MatrixCopy(matrix mat) {
	matrix result = new vector[N];
	for (int i = 0; i < N; i++)
		result[i] = new int[N];
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			result[i][j] = mat[i][j];
	return result;
}
void MatrixOutput(matrix MA, char name) {
    std::cout << name << ": " << std::endl;
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			std::cout << MA[i][j] << " " << std::endl;
		}
	}
    std::cout << "\n" << std::endl;
}