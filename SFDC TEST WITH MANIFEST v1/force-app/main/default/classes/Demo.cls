public class Demo {
    
    @future
    public Static void myFutureMethod(){
       	System.debug('Hello World');
    }
    
    @future(callout = true)
    public static void myFutureMethodCallout(Id objId){
        System.debug('Hello to you too');
    }
        
}