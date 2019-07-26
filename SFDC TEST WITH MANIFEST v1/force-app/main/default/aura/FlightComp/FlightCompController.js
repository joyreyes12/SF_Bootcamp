({
	doInit : function(component, event, helper) {
		var pVals = [
            {text:"Manila", value: "Manila"},
            {text:"Sydney", value: "Sydney"}
        ];
 
        var dPick = {
            "Manila" : [
                {text:"Sydney", value: "Sydney"}
            ],
            "Sydney" : [
                {text:"Manila", value: "Manila"}
            ]
        };
 		console.log(pVals);
        component.set('v.parentOptions', pVals);
        component.set('v.dependentPicklist', dPick);
 
    },
 
    PickChange : function(component, event, helper) {
        var parentValue = component.find('parentPicklist').get('v.value');
        component.set('v.dependentOptions', component.get('v.dependentPicklist')[parentValue]);
 
        if(parentValue != '')
        component.set('v.disabledPick',false);
        else
        component.set('v.disabledPick',true);
	},
    
    searchF : function(component, event, helper) {
        
        var fFrom = component.get("v.fFrom");
        var fTo = component.get("v.fTo");
        var dDate = component.get("v.dDate");
        console.log(fFrom + "fFrom");
        
       // let button = component.find('disablebuttonid');
    	//button.set('v.disabled',true);
        
        if($A.util.isEmpty(fFrom) || $A.util.isUndefined(fFrom)){
            alert('Flying From is Required');
            return;
        }   
        
        if($A.util.isEmpty(fTo) || $A.util.isUndefined(fTo)){
            alert('Flying To is Required');
            return;
        }   
        
        if($A.util.isEmpty(dDate) || $A.util.isUndefined(dDate)){
            alert('Date is Required');
            return;
        }    
        
        //Calling the Apex Function
        var action = component.get("c.searchFlights");
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                
                var appEvent = $A.get("e.c:FlightEvent");
                
                    appEvent.setParams({
                        "fFrom" : fFrom,
                        "fTo" : fTo,
                        "dDate" : dDate
                      });
                      appEvent.fire();     
               /* 
                //Reset Form
                var newFrom = "";
                var newTo = "";
                var newDate = "";
                //resetting the Values in the form
                component.set("v.fFrom",newFrom);
                component.set("v.fTo",newTo);
                component.set("v.dDate",newDate); */
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
               
		//adds the server-side action to the queue        
        $A.enqueueAction(action); 
    },
})