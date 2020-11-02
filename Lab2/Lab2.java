/**
*  Laboratory work #2
*  F1: D = (SORT(A + B) + C) *(MA*ME)
*  F2: ML = SORT(MF + MG*MH)
*  F3: T = (O + P)*(MP * MS)
*  Date 12 10 2020
**/
public class Lab2{
    public static void main(String[] args) {
        new Lab2().start();
    }
    public void run() {
        Data data = new Data(4);
        Func1 T1 = new Func1("F1", 4, data);
        Func2 T2 = new Func2("F2", 1, data);
        Func3 T3 = new Func3("F3", 10, data);
        T1.start();
        T2.start();
        T3.start();
        try {
            T1.join();
            T2.join();
            T3.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("\nLab2 end.");
    }
}
