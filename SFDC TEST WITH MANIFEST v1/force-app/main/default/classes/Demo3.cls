global class Demo3 implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT id, name from Account');
    }
    global void execute(Database.BatchableContext bc, List<Account> records){
        
        List<Account> acctList = New List<Account>();     
        FOR( Account acct: records){
            acctList.add(acct);
            System.debug(acct.Name);
        }
        
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}
/*
Id bId = Database.executeBatch(new myFirstBatch(),1);
AsyncApexJob bResults = [SELECT Status, NumberofErrors, CompletedDate FROM AsyncApexJob WHERE Id = :bId];
*/