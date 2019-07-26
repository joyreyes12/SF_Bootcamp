({
	sendMessage : function(component, event, helper) {
        
        // How to call the event data and define it in a variable
        // var sendEvent = component.getEvent('send');
        // This is for event application type

        var sendEvent = $A.get('e.c:sendMessageEvent'); // This is not too binding
        
        // This puts value on the sendEvent
        sendEvent.setParams({
            
            message : 'Hello World!'
            
        });
        
        // Throwing the value to the handler
        sendEvent.fire();
		
	}
})