public class FlightCls {
    
    @AuraEnabled
    public static List<Deloitte_Airlines__c> searchFlights(){
        List<Deloitte_Airlines__c> dFlights = [SELECT id, Name, Depart_Arrive__c, Departure_Time__c, Arrival_Time__c, Fly_Only__c,  Fly_Baggage__c, Fly_Baggage_Meal__c, Available_Seats__c, Select__c, Departure_Date__c, Flying_From__c, Flying_To__c FROM Deloitte_Airlines__c Order BY Available_Seats__c Desc];
        System.debug('aaaFlight list' + dFlights);
		return dFlights;
    }  
    
    @AuraEnabled
    public static List<Deloitte_Airlines__c> filterFlights(String fFrom, String fTo, Date dDate){
        System.debug('bbbFlight From' + fFrom + 'To' + fTo +' Date' + dDate );
        List<Deloitte_Airlines__c> dFlights = [SELECT id, Name, Depart_Arrive__c, Departure_Time__c, Arrival_Time__c, Fly_Only__c,  Fly_Baggage__c, Fly_Baggage_Meal__c, Available_Seats__c, Departure_Date__c, Select__c, Flying_From__c, Flying_To__c FROM Deloitte_Airlines__c WHERE Flying_From__c = :fFrom AND Flying_To__c = :fTo AND Departure_Date__c = :dDate AND Available_Seats__c > 0 Order BY Available_Seats__c Desc];
        System.debug(dFlights);
		return dFlights;
    }  
    
    @AuraEnabled
    public static List<Deloitte_Airlines__c> fetchCon (String rid){
        return [SELECT Id, Name, Departure_Date__c, Flying_From__c, Flying_To__c  FROM Deloitte_Airlines__c];
        
    }
    
   @AuraEnabled
    public static Deloitte_Airlines__c fetchDetails (Deloitte_Airlines__c  modalDetails){
        List<Deloitte_Airlines__c> newList = [SELECT Id, Name, Departure_Date__c, Flying_From__c, Flying_To__c  FROM Deloitte_Airlines__c WHERE Name=:modalDetails.Name LIMIT 1];
        Deloitte_Airlines__c newRecord = newList[0];
        return newRecord;
    }
    
    @AuraEnabled
    public static Id getId (){
       List<Book_Flight__c> newId =  [Select Id, Flight__c, Email__c, First_Name__c, Last_Name__c, Departure_Date__c, Departure_Time__c, Package__c FROM Book_Flight__c Order by Id Desc];
      
       Deloitte_Airlines__c updateAvailSeat = [SELECT Available_Seats__c FROM Deloitte_Airlines__c WHERE Id = :newId[0].Flight__c];
       updateAvailSeat.Available_Seats__c = updateAvailSeat.Available_Seats__c - 1;
       System.debug(updateAvailSeat.Available_Seats__c);
       Update updateAvailSeat;
                System.debug('PUSH MO YAN TE!');
        
        PageReference ref = page.FlightVF;
        Blob b = ref.getContentAsPDF();
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('attachment_BPA.pdf');
        efa1.setBody(b);

        String addresses;
        email.setSubject( 'BPA PDF' + String.valueOf(DateTime.now()));
        email.setToAddresses(new String[] {newId[0].Email__c} );
        email.setPlainTextBody('Thank you for choosing Deloitte Airlines! Here is your departure details.');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
/*
       String messageBody = '<table border = "1" style = "border-collapse:collapse"><tr><th>Name</th><th>Departure Date</th><th>Departure Time</th></tr>';

			messageBody += '<tr><td>' + newId[0].First_Name__c + ' ' +  newId[0].Last_Name__c +  '</td><td >' + newId[0].Departure_Date__c + '</td><td>' + newId[0].Departure_Time__c + '</td></tr>';

            messageBody += '</table></>';
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {newId[0].Email__c});
            mail.setSubject('Booking Confirmed');
            mail.setHtmlBody(messageBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
			System.debug('Send please');*/
       System.debug(newId);
        Return newId[0].Id;
    }
   
    
    @AuraEnabled
    public static Book_Flight__c cOUDetails (String conFName, String conLName, String conEmail, String conPackage, Id dId, Decimal availSeats, Deloitte_Airlines__c gPack){
        
         		List<Contact> searchContact =  [SELECT id, FirstName, LastName,  Email, Package__c, Flight__c from Contact WHERE Email = :conEmail LIMIT 1 ];
                Book_Flight__c newBookFlight = new Book_Flight__c();
                System.debug(conFName);
                System.debug(conLName);
                System.debug(conEmail);
                System.debug(conPackage);
                System.debug(dId);
        
        try{

            if(searchContact.isEmpty()){
                Contact newContact = new Contact();
                	newContact.FirstName = conFName;
                    newContact.LastName = conLName;
                    newContact.Email = conEmail;
                    newContact.Package__c = conPackage;
                    newContact.Flight__c = dId;
                insert newContact;
                System.debug('Created: ' + newContact);
                
                    newBookFlight.First_Name__c =conFName;
                    newBookFlight.Last_Name__c = conLName;
                    newBookFlight.Email__c =  conEmail;
                    newBookFlight.Package__c = conPackage;
                	newBookFlight.Flight__c = dId;
                Insert newBookFlight;
                System.debug('Created: ' + newBookFlight);
           
            }
            
            if(!(searchContact.isEmpty())){
                Contact newContact = new Contact();
                	searchContact[0].FirstName = conFName;
                    searchContact[0].LastName = conLName;
                    searchContact[0].Email = conEmail;
                    searchContact[0].Package__c = conPackage;
                    searchContact[0].Flight__c = dId;
                Update searchContact[0];
                System.debug('Updated: ' + searchContact);
                
                    newBookFlight.First_Name__c =conFName;
                    newBookFlight.Last_Name__c = conLName;
                    newBookFlight.Email__c =  conEmail;
                    newBookFlight.Package__c = conPackage;
                	newBookFlight.Flight__c = dId;
                Insert newBookFlight;
                System.debug('Created: ' + newBookFlight);
            }
            
        } catch (Exception ex){
            
        }
       return newBookFlight;
        
    } 
    
    public class DataDisplayController {
        
        public String PDFData {get; set;} 
        
        public DataDisplayController(){
            PDFData = '';
        }
        
        public PageReference downloadPDF(){
            System.PageReference pageRef = Page.FlightVF;
        
            //ensure pdf downloads and is assigned with defined name
            pageRef.getHeaders().put('content-disposition', 'attachment; filename=TestPDF.pdf');
         
            return pageRef;
        }
    }    
    
   
}