public class T2 extends Thread{
    private InputMonitor inputMonitor;
    private CalculationMonitor calcMonitor;
    private OutputMonitor outputMonitor;
    T2(InputMonitor inputMonitor, CalculationMonitor calcMonitor, OutputMonitor outputMonitor){
        this.inputMonitor = inputMonitor;
        this.calcMonitor = calcMonitor;
        this.outputMonitor = outputMonitor;
    }
    public void run(){
        int minrEs;
        int start = Lab2.H, end = Lab2.H*2;
        System.out.println("T2 started");
        Lab2.d = 1;
        Calculations.inputMatrix(Lab2.MB, 1);
        Calculations.inputMatrix(Lab2.MC, 1);
        Calculations.inputVector(Lab2.Z,1);
        Calculations.inputMatrix(Lab2.MR, 1);
        Calculations.inputMatrix(Lab2.MM, 1);
        // cигнал Т1, Т3, T4 про завершення введення даних
        inputMonitor.InputSignal();
        // oчікування завершення введення даних у інших потоках
        inputMonitor.WaitforInput();
        // копія MB, MC, d.
        int d2 = calcMonitor.copyD();
        int[][] MB2 = calcMonitor.copyMB();
        int[][] MC2 = calcMonitor.copyMC();
        int e = 1;
        // обчислення a2 = min(BH)
        minrEs = Calculations.vectorMin(Lab2.Z, e);
        // обчислення a
        Lab2.a = calcMonitor.calcA(minrEs, Lab2.a);
        // сигнал потокам про завершення обчислення а
        calcMonitor.SignalCalcA();
        // очікування сигналу від потоків про завершення обчислення а.
        calcMonitor.WaitforCalcA();
        // копія а
        int a2 = calcMonitor.copyA(Lab2.a);
        // Обчислення MRН = MB2*(MC2*MMH)*d2 + a2*MCH
        int[][] MC_M = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MC_M[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MC_M[i][j] += MC2[i][k] * Lab2.MM[j][k];
                }
            }
        }
        int[][] MB_CM = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MB_CM[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MB_CM[i][j] += MB2[i][k] * MC_M[j][k];
                }
            }
        }
//        outputMonitor.WaitforSignal();
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                Lab2.MR[i][j] = MB_CM[i][j]*d2 + a2*Lab2.MC[i][j];
            }
        }
        // очікування сигналу від Т1, Т3, Т4 про завершення обчислення MR.
        // вивід MR.
        /*if (Lab2.N <= 15){
            System.out.print("[ ");
            Calculations.outputMatrix(Lab2.MR);
            System.out.println("]");
        }*/
        System.out.println("T2 finished.");
    }
}