import java.util.Arrays;
import java.util.Scanner;
public class Data {
    private int n;
    public Data(int n){
        this.n = n;
    }
    public int getN(){
        return n;
    }
    public void setN(int n){
        this.n = n;
    }
    public int[] vectorInput(){
        int[] input = new int[n];
        Scanner scanner = new Scanner(System.in);
        for (int i=0; i<input.length; i++){
            input[i]= scanner.nextInt();
        }
        return input;
    }
    public void vectorOutput(int[] vector){
        for (int i1: vector){
            System.out.println(i1);
        }
    }
    public int[] vectorOne(){
        int[] vector = new int[n];
        Arrays.fill(vector, 1);
        return vector;
    }
    public int[][] matrixInput() {
        int[][] input = new int[n][n];
        Scanner scanner = new Scanner(System.in);
        for (int i = 0; i < input.length; i++) {
            for (int j = 0; j < input[i].length; j++) {
                input[i][j] = scanner.nextInt();
            }
        }
        return input;
    }
    public void matrixOutput(int[][] matrix){
        for (int[] i: matrix) {
            System.out.println(Arrays.toString(i));
        }
    }
    public int[][] matrixOne(){
        int[][] matrix = new int[n][n];
        for (int[] ints : matrix) {
            Arrays.fill(ints, 1);
        }
        return matrix;
    }
    public int[] func1(int[] a, int[] b, int[] c, int[][] ma, int[][] me){
        return vectorMatrixMult(sumVec(vectorSort(sumVec(a,b)),c), matrixMult(ma,me));
    }
    public int[][] func2(int[][] mf, int[][] mg, int[][] mh){
        return rowMatrixSort(matrixAdd(mf, matrixMult(mg,mh)));
    }
    public int[] func3(int[] o, int[] p, int[][] mp, int[][] ms){
        return vectorMatrixMult(sumVec(o,p), matrixMult(mp,ms));
    }
    private int[] sumVec(int[] a, int[] b){
        if (a.length != n || b.length != n){
            return null;
        }
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i]= a[i] + b[i];
        }
        return res;
    }
    private int[] vectorMatrixMult(int[] a, int[][] ma){
        if (a.length != n || ma.length != n){
            return null;
        }
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                res[i] += a[i] * ma[i][j];
            }
        }
        return res;
    }
    private int[][] matrixMult(int[][] ma, int[][] mb){
        if (ma.length != n || mb.length != n) {
            return null;
        }
        int[][] res = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    res[i][j] += ma[i][k] * mb[k][j];
                }
            }
        }
        return res;
    }
    private int[][] matrixAdd(int[][] ma, int[][] mb){
        if (ma.length != n || mb.length != n) {
            return null;
        }
        int[][] res = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                res[i][j] = ma[i][j] + mb[i][j];
            }
        }
        return res;
    }
    private int[] vectorSort(int[] a){
        if (a.length != n){
            return null;
        }
        int[] c = Arrays.copyOf(a, n);
        Arrays.sort(c);
        int[] res = new int[c.length];
        for (int i = c.length; i > 0; i--) {
            res[i-1] = c[c.length-1];
        }
        return res;
    }
    private int[][] rowMatrixSort(int[][] ma){
        if (ma.length != n){
            return null;
        }
        int[][] res = new int[ma.length][ma[0].length];
        for (int i = 0; i < res.length; i++) {
            res[i] = vectorSort(ma[i]);
        }
        return res;
    }
}