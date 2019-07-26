public with sharing class MyComponentController {
    
    @AuraEnabled
    
    public static List<Account> getAccount(){
        
        return [SELECT Name FROM Account];
    }

}