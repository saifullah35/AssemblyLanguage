
/**
 * 
 *
 * @author (Jonathan Masih and Saif Ullah)
 * @version (Fall 2021)
 */
public class recursivePrintPattern
{
    public static void main(String[] args){
        int length = 9; 
        int heightWidth = 2;

        for(int i = 1; i < heightWidth + 1 ; i++){
            System.out.print("Height" + i + ": \n" );
            printPattern(0,0,length,i);
        }

    }

    public static void printPattern(int currentColToPrint, int currentRowToPrint , int numOfColInPattern , int numOfRowsInPattern ){
        if(currentRowToPrint == numOfRowsInPattern  ){
            return;
        }else {
            if(currentRowToPrint < numOfRowsInPattern/2 ){
                if(currentColToPrint < numOfColInPattern / 2){
                    System.out.print("\\");
                    printPattern(currentColToPrint+ 1, currentRowToPrint,numOfColInPattern,numOfRowsInPattern);
                }else if(currentColToPrint == numOfColInPattern){
                    System.out.print("\n");
                    printPattern(0,  currentRowToPrint + 1,numOfColInPattern,numOfRowsInPattern );

                }
                else{
                    System.out.print("/");
                    printPattern(currentColToPrint + 1,  currentRowToPrint ,numOfColInPattern,numOfRowsInPattern );
                }
            }else{
                if(currentColToPrint < numOfColInPattern / 2){
                    System.out.print("/");
                    printPattern(currentColToPrint+ 1, currentRowToPrint,numOfColInPattern,numOfRowsInPattern);
                }else if(currentColToPrint == numOfColInPattern){
                    System.out.print("\n");
                    printPattern(0,  currentRowToPrint + 1,numOfColInPattern,numOfRowsInPattern );

                }
                else{
                    System.out.print("\\");
                    printPattern(currentColToPrint + 1,  currentRowToPrint ,numOfColInPattern,numOfRowsInPattern );
                }

            }

        }
    }

}