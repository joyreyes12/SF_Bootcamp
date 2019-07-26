({
    
    // This is to retrieve list of donation
	doInit : function(component, event, helper) {
		var action = component.get('c.getTotalAmount');
        
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var totalAmount = response.getReturnValue();
                console.log('totalAmount :'  +  totalAmount);
                  var appEvent = $A.get("e.c:FirstCompEvent");
                    appEvent.setParams({
                                    "pass" : totalAmount
                               
                                });
                    appEvent.fire();                 
            }
            else{
                alert('Failed to get Donation');
            }
    });
        
        $A.enqueueAction(action);
    },

    
   saveD : function(component, event, helper) {
		console.log('Create record');
        
        //getting the thisD information
        var thisD = component.get("v.thisD");
       	var newDList = component.get("v.newDList");
        
        //Validation
        if($A.util.isEmpty(thisD.Name) || $A.util.isUndefined(thisD.Name)){
            alert('Name is Required');
            return;
        }            
        if($A.util.isEmpty(thisD.Amount__c) || $A.util.isUndefined(thisD.Amount__c) ){
            alert('Amount is Required');
            return;
        }
       if(thisD.Amount__c <= 0){
           alert('Amount Should not be Negative');
           return;
       }
        if($A.util.isEmpty(thisD.Donation_Date__c) || $A.util.isUndefined(thisD.Donation_Date__c)){
            alert('Date is Required');
            return;
        }
        //Calling the Apex Function
        var action = component.get("c.saveDonation");

        action.setParams({
            thisD : thisD
        });
      
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                //Reset Form
                var newDonation = {'sobjectType': 'Donation__c',
                                    'Name': '',
                                    'Amount__c': '',
                                    'Note__c': '', 
                                    'Donation_Date__c': ''
                                   };
                //resetting the Values in the form
                component.set("v.thisD",newDonation);

                
                alert('Record is Created Successfully');
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
               
		//adds the server-side action to the queue        
        $A.enqueueAction(action); 
    }
})