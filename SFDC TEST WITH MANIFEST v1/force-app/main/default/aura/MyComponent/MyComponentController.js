({
    // This is to retrieve list of accounts
	doInit : function(component, event, helper) {
        // Don't name the "action" the same as "getAccount"
        var action = component.get('c.getAccount');
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.accounts', response.getReturnValue());
                console.log('accountList :'  +  response.getReturnValue())
            }
            else{
                alert('Failed to get Accounts');
            }
    });
	$A.enqueueAction(action);
	}
})