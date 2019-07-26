({
	handleSend : function(component, event, helper) {
        
        // getting the whole data in the event
        var params = event.getParams();
        
        // getting a part of the data
       var message = params.message;
        
        // showing the part of the data
        alert('Received message: ' + message);
		
	}
})