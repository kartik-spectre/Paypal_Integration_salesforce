({ 
    
    /*doInit : function(component, event, helper) {
        if(component.get("v.pageReference")!=NULL){
           console.log(component.get("v.pageReference").state.testAttribute);
        }
    },
    */
    handleClick : function(component, event, helper) {
            var action = component.get("c.doDirectPayment");
          action.setParams({
          });
          action.setCallback(this, function(a) {
              var state = a.getState();
              
              if (state === "SUCCESS") {
               		//alert(a.getReturnValue());
               	   component.set("v.id",a.getReturnValue()[0]);
                   console.log(a.getReturnValue()[0]);
                   component.set("v.tokenId",a.getReturnValue()[2]);
              		console.log(a.getReturnValue()[1]);
                   window.open(a.getReturnValue()[1]); 
                  
                  
              }
          });
          $A.enqueueAction(action);
      },
    executeID : function(component, event, helper) {
       
    	var id=component.get("v.id");
        var tokenId=component.get("v.tokenId");
        console.log('id is this-> '+id);
        console.log('tokenId is this-> '+tokenId);
        if(id){
            var action = component.get("c.showTransaction");
          	action.setParams({
                ID:id,
                tokenID:tokenId
          	});
          	action.setCallback(this, function(a) {
                var state = a.getState();
              
              	if (state === "SUCCESS") {
                    //alert(a.getReturnValue());
                    // wrapper class
                    var values = a.getReturnValue();
                    console.log(values.transactions);
                    
                    console.log(values['transactions']);
                     component.set("v.transactionDetailsMap",a.getReturnValue());
                     component.set("v.Val",true);
                 //  alert(a.getReturnValue().get('create_time') + a.getReturnValue().get('state'));
                   	
                  }
          	});
          $A.enqueueAction(action);
        }
        else{
            alert("Invalid ID");
        }
    }
    	
   })