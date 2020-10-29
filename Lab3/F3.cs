using System;
using System.Threading;
using static lab3.Lab3;
namespace lab3
{
    public class F3
    {
        public void Run()
        {
            lock (Lab3.locker)
            {
                Vector P = new Vector(N);
                Vector O = new Vector(N);
                Matrix ML = new Matrix(N);
                Matrix MS = new Matrix(N);
                Vector T;
                P.VectorFillsOne(1);
                O.VectorFillsOne(1);
                ML.MatrixFillsOne(1);
                MS.MatrixFillsOne(1);
                Console.WriteLine("F3 started.");
                T = ML.multiply(MS).multiply(O.sum(P));
                Console.WriteLine("T = " + T.toString());
                Console.WriteLine("Function 3 end.");
            }
        }
    }
}