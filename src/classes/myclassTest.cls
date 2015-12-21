@istest
private class myclassTest
{

    static testMethod void test1()
    { 
    Position__c p = new Position__c(Max_Pay__c = 1000,Min_Pay__c = 500);
    Test.startTest();
    insert p;
    
    
    Test.stopTest();
    
    }
}