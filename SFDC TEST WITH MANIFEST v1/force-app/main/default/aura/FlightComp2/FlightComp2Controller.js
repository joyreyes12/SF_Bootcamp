({
	doInit : function(component, event, helper) {
        
        
       // let button = component.find('disablebuttonid');
    	//button.set('v.disabled',true);
        
        // Value in picklist
        var pVals = [
            {text:"Fly Only", value: "Fly Only"},
            {text:"Fly + Baggage", value: "Fly + Baggage"},
            {text:"Fly + Baggage + Meal", value: "Fly + Baggage + Meal"}
        ];
         var dPick = {
            "Fly Only" :  [
                {text:"100", value: "100"}
            ],
            "Fly + Baggage" :  [
                {text:"150", value: "150"}
            ],
            "Fly + Baggage + Meal" : [
                {text:"200", value: "200"}
            ],
        };
     
        component.set('v.parentOptions', pVals);
        /*   component.set('v.dependentPicklist', dPick);
        
		var action = component.get('c.searchFlights');

        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.flights', response.getReturnValue());
                console.log('flights :'  +  response.getReturnValue())
            }
            else{
                alert('Failed to get all list');
            }
    });
        
        $A.enqueueAction(action);*/
    },
    
    
    totalPrice : function(component, event, helper) {

        var totalPrice = component.get("v.cDetailPackage.Package__c");
        var rButton = event.getSource().get("v.text");
        
        var action = component.get("");

	},
    
    
    filterResults : function(component, event, helper) {
        
        var fFrom = event.getParam("fFrom");
        var fTo = event.getParam("fTo");
		var dDate = event.getParam("dDate");
        console.log(dDate);
        console.log("YES");
        var action = component.get('c.filterFlights');
        var flights = component.get('v.flights');
        
        action.setParams({
            "fFrom" : fFrom,
            "fTo" : fTo,
            "dDate" : dDate
        });
        
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                component.set('v.flights', response.getReturnValue());
                console.log('flights :'  +  response.getReturnValue())
            }
            else{
                alert('Failed to get list');
            }
   		});
  	      
        $A.enqueueAction(action);
        
        },
    
    submitDetails: function(component, event, helper) {
    	var conFName = component.get("v.cDetails.FirstName");
        var conLName = component.get("v.cDetails.LastName");
        var conEmail = component.get("v.cDetails.Email");
        var conPackage = component.get("v.cDetails.Package__c");
    	var dId = component.get("v.modalDetails");
        var action = component.get("c.cOUDetails");    
        
        console.log(conFName);
        console.log(conLName);
        console.log(conEmail);
        console.log(conPackage);
        console.log(dId.Id);
        console.log(dId.Available_Seats__c );
   
         action.setParams({
            "conFName" : conFName,
            "conLName" : conLName,
            "conEmail" : conEmail,
            "conPackage" :conPackage,
            "dId" : dId.Id,
            "availSeats" :dId.Available_Seats_c,
        });
        
     	action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("SUCCESS");
				        component.set("v.isModalOpen", false);
                
                
                console.log("This Booking: " + response.getReturnValue());
                var appEvent = $A.get("e.c:reDirect");
                    appEvent.setParams({
                        "thisBooking" : response.getReturnValue(),
                      });
                      appEvent.fire();     
                
                
                  }
            else{
                alert('Failed to get list');
            }
   		});

        $A.enqueueAction(action);
        },

    
    openModal: function(component, event, helper) {
        // Set isModalOpen attribute to true
        console.log("Open");
        component.set("v.isModalOpen", true)
          },
    
    onRadio : function(component,event,helper){
         console.log("onRadio");
        var rButton = event.getSource().get("v.text");
        console.log("ID: " + rButton);
        
        let button = component.find('disablebuttonid');
    	button.set('v.disabled',false);
        
        component.set("v.modalDetails",rButton );
        
    },
      
    closeModel: function(component, event, helper) {
          // Set isModalOpen attribute to false  
          component.set("v.isModalOpen", false);
       },
    

    gotoURL: function(component, event, helper) {
			console.log("go to URL");
        
        	var action = component.get("c.getId");
        
        	var sendDataProc = component.get("v.sendData");
        
        
        	var reDirect = component.get("v.reDirect");
        	action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log("SUCCESS");
				//component.set(reDirect, response.getReturnValue() );
                console.log("ID: " +  response.getReturnValue());
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                  "url": 'https://thisdemoorg-dev-ed.lightning.force.com/lightning/r/Book_Flight__c/' +  response.getReturnValue() + '/view'
                });
                urlEvent.fire();
        	  }
            else{
                alert('Failed to get list');
            }
   		});
  	      
        $A.enqueueAction(action);
        
        },
    

})