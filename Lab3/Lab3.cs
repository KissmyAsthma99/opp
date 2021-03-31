/* -- Laboratory work #3
 * -- F1: D = (SORT(A + B) + C) *(MA*ME)
 * -- F2: ML = SORT(MF + MG*MH)
 * -- F3: T = (O + P)*(MP * MS)
 * -- Date 28.10.2020
 */
using System;
using System.Threading;
namespace lab3
{
    partial class Lab3
    {
        public static int N = 4;
        public static object locker = new object();
        public static void Main(string[] args)
        {
         Thread MainThread = new Thread(new Lab3().Run);
         MainThread.Start();
         MainThread.Priority = ThreadPriority.Normal;
        }
        public void Run()
        {
            lock (new Lab3())
            {
                Console.WriteLine("Lab3 started.");
                Thread T1 = new Thread(new F1().Run);
                Thread T2 = new Thread(new F2().Run);
                Thread T3 = new Thread(new F3().Run);
                T1.Priority = ThreadPriority.Highest;
                T2.Priority = ThreadPriority.Lowest;
                T3.Priority = ThreadPriority.Normal;
                T1.Start();
                T2.Start();
                T3.Start();
                Thread.Sleep(1000);
                Console.WriteLine("Lab3 end.");
            }
        }
    }
}
