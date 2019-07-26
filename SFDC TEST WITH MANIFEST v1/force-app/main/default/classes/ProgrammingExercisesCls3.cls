Global class ProgrammingExercisesCls3 implements Schedulable {
    
        Global void execute(SchedulableContext sc){
		List<Account> accountList = [SELECT Name, Total_Budget__c From Account WHERE Total_Budget__c > 1000000];
        System.debug(UserInfo.getUserName());
            
        String messageBody = '<table border = "1" style = "border-collapse:collapse"><tr><th>Account Name</th><th>Total Budget </th></tr>';
            FOR(Account acc: accountList){
                
				messageBody += '<tr><td>' + acc.Name + '</td><td>' + acc.Total_Budget__c + '</td></tr>';
                
            }
            
            messageBody += '</table>';
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {'apexasync@topmail.com'});
            mail.setSubject('Account Budget');
            mail.setHtmlBody(messageBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
    }

}