public class tan {
    public  ID a{get;set;}
     public  Position__c b{get;set;}
       public  String c
      {
        get
          {
      if(c.equals('piku'))
          c='HELLLLLOOOOOOOOOOOOOOOOOOOOOOO';
      if(c == '')
          c='OPPs something went wrong';
          return c;
          }
      set;
      
      }
    
    
    public tan(ApexPages.StandardController controller) 
    {
        a = ApexPages.currentPage().getParameters().get('id');
        b = (Position__c )controller.getRecord();
        c = ApexPages.currentPage().getParameters().get('piku');
    }

public  ID getId()
{
  return a;

}
public  ID getId2()
{
  return b.ID;

}
public  String getId3()
{
  return c;

}
public Double getdiffr()
{
Object a=(Position__c.Max_Pay__c);
Object b=(Position__c.Min_Pay__c);

Decimal c=(Decimal)a;
Decimal d=(Decimal)b;
return (c-d);

}
 


}