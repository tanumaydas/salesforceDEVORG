public class GoogleDriveController {

    //Fetched from URL  
    private String code ;  
    private string key = '120060213296-a9gumujfjqffripgfljaqjgq43sbmvkt.apps.googleusercontent.com' ;  
    private string secret = 'XL6rMgq7_jdbDkKXCVXlj40q' ;  
    private string redirect_uri = 'https://c.ap1.visual.force.com/apex/googleDrive_test' ;  
      
    public GoogleDriveController()  
    {  
        code = ApexPages.currentPage().getParameters().get('code') ;  
        //Get the access token once we have code  
        if(code != '' && code != null)  
        {  
            AccessToken() ;  
        }  
    }  
      
    public PageReference DriveAuth()  
    {  
        //Authenticating  
        PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;  
        return pg ;  
    }  
      
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri)  
    {  
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');  
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');  
        String authuri = '';  
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+  
        'client_id='+key+  
        '&response_type=code'+  
        '&scope=https://www.googleapis.com/auth/drive'+  
        '&redirect_uri='+uri+  
        '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+  
        '&login_hint=jsmith@example.com&'+  
        'access_type=offline';  
        return authuri;  
    }  
      
      
    public void AccessToken()  
    {  
    
        String token;
        //Getting access token from google  
        HttpRequest req = new HttpRequest();  
        req.setMethod('POST');  
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');  
        req.setHeader('content-type', 'application/x-www-form-urlencoded');  
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';  
        req.setHeader('Content-length', String.valueOf(messageBody.length()));  
        req.setBody(messageBody);  
        req.setTimeout(60*1000);  
  
        Http h = new Http();  
        String resp;  
        HttpResponse res = h.send(req);  
        resp = res.getBody();  
        
        JSONParser parser = JSON.createParser(resp);
       
        while (parser.nextToken() != null) {
        
           if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {

                parser.nextToken();

              token = parser.getText();

            }

        
        }

        
        
          
        System.debug(' You can parse the response to get the access token ::: ' + token);  
        
        HttpRequest req2 = new HttpRequest();  
        req2.setMethod('GET');  
        req2.setHeader('Authorization','Bearer ' + token); 
        string tsrch = '\'JAVA\'';
        req2.setEndpoint('https://www.googleapis.com/drive/v2/files/0B_4wHRXjYSrMfk1tSHpiZHJORUZBTHJhRGVqeWJJeG5LMXhrYzNtRXhqSHRWYVMza0FHV0U/children');  
        
        Http h2 = new Http();  
        String resp2;  
        HttpResponse res2 = h2.send(req2);  
        resp2 = res2.getBody();  
          
        System.debug(' You can parse the response to get the access token ::: ' + resp2);
   }  
   
   
  
}