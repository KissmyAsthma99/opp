import java.util.Arrays;
public class Func3 extends Thread{
    private Data data;
    Func3(String name, int priority, Data data){
        setName(name);
        setPriority(priority);
        this.data = data;
    }
    public Data getData(){return data;}
    public void setData(Data data){this.data = data;}
    public void run(){
        System.out.println("Func 3 started.");
        int[] O = data.vectorOne();
        int[] P = data.vectorOne();
        int[][] MP = data.matrixOne();
        int[][] MS = data.matrixOne();
        try {
            int[] T = data.func3(O,P,MP,MS);
            sleep(150);
            System.out.println("\nT = "+ Arrays.toString(T));
            System.out.println("Func 3 finished.");
        } catch (InterruptedException e){
            e.printStackTrace();
        }
    }
}