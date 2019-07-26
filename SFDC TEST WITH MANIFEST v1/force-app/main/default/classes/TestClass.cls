public class TestClass {

    @AuraEnabled
    public static List<Account> fetchAcc (){
        return [SELECT Id, Name, Phone FROM Account LIMIT 50];
    }
    
    @AuraEnabled
    public static List<Contact> fetchCon (String rid){
        return [SELECT Id, Name, Phone FROM Contact WHERE accountId=:rid];
    }
}