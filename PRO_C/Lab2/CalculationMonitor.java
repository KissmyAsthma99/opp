public class CalculationMonitor {
    private static int F = 0;
    private int d = 1;
    private int[][] MC = Lab2.MC;
    private int[][] MB = Lab2.MB;
    synchronized int copyA(int q) {
        return q;
    }
    synchronized int calcA(int val1, int val2) { return val1 < val2 ? val1 : val2; }
    synchronized int copyD() { return this.d; }
    synchronized int[][] copyMC() { return this.MC; }
    synchronized int[][] copyMB() { return this.MB; }
    synchronized void SignalCalcA() {
        F++;
        if (F >= 4) notifyAll();
    }
    synchronized void WaitforCalcA(){
        try {
            if (F < 4) wait();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}