public class T1 extends Thread{
    private InputMonitor inputMonitor;
    private CalculationMonitor calcMonitor;
    private OutputMonitor outputMonitor;
    T1(InputMonitor inputMonitor, CalculationMonitor calcMonitor, OutputMonitor outputMonitor){
        this.calcMonitor = calcMonitor;
        this.inputMonitor = inputMonitor;
        this.outputMonitor = outputMonitor;
    }
    public void run(){
        int minRes;
        int start = 0, end = Lab2.H;
        System.out.println("T1 started");
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
        int d1 = calcMonitor.copyD();
        int[][] MB1 = calcMonitor.copyMB();
        int[][] MC1 = calcMonitor.copyMC();
        int e = 0;
        // обчислення a1 = min(BH)
        minRes = Calculations.vectorMin(Lab2.Z, e);
        // обчислення a
        Lab2.a = calcMonitor.calcA(minRes, Lab2.a);
        // сигнал потокам про завершення обчислення а
        calcMonitor.SignalCalcA();
        // очікування сигналу від потоків про завершення обчислення а.
        calcMonitor.WaitforCalcA();
        // копія а
        int a1 = calcMonitor.copyA(Lab2.a);
        // Обчислення MRН = MB1*(MC1*MMH)*d1 + a1*MCH
        int[][] MC_M = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MC_M[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MC_M[i][j] += MC1[i][k] * Lab2.MM[j][k];
                }
            }
        }
        int[][] MB_CM = new int[Lab2.N][Lab2.N];
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                MB_CM[i][j] = 0;
                for (int k = 0; k < Lab2.N; k++){
                    MB_CM[i][j] += MB1[i][k] * MC_M[j][k];
                }
            }
        }
        for (int j = start; j < end; j++){
            for (int i = 0; i < Lab2.N; i++){
                Lab2.MR[i][j] = MB_CM[i][j]*d1 + a1*Lab2.MC[i][j];
            }
        }
        // cигнал про завершення обчислення MR.
        outputMonitor.Signal();
        System.out.println("T1 finished.");
    }
}