import java.util.Random;
/**
 * Write a description of class UpperFollowsLower here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class UpperFollowsLower
{
    public static void main(String [] args ){
        //char [] testStringArray = {'w','h','k','A','h','W','z','t','T','t','O','g','C','i','x','a','A','p','k','S','u','c','k','X','H'};

        int stringArrlength = 25;
        char  [] arrChar = new char[25];
        getRandomCharArray( arrChar ,stringArrlength );   
        printArray( arrChar);
        int countUpperLower = countUpperFollowsLower(arrChar,0,stringArrlength);
        System.out.println("\nCount: " + countUpperLower);
    }

    public static void getRandomCharArray (char[] arr , int arrLength){
        Random rand = new Random();
        char randChar = (char) (rand.nextInt(26) + 'a');
        char randCharCap = (char) (rand.nextInt(26) + 'A');
        int lowerCaseOrUppercase = rand.nextInt(10);

        for(int i = 0; i < arrLength ; i++){
            randChar = (char) (rand.nextInt(26) + 'a');
            randCharCap = (char) (rand.nextInt(26) + 'A');
            lowerCaseOrUppercase = rand.nextInt(10);
            if(lowerCaseOrUppercase %2 == 0){
                arr[i] = randChar ;
            }else {
                arr[i] = randCharCap ;
            }

        }

    }

    public static int countUpperFollowsLower(char [] arr, int currentIndex , int arrLength ){

        if(currentIndex == arrLength -1){
            return 0;
        }else{
            if(Character.isLowerCase(arr[currentIndex]) && Character.isUpperCase(arr[currentIndex + 1] )){
               return 1 +  countUpperFollowsLower(arr, currentIndex + 1, arrLength );
            }else{
                return countUpperFollowsLower(arr, currentIndex + 1, arrLength ) ;
            }
        }
    
    }

    public static void printArray(char [] arr){
        for(char item: arr){
            System.out.print(item +" ");
        }
    }
}
