public class ActionFunctionExCls
{
    public Product2 prod2Obj{get;set;}
    PageReference prf= null;
    public ActionFunctionExCls(){
        prod2Obj = new Product2();
    }
 
    public pagereference Saverec(){
    if(prod2Obj.Name !=''){
        insert prod2Obj;
   
   } else{
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please Enter Name.');
        ApexPages.addMessage(myMsg);
   
   }
   if(prod2Obj.id !=null){
  
      // Send the user to the detail page for the new account.
      prf = new PageReference('/'+prod2Obj.id);
      prf.setRedirect(true);
   
   }
   return prf;
    }
}