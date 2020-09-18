import java.util.Arrays;
public class Func2 extends Thread {
    private Data data;
    Func2(String name, int priority, Data data){
        setName(name);
        setPriority(priority);
        this.data = data;
    }
    public Data getData(){return data;}
    public void setData(Data data){this.data = data;}
    public void run(){
        System.out.println("Func 2 started.");
        int[][] MF = data.matrixOne();
        int[][] MG = data.matrixOne();
        int[][] MH = data.matrixOne();
        try {
            int[][] ML = data.func2(MF,MG,MH);
            sleep(100);
            System.out.println("\nML = "+ Arrays.deepToString(ML));
            System.out.println("Func 2 finished.");
        } catch (InterruptedException e){
            e.printStackTrace();
        }
    }
}