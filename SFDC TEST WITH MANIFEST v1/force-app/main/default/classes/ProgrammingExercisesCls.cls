global class ProgrammingExercisesCls implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT id, name, Parent_Account__c from Account where isParent__c = true');
    }
    global void execute(Database.BatchableContext bc, List<Account> records){
        Integer i = 0;
        List<Account> acctList = New List<Account>();   
        // For each record
        FOR( Account acct: records){
            System.debug('First Loop');
            // Create 5 Child
            FOR( i = 1; i  <= 5 ;  i++){
                	System.debug('Second Loop' + i);
                    Account newAcct = new Account();
            		newAcct.Name = acct.Name + ' - Child ' + i;
                	newAcct.Parent_Account__c = acct.Id;
            acctList.add(newAcct);
            }
        }
       System.debug(acctList);
       // Insert acctList;
    }    
    global void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
        System.enqueueJob(New myQueueableClass(300000, 100000));
    }    
    
}