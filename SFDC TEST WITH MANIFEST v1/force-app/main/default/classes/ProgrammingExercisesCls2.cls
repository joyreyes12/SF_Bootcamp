public class ProgrammingExercisesCls2 {
    
    @Future
    public Static void myFutureMethod1(){
       	List<Account> acct = new List<Account>();
        List<Account> finalAcct = new List<Account>();

        
       acct = [SELECT Id, Name, Budget__c , Total_Budget__c, (Select Id, Name, Budget__c FROM Accounts__r) FROM Account WHERE isParent__c = True ];
       System.debug(acct.size());
        
        FOR(Account thisAcct : acct){
			System.debug('First Loop');
			thisAcct.Total_Budget__c = thisAcct.Budget__c;
            
            FOR(Account newAcct : thisAcct.Accounts__r){
                System.debug('Second Loop');
                
                if(newAcct.Budget__c !=null){
                    
                thisAcct.Total_Budget__c += newAcct.Budget__c;
                
                System.debug(thisAcct.Total_Budget__c);
                    }
            }
        }
            
       System.debug(acct);
       // Update finalAcct;
    }
/*
    public Static void myFutureMethod2(){
        List<Account> acct = new List<Account>();
        List<Account> finalAcct = new List<Account>();
        
        // Create a subquery that gets the Parent with its child
        acct = [SELECT Id, Name, Budget__c, (Select Id, Name, Budget__c FROM Accounts__r) FROM Account WHERE isParent__c = True ];
        System.debug(acct.size());
        
        FOR(Account thisAcct : acct){
           
            if(thisAcct != null){
                thisAcct.Total_Budget__c = 
                    finalAcct.add(thisAcct);
                    
                     ch thisacct.Accounts__r
            }
            
            
        }
        
        
    }*/

}