public class T4 extends Thread{
    private InputMonitor inputMonitor;
    private CalculationMonitor calcMonitor;
    private OutputMonitor outputMonitor;
    T4(InputMonitor inputMonitor, CalculationMonitor calcMonitor, OutputMonitor outputMonitor){
        this.calcMonitor = calcMonitor;
        this.inputMonitor = inputMonitor;
        this.outputMonitor = outputMonitor;
    }
    public void run(){
        int miNres;
        int start = Lab2.H*3, end = Lab2.N;
        System.out.println("T4 started");
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
        int d4 = calcMonitor.copyD();
        int[][] MB4 = calcMonitor.copyMB();
        int[][] MC4 = calcMonitor.copyMC();
        int e = 3;
        // обчислення a4 = min(BH)
        miNres = Calculations.vectorMin(Lab2.Z, e);
        // обчислення a
        Lab2.a = calcMonitor.calcA(miNres, Lab2.a);
        // сигнал потокам про завершення обчислення а
        calcMonitor.SignalCalcA();
        // очікування сигналу від потоків про завершення обчислення а.
        calcMonitor.WaitforCalcA();
        // копія а
        int a4 = calcMonitor.copyA(Lab2.a);
        // Обчислення MRН = MB4*(MC4*MMH)*d4 + a4*MCH
        int[][] MC_M = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MC_M[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MC_M[i][j] += MC4[i][k] * Lab2.MM[j][k];
                }
            }
        }
        int[][] MB_CM = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MB_CM[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MB_CM[i][j] += MB4[i][k] * MC_M[j][k];
                }
            }
        }
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                Lab2.MR[i][j] = MB_CM[i][j]*d4 + a4*Lab2.MC[i][j];
            }
        }
        // cигнал про завершення обчислення MR.
        outputMonitor.Signal();
        System.out.println("T4 finished.");
    }
}