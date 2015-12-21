public class LookupTestController {

public contract con{get;set;}
Public String Acclookup{get;set;}
public List<Contract> Conlist{get;set;}

public LookupTestController ()
{
         con = new contract();     
         con.status = 'Draft';
         Conlist = [select Account.name,Owner.Name,ContractTerm,StartDate,Description from contract];
}

 @RemoteAction public static string accsearch(string sample)
    {
    
       string qstring = '%'+sample+'%';
       string resultstring='';
       list<Account> srchacclist = [select id,name from Account where name like:qstring];
      
       for(Account a : srchacclist)
             resultstring+=a.name+'%'+a.id+'#';
      
       return resultstring;
    
    
    }

public Void Saveit()
{
   con.AccountId = Acclookup;
   try{
   insert con;
   }
   catch(exception c)
   {
     Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.Info,c.getMessage()));
   }
}




}