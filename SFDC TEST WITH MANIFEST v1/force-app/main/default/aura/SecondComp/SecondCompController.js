({
    // This is to retrieve list of donation
	doInit : function(component, event, helper) {
		var action = component.get('c.getDonations');
        var action2 = component.get('c.getTotalAmount');
        var totalAmount = component.get('v.totalAmount');
        action.setParams({
            totalAmount : totalAmount
        });
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.donations', response.getReturnValue());
                console.log('donationList :'  +  response.getReturnValue())
            }
            else{
                alert('Failed to get Donation');
            }
    });
        
      action2.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.totalAmount', response.getReturnValue());
                console.log('totalAmount :'  +  response.getReturnValue());
                /*
                 var sendEvent = component.getEvent('totalAmount');
                
             sendEvent.setParams({
            
            totalAmount : totalAmount
            
           	});
            console.log('FIRE AWAY!');
            sendEvent.fire();
                */
            }
            else{
                alert('Failed to get Donation');
            }
    });
        
        $A.enqueueAction(action);
      //  $A.enqueueAction(action2);
    },
    
    handleAmount : function(component, event, helper) {
		var totalA = event.getParam("pass");
  
        console.log('total' + totalA);
        component.set("v.totalAmount", totalA);
        
    },
    
})