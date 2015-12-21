public class RefreshListingsController {

public static string output {get;set;}

    public void a()
    {
    
    string frommws = 'POST\n'+
                     'mws.amazonservices.com\n' +
                     '/\n' +
                     'AWSAccessKeyId=AKIAIIATE2Z5BLPOAQJA&Action=RequestReport&MWSAuthToken=amzn.mws.f8a528c5-89df-8978-8533-5f588a77e77a&MarketplaceIdList.Id.1=ATVPDKIKX0DER&Merchant=A3PPLXRJB5VSWL&ReportType=_GET_MERCHANT_LISTINGS_DATA_&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2014-12-23T05%3A41%3A57Z&Version=2009-01-01';
             
             system.debug ('\n'+frommws);
             
                       
    string we = 'bTz6lHIziRIOU3Nftylbcay5ARo+4f4TL48h5Xet';
    String signature = EncodingUtil.base64Encode(Crypto.generateMac('HmacSHA256', Blob.valueOf(frommws), Blob.valueOf(we)));
    system.debug (signature);
    
    }



    public PageReference Refresh() {
        //Time stamp,  Start & end dates
        
        /*    
        string tm_stmp;
        HttpRequest req1 = new HttpRequest();
        HttpResponse res1 = new HttpResponse();
        Http http1 = new Http();
        //req1.setCompressed(true);
        
        req1.setEndpoint('https://mws.amazonservices.com/');
        req1.setMethod('GET');
        
        
        res1 = http1.send(req1); 
        string s1 = res1.getbody();
        system.debug(s1);
        Dom.Document docx = new Dom.Document();
        docx.load(s1);
        Dom.XmlNode root = docx.getrootelement() ;
        Dom.XmlNode [] xrec = root.getchildelements() ;
        if (xrec[0].getname() == 'Timestamp' )
        {
        Dom.XmlNode a = xrec[0];       
        string keynm = a.getAttributeKeyAt(0);
        string nmsp = a.getAttributeKeyNsAt(0);
        
        tm_stmp = a.getAttributeValue(keynm,nmsp);
        }
        system.debug(tm_stmp);
        //xrec[0].getAttribute('category')
        */
       
        Datetime now = Datetime.now();
        String timestamp = now.formatGmt('yyyy-MM-dd')+'T'+now.formatGmt('HH:mm:ss')+'Z';    //'.'+now.formatGMT('SS')+'Z';
        //String timestamp = now.formatGmt('yyyy-MM-dd')+'T'+now.formatGmt('HH:mm:ss')+'.000Z';
        //DateTime start_dt = DateTime.newInstance(2014, 12, 16,15,21,30);
        //DateTime end_dt = DateTime.newInstance(2014, 12, 18,14,17,21);
        //String start_date = start_dt.formatGmt('yyyy-MM-dd')+'T'+start_dt.formatGmt('HH:mm:ss')+'.'+start_dt.formatGMT('SS')+'Z';
        //String end_date = end_dt.formatGmt('yyyy-MM-dd')+'T'+end_dt.formatGmt('HH:mm:ss')+'.'+end_dt.formatGMT('SS')+'Z';
        //String start_date = start_dt.formatGmt('yyyy-MM-dd')+'T'+start_dt.formatGmt('HH:mm:ss')+'.000Z';
        //String end_date = end_dt.formatGmt('yyyy-MM-dd')+'T'+end_dt.formatGmt('HH:mm:ss')+'.000Z';
        
        //String to signature
       
                                                                          
         /*                                                                
       String request = 'AWSAccessKeyId='+urlencode('AKIAIIATE2Z5BLPOAQJA')+
                '&Action='+urlencode('RequestReport') +
                '&ReportType=' + urlencode( '_GET_MERCHANT_LISTINGS_DATA_')  +
                '&StartDate=' + urlencode(start_date) +
                '&EndDate=' + urlencode(end_date)+
                //'&MWSAuthToken='+urlencode('amzn.mws.f8a528c5-89df-8978-8533-5f588a77e77a')+
                //'&Marketplace='+urlencode('A2EUQ1WTGCTBG2') +
                '&MarketplaceIdList.Id.1='+urlencode('ATVPDKIKX0DER')+
                '&Merchant='+urlencode('A3PPLXRJB5VSWL') +
                '&SignatureMethod='+urlencode('HmacSHA256') +
                '&SignatureVersion='+urlencode('2')+
                '&Timestamp=' + urlencode(timestamp ) +                                                                             
                '&Version=' + urlencode('2009-01-01');*/
                
        String serviceUrl = 'mws.amazonservices.com';
        
        Map<String, String> parameters = new Map<String,String>();

        // Add required parameters. Change these as needed.
        parameters.put('AWSAccessKeyId', urlEncode('AKIAIIATE2Z5BLPOAQJA'));
        parameters.put('Action', urlEncode('RequestReport'));
        parameters.put('ReportType', urlEncode('_GET_MERCHANT_LISTINGS_DATA_'));
        //parameters.put('StartDate', urlEncode(start_date));
        //parameters.put('EndDate', urlEncode(end_date));
        parameters.put(urlEncode('MarketplaceIdList.Id.1'), urlEncode('ATVPDKIKX0DER'));
        //parameters.put('MarketplaceIdList.Id.1', urlEncode('ATVPDKIKX0DER'));
        
        
        parameters.put('MWSAuthToken', urlEncode('amzn.mws.f8a528c5-89df-8978-8533-5f588a77e77a'));
        //parameters.put('MerchantId', urlEncode('A3PPLXRJB5VSWL'));
        parameters.put('Merchant', urlEncode('A3PPLXRJB5VSWL'));
        //parameters.put('SellerId', urlEncode('A3PPLXRJB5VSWL'));
        
        parameters.put('SignatureMethod', urlEncode('HmacSHA256'));
        parameters.put('SignatureVersion', urlEncode('2'));
        parameters.put('Timestamp', urlEncode(timestamp ));
        parameters.put('Version', urlEncode('2009-01-01'));        
        
        
        String secretKey= 'bTz6lHIziRIOU3Nftylbcay5ARo+4f4TL48h5Xet';
        //String secretKey= urlEncode('bTz6lHIziRIOU3Nftylbcay5ARo+4f4TL48h5Xet');
               
        // Format the parameters as they will appear in final format
        // (without the signature parameter)
        String formattedParameters = calculateStringToSignV2(parameters,serviceUrl);
        
        System.debug('formattedParameters ==='+formattedParameters);
        
        String signature = sign(formattedParameters, secretKey);
        System.debug('signature==='+signature); 
        
        //String signature2 = sign(formattedParameters, secretKey);
        //System.debug('signature2==='+signature2); 
        
        parameters.put('Signature', urlEncode(signature));
        
        //String finalStr = formParameters(parameters)+'&Signature='+urlencode(signature);
        String finalStr = formParameters(parameters);
        
        System.debug('finalStr==='+finalStr);
               
        /*
        String canonical =  'POST'+'\n'+
                          'https://mws.amazonservices.com/\n'+
                          '/\n'+request;
        
        
        
        
        String signature = EncodingUtil.base64Encode(Crypto.generateMac('HmacSHA256', Blob.valueOf(urlencode(canonical)), Blob.valueOf(key)));               
        
      
      
        System.debug('String to sign===>\n' + canonical );
        System.debug('Signature===>\n' + signature );
      
       
        String body =request+'&Signature=' + urlEncode(signature);
    
        System.debug('Body===>\n' + body );
       */
       
       
        HttpRequest req = new HttpRequest();
        
        //req.setHeader('Content-Type','text/xml');
        req.setHeader('X-Amazon-User-Agent','Salesforce/2.0 (Language=Apex/31; Platform=Windows/XP)');
        //req.setHeader('x-amazon-user-agent','Salesforce');
        req.setHeader('Content-Type','application/x-www-form-urlencoded; charset=utf-8');
        req.setHeader ('Accept','text/plain, */*');
        req.setHeader ('User-Agent','Salesforce/2.0 (Language=Apex/31; Platform=Windows/XP)');
        req.setHeader('X-Requested-With','');
        //req.setHeader('Content-Length', '100000');
        //req.setHeader('Content-Type','text/xml');
        //req.setHeader('Accept','application/xml');
        
        
        
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        //req.setCompressed(true);
        req.setMethod('POST');
        req.setEndpoint('https://mws.amazonservices.com/');
        req.setBody(finalStr);
        system.debug(req.getBody());
          
        res = http.send(req); 
        output = res.getbody();
        system.debug(res.getbody());
       
        
        return null;

    }
    
    /*
     * Sign the text with the given secret key and convert to base64
     */
    private static String sign(String data, String secretKey){
        
        String signature = EncodingUtil.base64Encode(Crypto.generateMac('HmacSHA256', Blob.valueOf(data), Blob.valueOf(secretKey)));
        system.debug(string.valueOf(Crypto.generateMac('HmacSHA256', Blob.valueOf(data), Blob.valueOf(secretKey))));
        return signature;
    }
    
    private static String calculateStringToSignV2( Map<String, String> parameters, String serviceUrl){
 


        // Create flattened (String) representation
        String data = null;
        data='POST\n';
        data+=serviceUrl.toLowerCase();
        data+='\n/\n';
        //data+='\n';
        data+=formParameters(parameters);
        
        /*
        //set<string> myKeySet = parameters.keySet();
       
        List<String> aList = new List<String>();
        aList.addAll(parameters.keySet());
        aList.sort();



        for(String s : aList){
            data+= s + '=' + parameters.get(s)+'&';
        }
        data=data.removeEnd('&');
        */
        return data;
    }
    
    private static String formParameters( Map<String, String> parameters){
 


        // Create flattened (String) representation
        String data = '';
       
       
        List<String> aList = new List<String>();
        aList.addAll(parameters.keySet());
        aList.sort();



        for(String s : aList){
            data+= s + '=' + parameters.get(s)+'&';
        }
        data=data.removeEnd('&');
        return data;
    }
    

     private String urlEncode(String rawValue) {
        String value = (rawValue == null) ? '' : rawValue;
        String encoded = null;

        try {
            encoded = EncodingUtil.urlEncode(rawValue, 'UTF-8') 
                .replace('+', '%20')
                .replace('*', '%2A')
                .replace('%7E','~');
        } catch (Exception e) {
            //System.err.println("Unknown encoding: " + CHARACTER_ENCODING);
            //e.printStackTrace();
        }

        return encoded;
    }
  
  



}