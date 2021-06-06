public class OutputMonitor {
    private static int F = 0;
    synchronized void Signal(){
        F++;
        if (F >= 4) notifyAll();
    }
    synchronized void WaitforSignal(){
        try {
            if (F < 3) wait();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}