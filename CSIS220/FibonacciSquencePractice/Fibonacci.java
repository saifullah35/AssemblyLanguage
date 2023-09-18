package FibonacciSquencePractice;
/**
 * Write a description of class fibonacci here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */

import java.util.Date;
import java.sql.Timestamp;


public class Fibonacci
{
    public int fibonacciRecursion(int nthNumber) {
        int result = 0;
        if (nthNumber == 0 || nthNumber == 1){
            return 1;
        } else{
            return fibonacciRecursion(nthNumber - 1) + fibonacciRecursion(nthNumber - 2);
        }
        //return result;
    }
    
     public int fibonacciLoop(int nthNumber) {
        int f1 = 1;
        int f0 = 0;
        int f2 = -1;
        if(nthNumber < 2){
            return nthNumber;
        }
        
        //STARTS FROM 2 BECAUSE WE ALREADY HAVE F1 AND F0
        for (int i = 2; i <= nthNumber; i++){
            f2 = f1 + f0;
            f0 = f1;
            f1 = f2;
        }
        
        return f2;
    }
    
    public void compare(int number) {
        Date d = new Date();
        long time = d.getTime();
        Timestamp ts = new Timestamp(time);
        System.out.println("\n\n\n\n-----------------------\nstart Fib recurssion, time: " + ts);
        this.fibonacciRecursion(number);
        d = new Date();
        time = d.getTime();
        ts = new Timestamp(time);
        System.out.println("End Fib recursion, time: " + ts);
        d = new Date();
        time = d.getTime();
        ts = new Timestamp(time);
        System.out.println("\n\nstart Fib iteration, time: " + ts);
        this.fibonacciLoop(number);
        d = new Date();
        time = d.getTime();
        ts = new Timestamp(time);
        System.out.println("end Fib iteration, time: " + ts);
    }
    
    public static void main(String[] args) {
        Fibonacci fib = new Fibonacci();
        fib.compare(5);
        fib.compare(40);
        fib.compare(46);
        
    }
}
