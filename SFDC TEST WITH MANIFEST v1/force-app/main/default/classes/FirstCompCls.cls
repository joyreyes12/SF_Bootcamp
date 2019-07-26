public class FirstCompCls {

    // Object Donation
    public Donation__c thisNewD = new Donation__c();
    
    // Defining fields get and set
    public Donation__c thisD {get; set;}
    
    @AuraEnabled
    public static void saveDonation (Donation__c thisD){
        
        try{
            System.debug('FirstCompCls::saveDonation::thisD'+thisD);
            
            if(thisD != null){
                
                System.debug('It went in ' + thisD);
                insert thisD;
            }
            
        } catch (Exception ex){
            
        }
        
    }  
    
    @AuraEnabled
    public static List<Donation__c> getDonations(){
        List<Donation__c> donations = [SELECT Name, Amount__c, Note__c, Donation_Date__c FROM Donation__c Order BY Amount__c Desc];
        System.debug(donations);
		return donations;
    }  
    @AuraEnabled
     public static Decimal getTotalAmount(){
   		Decimal finalAmount = 0;
         List<Donation__c> totalAmount  = [SELECT Name ,Amount__c FROM Donation__c];
         FOR(Donation__c thisDon : totalAmount){
             finalAmount = finalAmount + thisDon.Amount__c;
         }
        System.debug(finalAmount);
		return finalAmount;
    }  

}