public class MyOrderDetailCls {
        
    // To hide and to show product modal
    public boolean showContent   {get;set;}
    public boolean prodContent   {get;set;}
    
    // List of products in an object
    public List<OrderItem> prodList	{get; set;}
    public List<Product2> prodList2	{get; set;}
    
    // Object that was clicked
    public Order thisOrd {get; set;}
    public Product2 thisProd {get; set;}
    
    // ID of Product
    public id thisId {get; set;}
    public id aaaOrdId {get; set;}
    
    // Description
    public String thisDesc {get; set;}

    // Query holder
    public String queFinal= '';
    
    // How many rows to show
    public integer pageSize = 7;
    
    public MyOrderDetailCls(ApexPages.StandardController stdController) {
        
        thisOrd =  [ SELECT Id,  OrderNumber,  Account.Name, TotalAmount, Status FROM Order Where Id = :stdController.getId()];
        aaaOrdId = stdController.getId();
		prodList  = [ SELECT Id,  product2.name,  UnitPrice FROM OrderItem Where Order.Id =  :stdController.getId()];
        
        if(prodList.size() >= 1){

            prodContent = True;
            
        }
        
        else{
            
            prodContent = False;
            
        }
    }
    
    public void viewProductDetails(){

            thisProd = [ SELECT  Id,  name, Description FROM Product2 Where id =  : thisId];
        
    }
    
    public PageReference reSave(){

		Update thisProd;

        Return null;
    }
    
    
    //Method called when the Toggle Content button is clicked
    public PageReference toggleContent() {
        //If the showContent variable is true, set it to false, else, set it to true
        if(showContent){
            showContent = false;
        }
        else{
            showContent = true;
        }
        return null;
    }
      
}