public class authgatewayController {

public string OrderId;
public string XMLpayLoad{get;set;}
public string responce{get;set;}
public string CCno{get;set;}
public string expdate{get;set;}
public string CCcode{get;set;}



public authgatewayController()
{
 
 OrderId = ApexPages.currentPage().getParameters().get('ord');
 
 
 system.debug(XMLpayLoad);
  
}

public void transact()
{
        XMLpayLoad =AthurizenetRequestBuilder.buildrequestforCC(OrderId,CCno,expdate,CCcode);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req.setHeader('Content-Type','text/xml');
        req.setMethod('POST');
        
        try {
            
            res = http.send(req);
            String s= res.getBody();
            System.debug(res.getBody()); 
            responce=s;
            }
         catch(System.CalloutException e) 
         {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
            
         }   
        
        
        
        
        
        
        
        
        
        
}

}