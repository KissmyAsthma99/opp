import java.util.Arrays;
public class Func1 extends Thread{
    private Data data;
    Func1(String name, int priority, Data data){
        setName(name);
        setPriority(priority);
        this.data = data;
    }
    public Data getData(){return data;}
    public void setData(Data data){this.data = data;}
    public void run(){
        System.out.println("Func 1 sarted.");
        int[] A = data.vectorOne();
        int[] B = data.vectorOne();
        int[] C = data.vectorOne();
        int[][] MA = data.matrixOne();
        int[][] ME = data.matrixOne();
        try {
            int[] D = data.func1(A,B,C,MA,ME);
            sleep(200);
            System.out.println("\nD = "+ Arrays.toString(D));
            System.out.println("Func 1 finished.");
        } catch (InterruptedException e){
            e.printStackTrace();
        }
    }
}
