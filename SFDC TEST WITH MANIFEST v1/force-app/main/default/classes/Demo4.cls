Global class Demo4 implements Schedulable {
    
    Global void execute(SchedulableContext sc){

        System.debug(UserInfo.getUserName());
        
    }

}