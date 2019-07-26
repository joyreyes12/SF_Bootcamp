public class MyOrdersCls {
    
    public List<Order> ordList			 {get; set;}
    public String ordNum				   {get; set;}

    public String queFinal= '';

 	// Holder for query Account
 	Public integer pageSize = 7;
    Public String accQueryHolder {get; set;} 
    
	 public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, OrderNumber, Account.Name, Status, CreatedDate FROM Order]));
                setCon.setpagesize(pageSize);
                System.debug(setCon);
            }
            return setCon;
        }
        set;
    }
    public List<Order> getOrderList() {
        return (List<Order>) setCon.getRecords();
    }
    
     //Pagination
    public PageReference orderSearch(){
        
        //if the order number that was inputted is not empty to avoid null exception
        if(ordNum != null && setCon != null){
            System.debug(queFinal);
            //List Orders with the criteria of the user input
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator([
                SELECT  Id, OrderNumber, Account.Name, Status, CreatedDate FROM Order WHERE OrderNumber like : '%' + ordNum  + '%' ]));
            System.debug(setCon); 
            setCon.setpagesize(pageSize);
    	    }
     		Return null;
    }
    
     public Boolean hasNext {
                                get {
                                                return setCon.getHasNext();
                                }
                }

                public Boolean hasPrevious {
                                get {
                                                return setCon.getHasPrevious();
                                }
                                set;
                }

                public Integer pageNumber {

                                get {
                                                return setCon.getPageNumber();
                                }
                                set;

                }

    public Integer totalPages {
                                get {
                                                totalPages = setCon.getResultSize() / setCon.getPageSize();
                                                return totalPages;
                                }
                                set;
                }

                public void first() {
                               setCon.first();
               }

               public void last() {
                               setCon.last();
               } 

               public void previous() {
                               setCon.previous();
               }

               public void next() {
                               setCon.next();
               }

}