public class myQueueableClass implements Queueable {
    
    public integer maxInt = 0;
    public integer minInt = 0;
    
    public myQueueableClass(Integer maxInt, Integer minInt){
        
       this.maxInt = maxInt;
       this.minInt = minInt;
        
       	List<Account> acct = new List<Account>();
        List<Account> finalAcct = new List<Account>();
        Decimal thisRan = 0;
        Decimal finalRan = 0;
        
       	acct = [SELECT Id, Name, Budget__c , (Select Id, Name, Budget__c FROM Accounts__r) FROM Account WHERE isParent__c = True ];
       System.debug(acct.size());
        
        FOR(Account thisAcct : acct){
            
            thisRan = ((Math.random()* (maxInt - minInt)) + minInt);
            finalRan = thisRan.setScale(2);
            thisAcct.Budget__c =  finalRan;
            System.debug(thisAcct.Budget__c);

            
               FOR(Account newAcct : thisAcct.Accounts__r){
                   
                    thisRan = ((Math.random()* (maxInt - minInt)) + minInt);
                    finalRan = thisRan.setScale(2);
                    newAcct.Budget__c =  finalRan;
                    System.debug(newAcct.Budget__c);

               }
            
        }
       System.debug(acct);
     Update acct;
    }
    
    public void execute(QueueableContext qc){
        System.debug('Hello to you three');
    }
}

/*

Id qId = System.enqueueJob(new myQueueableClass());
AsyncApexJob qResults =  [SELECT status, NumberOfErrors, CompletedDate FROM AsyncApexJob WHERE Id = :qId];
*/