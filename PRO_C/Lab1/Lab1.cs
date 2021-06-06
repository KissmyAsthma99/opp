/* -- Lab #1. C#
 * -- Z = (B*X)*(d*X + R*(MZ*MR))
 * -- 
 *  -- Date
 */
using System;
using System.Threading;
namespace lab1
{
    public class Lab1
    {
        public const int N = 8;
        public const int P = 4;
        public const int H = N/P;
        public static volatile int d = 1;
        public static int a = 0;
        public static object lockA = new object();
        public static Mutex M1 = new Mutex();
        public static int[] B = new int[N];
        public static int[] X = new int[N];
        public static int[] R = new int[N];
        public static int[,] MZ = new int[N, N];
        public static int[,] MR = new int[N, N];
        public static int[] Z = new int[N];
        public static Semaphore S0;
        public static Semaphore S1;
        public static Semaphore S2;
        public static Semaphore S3;
        public static Semaphore S4;
        public static EventWaitHandle E0;
        public static EventWaitHandle E1;
        public static EventWaitHandle E2;
        public static EventWaitHandle E3;
        /******************** Задача Т1 ********************/
        public static void T1()
        {
            Console.WriteLine("T1 started.");
            // Введення MZ
            FillMatrix(MZ);
            // Сигнал задачам Т2, Т3, Т4 про завершення вводу MZ.
            E0.Set();
            // Чекати на завершення вводу в задачі Т2.
            E1.WaitOne();
            // Чекати на завершення вводу в задачі Т3.
            E2.WaitOne();
            // Чекати на завершення вводу в задачі Т4.
            E3.WaitOne();
            // копіювання а, d, X, MR
            int a1;
            lock (lockA){
            	a1 = a;
            }
            int d1 = d;
            int[] X1 = new int[N];
            M1.WaitOne();
            for (int i = 0; i < N; i++){
                    X1[i] = X[i];
            }
            M1.ReleaseMutex();
            int[,] MR1 = new int[N, N];
            S4.WaitOne();
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    MR1[i, j] = MR[i, j];
                }
            }
            S4.Release();
            // обчислення а1
            for (int i = 0; i < H; i++){
                a1 += B[i] * X[i];
            }
            a = a + a1;
            lock (lockA){
            	a1 = a;
            }
            // ZH=a1*(d1*X1 + RH*(MZH*MR1)).
            int[] F1 = new int[H];
            int[] Dx1 = new int[H];
            for (int i = 0; i < H; i++)
            {
                F1[i] = 0;
                Dx1[i] = 0;
                for (int j = 0; j < N; j++)
                {
                    Dx1[i] += d1 * X1[i];
                    F1[i] += R[i]*(MZ[i, j]*MR1[i, j]);
                    F1[i] += Dx1[i];
                }
            }
            for (int i = 0; i < H; i++)
            {
                Z[i] = a1 * F1[i];
            }
            // сигнал про завершення обчислень.
            S1.Release();
            Console.WriteLine("T1 Finished.");
        }
        /******************** Задача Т2 ********************/
        public static void T2()
        {
            Console.WriteLine("T2 started.");
            // Введення R
            FillVector(R);
            // Сигнал задачам Т1, Т3, Т4 про завершення вводу R.
            E1.Set();
            // Чекати на завершення вводу в задачі Т1.
            E0.WaitOne();
            // Чекати на завершення вводу в задачі Т3.
            E2.WaitOne();
            // Чекати на завершення вводу в задачі Т4.
            E3.WaitOne();
            // копіювання а, d, X, MR
            int a2;
            lock (lockA){
            	a2 = a;
            }
            int d2 = d;
            int[] X2 = new int[N];
            M1.WaitOne();
            for (int i = 0; i < N; i++){
                    X2[i] = X[i];
            }
            M1.ReleaseMutex();
            int[,] MR2 = new int[N, N];
            S4.WaitOne();
            for (var i = 0; i < N; i++)
            {
                for (var j = 0; j < N; j++)
                {
                    MR2[i, j] = MR[i, j];
                }
            }
            S4.Release();
            // обчислення а2
            for (var i = 0; i < 2*H; i++){
            	a2 += B[i] * X[i];
            }
            a += a2;
            lock (lockA){
            	a2 = a;
            }
            // ZH=a2*(d2*X2 + RH*(MZH*MR2)).
            int[] F2 = new int[H];
            int[] Dx2 = new int[H];
            for (var i = 0; i < 2*H; i++)
            {
                F2[i] = 0;
                Dx2[i] = 0;
                for (var j = 0; j < N; j++)
                {
                    Dx2[i] += d2 * X2[i];
                    F2[i] += R[i]*(MZ[i, j]*MR2[i, j]);
                    F2[i] += Dx2[i];
                }
            }
            for (var i = 0; i < 2*H; i++)
            {
                Z[i] = a2 * F2[i];
            }
            // очікування сигналів від Т1, Т3, Т4 про завершення обчислень. 
            S1.WaitOne();
            S2.WaitOne();
            S3.WaitOne();
            OutputVector(Z);
            Console.WriteLine("T2 Finished.");
        }
        
        /******************** Задача Т3 ********************/
        public static void T3()
        {
            Console.WriteLine("T3 started.");
            // Введення B, MR
            FillVector(B);
            FillMatrix(MR);
            // Сигнал задачам Т1, Т2, Т4 про завершення вводу B, MR.
            E2.Set();
            // Чекати на завершення вводу в задачі Т1.
            E0.WaitOne();
            // Чекати на завершення вводу в задачі Т2.
            E1.WaitOne();
            // Чекати на завершення вводу в задачі Т4.
            E3.WaitOne();
            // копіювання а, d, X, MR
            int a3;
            lock (lockA)
            {
                a3 = a;
            }
            int d3 = d;
            int[] X3 = new int[N];
            M1.WaitOne();
            for (int i = 0; i < N; i++)
            {
                X3[i] = X[i];
            }
            M1.ReleaseMutex();
            int[,] MR3 = new int[N, N];
            S4.WaitOne();
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++){
                    MR3[i, j] = MR[i, j];
                }
            }
            S4.Release();
            // обчислення а3
            for (int i = 0; i < 3*H; i++){
            	a3 += B[i] * X[i];
            }
            a = a + a3;
            lock (lockA){
            	a3 = a;
            }
            // ZH=a3*(d3*X3 + RH*(MZH*MR3)).
            int[] F3 = new int[H];
            int[] Dx3 = new int[H];
            for (var i = 0; i < 3*H; i++)
            {
                F3[i] = 0;
                Dx3[i] = 0;
                for (var j = 0; j < N; j++)
                {
                    Dx3[i] += d3 * X3[i];
                    F3[i] += R[i]*(MZ[i, j]*MR3[i, j]);
                    F3[i] += Dx3[i];
                }
            }
            for (var i = 0; i < 3*H; i++)
            {
                Z[i] = a3 * F3[i];
            }
            // сигнал Т2 про завершення обчислень.
            S2.Release();
            Console.WriteLine("T3 Finished.");
        }
        /******************** Задача Т4 ********************/
        public static void T4()
        {
            Console.WriteLine("T4 started.");
            // Введення X, d
            FillVector(X);
            d = 1;
            // Сигнал задачам Т1, Т2, Т3 про завершення вводу X.
            E3.Set();
            // Чекати на завершення вводу в задачі Т1.
            E0.WaitOne();
            // Чекати на завершення вводу в задачі Т2.
            E1.WaitOne();
            // Чекати на завершення вводу в задачі Т3.
            E2.WaitOne();
            // копіювання а, d, X, MR
            int a4;
            lock (lockA){
            	a4 = a;
            }
            var d4 = d;
            var X4 = new int[N];
            M1.WaitOne();
            for (int i = 0; i < N; i++){
                    X4[i] = X[i];
            }
            M1.ReleaseMutex();
            int[,] MR4 = new int[N, N];
            S4.WaitOne();
            for (var i = 0; i < N; i++)
            {
                for (var j = 0; j < N; j++)
                {
                    MR4[i, j] = MR[i, j];
                }
            }
            S4.Release();
            // обчислення а4
            for (int i = 0; i < 4*H; i++){
            	a4 += B[i] * X[i];
            }
            a += a4;
            lock (lockA){
            	a4 = a;
            }
            // ZH=a4*(d4*X4 + RH*(MZH*MR4)).
            int[] F4 = new int[H];
            int[] Dx4 = new int[H];
            for (var i = 0; i < 4*H; i++)
            {
                F4[i] = 0;
                Dx4[i] = 0;
                for (var j = 0; j < N; j++)
                {
                    Dx4[i] += d4 * X4[i];
                    F4[i] += R[i]*(MZ[i, j]*MR4[i, j]);
                    F4[i] += Dx4[i];
                }
            }
            for (var i = 0; i < 4*H; i++)
            {
                Z[i] = a4 * F4[i];
            }
            // сигнал про завершення обчислень.
            S3.Release();
            Console.WriteLine("T4 Finished.");
        }
        static void FillMatrix(int[,] matrix){
        	for (var i = 0; i < N; i++){
            	for(var j = 0; j < N; j++){
            		matrix[i, j] = 1;
            	}
            }
        }
        static void FillVector(int[] vector){
        	for (var i = 0; i < N; i++){
        		vector[i] = 1;
        	}
        }
        static void OutputVector(int[] vector){
        	for (var i = 0; i < N; i++){
        		Console.Write($"{vector[i]}");
        	}
        }
        public static void Main(string[] args)
        {
            Console.WriteLine("Lab1 started.");
            S1 = new Semaphore(0, 1);
            S2 = new Semaphore(0, 1);
            S3 = new Semaphore(0, 1);
            S4 = new Semaphore(0, 1);
            E0 = new ManualResetEvent(false);
            E1 = new ManualResetEvent(false);
            E2 = new ManualResetEvent(false);
            E3 = new ManualResetEvent(false);
            Thread t1 = new Thread(T1);
            Thread t2 = new Thread(T2);
            Thread t3 = new Thread(T3);
            Thread t4 = new Thread(T4);
            t1.Start();
            t2.Start();
            t3.Start();
            t4.Start();
            t4.Join();
            Console.WriteLine("Lab1 finished.");
        }
    }
}
