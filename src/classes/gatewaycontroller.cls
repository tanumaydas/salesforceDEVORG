public class gatewaycontroller {

  public string apilogin{get;set;}
  public string TimeStamp{get;set;}
  public string finger{get;set;}
  public string hexVal{get;set;}
    public gatewaycontroller()
    {
                try{
                    AuthorizeNet__c athnet = AuthorizeNet__c.getvalues('AuthNetCredentials');
                    apilogin = athnet.APILoginID__c;
                   }
                    catch(exception e){}
                
    }

    public string getfingerprintfinal()
    {
  
          
          string apilogin;
          string transId;
          blob hmacmd5;
          string fingersorce;
          
                    AuthorizeNet__c athnet = AuthorizeNet__c.getvalues('AuthNetCredentials');
                    apilogin = athnet.APILoginID__c;
                    transId = athnet.TransactionKey__c; 
                    
                    
                    TimeStamp = string.valueOf(DateTime.now().getTime()/1000);
                    fingersorce = apilogin+'^123^'+TimeStamp+'^10.50^';
                    
                 finger = fingersorce;   
                 hmacmd5 = crypto.generateMac('hmacMD5',blob.valueOf(fingersorce),blob.valueOf(transId));  
                 hexVal = EncodingUtil.convertToHex(hmacmd5);
                 return hexVal;//EncodingUtil.base64Encode(hmacmd5);
  

     }

    

   public static string getSequence()
    {
           integer i=123;
            return string.valueOf(i);    
    }















}