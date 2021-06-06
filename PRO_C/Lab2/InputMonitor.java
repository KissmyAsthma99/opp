public class InputMonitor {
    private static int F = 0;
    synchronized void InputSignal(){
        F++;
        if (F >= 4) notifyAll();
    }
    synchronized void WaitforInput(){
        try {
            if (F < 2) wait();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}