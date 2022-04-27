import Debug "mo:base/Debug"; 
import Time "mo:base/Time"; 
import Float "mo:base/Float"; 



actor DBank { 
  stable var currentValue:Float = 300; //"stable" turns variable from being flexible to being persistent 
  currentValue:= 300; 
  let id = 3234234; 
  Debug.print("Hello"); 

  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));


  public func topUp(amount:Float) { ///creates a  public function with input 'amount' originally in the form of a natural number(Nat) 
  // changed from Nat to Float to match data type of currentValue
  //without the 'public' keyword, the function would be private and could only be called within the DBank actor
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount; // sets tempValue to be Floating interger
    // tempValue was originally an Int (interger)
    if (tempValue>=0) { // if statement that notifies the developer if currentValue becomes less than zero
    currentValue -= amount;
    Debug.print(debug_show(currentValue));
    }else{
        Debug.print("Amount too large, currentValue less than zero.")
    }
  };

    public query func checkBalance(): async Float { // creates an asynchonous read-only function 
      return currentValue
    };

  public func compound(){ //calculate compound interest of 1% every second
    let currentTime = Time.now();
    let timeElapsedS = (currentTime-startTime)/1000000000; // converts time from nanoseconds to seconds
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS)); //changes the value of currentTime to reflect the compound equation
    //float turns time elapse into a floating interger so that it's the same data type as currentValue
    startTime := currentTime;
  } 

}
   
