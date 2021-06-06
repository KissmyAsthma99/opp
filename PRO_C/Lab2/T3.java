public class T3 extends Thread{
    private InputMonitor inputMonitor;
    private CalculationMonitor calcMonitor;
    private OutputMonitor outputMonitor;
    T3(InputMonitor inputMonitor, CalculationMonitor calcMonitor, OutputMonitor outputMonitor){
        this.calcMonitor = calcMonitor;
        this.inputMonitor = inputMonitor;
        this.outputMonitor = outputMonitor;
    }
    public void run(){
        int minreS;
        int start = Lab2.H*2, end = Lab2.H*3;
        System.out.println("T3 started");
        Lab2.d = 1;
        Calculations.inputMatrix(Lab2.MB, 1);
        Calculations.inputMatrix(Lab2.MC, 1);
        Calculations.inputVector(Lab2.Z,1);
        Calculations.inputMatrix(Lab2.MR, 1);
        Calculations.inputMatrix(Lab2.MM, 1);
        // cигнал Т2, Т3, T4 про завершення введення даних
        inputMonitor.InputSignal();
        // oчікування завершення введення даних у інших потоках
        inputMonitor.WaitforInput();
        // копія MB, MC, d.
        int d3 = calcMonitor.copyD();
        int[][] MB3 = calcMonitor.copyMB();
        int[][] MC3 = calcMonitor.copyMC();
        int e = 2;
        // обчислення a3 = min(BH)
        minreS = Calculations.vectorMin(Lab2.Z, e);
        // обчислення a
        Lab2.a = calcMonitor.calcA(minreS, Lab2.a);
        // сигнал потокам про завершення обчислення а
        calcMonitor.SignalCalcA();
        // очікування сигналу від потоків про завершення обчислення а.
        calcMonitor.WaitforCalcA();
        // копія а
        int a3 = calcMonitor.copyA(Lab2.a);
        // Обчислення MRН = MB3*(MC3*MMH)*d3 + a3*MCH
        int[][] MC_M = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MC_M[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MC_M[i][j] += MC3[i][k] * Lab2.MM[j][k];
                }
            }
        }
        int[][] MB_CM = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MB_CM[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MB_CM[i][j] += MB3[i][k] * MC_M[j][k];
                }
            }
        }
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                Lab2.MR[i][j] = MB_CM[i][j]*d3 + a3*Lab2.MC[i][j];
            }
        }
        // cигнал про завершення обчислення MR.
        outputMonitor.Signal();
        System.out.println("T3 finished.");
    }
}