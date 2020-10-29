using System;
using System.Threading;
using static lab3.Lab3;
namespace lab3
{
    public class F2
    {
        public void Run()
        {
            lock (Lab3.locker)
            {
                Matrix MF = new Matrix(N);
                Matrix MG = new Matrix(N);
                Matrix MH = new Matrix(N);
                Matrix ML;
                MF.MatrixFillsOne(1);
                MG.MatrixFillsOne(1);
                MH.MatrixFillsOne(1);
                Console.WriteLine("F2 started.");
                ML = MF.sum(MG.multiply(MH));
                Console.WriteLine("ML = \n" + ML.toString());
                Console.WriteLine("Function 2 end.");
            }
        }
    }
}