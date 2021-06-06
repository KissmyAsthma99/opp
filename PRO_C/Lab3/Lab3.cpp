/**-- Lab #3. OpenMP
 * -- MX= (B*Z)*(MZ*MM) - (MR*MC)*d
 * -- 
 * -- Date 
 */
#include <omp.h>
#include "Data.h"
#include <iostream>
#include <windows.h>
// Розмір стеку
#pragma comment(linker, "/stack:160000000")
const int P = 4;
int N = 8;
int main(){
    int a = 0;
    int d = 0;
    vector B = new int[N];
    vector Z = new int[N];
    matrix MZ;
    matrix MM;
    matrix MR;
    matrix MC;
    matrix MX;
    const int H = N / P;
	void cs();
	omp_lock_t lock_copy;
	omp_init_lock(&lock_copy);
	std::cout << "Lab4 started.\n" << std::endl;
	omp_set_num_threads(P);
    #pragma omp parallel
    {
        int id = omp_get_thread_num();
		std::cout << "T" << id << " started.\n" << std::endl;
		//---------------------------- Ввід даних ---------------------------
		switch (id)
		{
			case 0:
				Z = VectorFill(1);
				d = 1;
				break;
			case 1:
				MM = MatrixFill(1);
				break;
			case 2:
                MR = MatrixFill(1);
				B = VectorFill(1);
				break;
			case 3:
				MZ = MatrixFill(1);
				MC = MatrixFill(1);
				break;
		}
        //-------------Бар'єр для синхронізації введення--------
        #pragma omp barrier
			int ai = 0;
			for (int i = id * H; i < (id + 1) * H; i++)
				ai += B[i] * Z[i];
		
			// Обчислення a
			#pragma omp_atomic
			{
				a += ai;
			}
        //-------------Бар'єр. Синхронізація обчислення а-------
		#pragma omp barrier
			int di = 0;
			matrix MZi = new vector[N];
			matrix MRi = new vector[N];
			// atomic для копіювання a
			#pragma omp_atomic
			{
				ai = a;
			}
			// atomic для копіювання d
			#pragma omp_atomic
			{
				di = d;
			}
            // Критична секція копіювання MZ
			#pragma omp critical(cs)
			{
				MZi = MatrixCopy(MZ);
			}
			// Замок копіювання MR
			omp_set_lock(&lock_copy);
				MRi = MatrixCopy(MR);
			omp_unset_lock(&lock_copy);
            // Обчислення MX = a4*(MZ4*MMH) - (MR4*MCH)*d4
			int notDiv;
            int unDiv;
			for (int i = id * H; i < (id + 1) * H; i++) {
				for (int j = 0; j < N; j++) {
					notDiv = 0;
                    unDiv = 0;
					for (int k = 0; k < N; k++){
						notDiv += MZi[i][k] * MM[k][j];
                        unDiv += MRi[i][k] * MC[k][j];
					    MX[i][k] += ai*notDiv - unDiv * di;
                    }
				}
			}
        //-------------Бар'єр. Синхронізація обчислення MX-------
        #pragma omp barrier
			if (id == 0 && N < 15) {
				MatrixOutput(MX, 'MX');
			}
			Sleep(100);
			std::cout << "T" << id + 1 << " finished." << std::endl;
    }
    std::cout << "\nLab4 finished!\n" << std::endl;
	getchar();
	return 0;
}