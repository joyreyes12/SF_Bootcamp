({
	fetchDonations : function(component, event, helper) {
		var action = component.get('c.getDonations');
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.donations', response.getReturnValue());
                console.log('donationList :'  +  response.getReturnValue())
            }
            else{
                alert('Failed to get Donation');
            }
    });
	$A.enqueueAction(action);
	}
})