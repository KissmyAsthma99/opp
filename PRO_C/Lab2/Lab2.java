/** -- Lab #2. Java
 * -- MR= MB*(MC*MM)*d + min(Z)*MC
 * -- 
 *  -- Date
 */
public class Lab2{
    public static int N = 2400;
    public static int P = 4;
    public static int H = N/P;
    static int a = Integer.MIN_VALUE;
    static int d;
    static int[] Z = new int[N];
    static int[][] MR = new int[N][N];
    static int[][] MB = new int[N][N];
    static int[][] MC = new int[N][N];
    static int[][] MM = new int[N][N];
    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        System.out.println("Lab2 started.");
        InputMonitor inputMonitor = new InputMonitor();
        CalculationMonitor calcMonitor = new CalculationMonitor();
        OutputMonitor outputMonitor = new OutputMonitor();
        T1 T1 = new T1(inputMonitor, calcMonitor, outputMonitor);
        T2 T2 = new T2(inputMonitor, calcMonitor, outputMonitor);
        T3 T3 = new T3(inputMonitor, calcMonitor, outputMonitor);
        T4 T4 = new T4(inputMonitor, calcMonitor, outputMonitor);
        T1.start();
        T2.start();
        T3.start();
        T4.start();
        try {
            T1.join();
            T2.join();
            T3.join();
            T4.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("\nLab2 finished.\n\nTime: " + (System.currentTimeMillis() - startTime));
    }
}
