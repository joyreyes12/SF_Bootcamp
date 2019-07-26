public class AccountSearchController {
    
    Public list <Account> acc {get;set;}
    Public String SearchKey {get;set;}
    
    Public void search(){
        
        String searchQuery = 'select Name,id from account where name like \'%'+searchKey+'%\' Limit 10';
            
        acc = database.query(searchQuery);
    }

}