using System;
using static lab3.Lab3;
namespace lab3
{
    public class F1
    {
        public void Run()
        {
            //D = (SORT(A + B) + C) *(MA*ME)
            // MA*sort(a,b)*ME+MA*c*ME 
            lock (Lab3.locker)
            {
                Vector A = new Vector(N);
                Vector B = new Vector(N);
                Vector C = new Vector(N);
                Matrix MA = new Matrix(N);
                Matrix ME = new Matrix(N);
                Vector Q;
                Vector D;
                A.VectorFillsOne(1);
                B.VectorFillsOne(1);
                C.VectorFillsOne(1);
                MA.MatrixFillsOne(1);
                ME.MatrixFillsOne(1);
                Q = C.sort(A.sum(B));
                Console.WriteLine("F1 started.");
                D = MA.multiply(ME).multiply(Q);
                Console.WriteLine("D = " + D.toString());
                Console.WriteLine("F1 end.");
            }
        }
    }
}