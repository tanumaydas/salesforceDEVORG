public class TestRecordController {
  private contact con;
  private TwilioCapability capability;
    
    public TestRecordController(ApexPages.StandardController controller) {
     this.con = (Contact)controller.getRecord();
     capability = TwilioAPI.createCapability();
            capability.allowClientOutgoing(
                TwilioAPI.getTwilioConfig().ApplicationSid__c,null);
                capability.allowClientIncoming(con.id);

    }
      public String getToken() { return capability.generateToken(); }
      
      public String getDial() {
            //String callerid = TwilioAPI.getTwilioConfig().CallerId__c;        
           
            //phone number will be passed as http query parameter
            
            String PhoneNumber = System.currentPageReference().getParameters().get('PhoneNumber');
            
            TwilioTwiML.Response res = new TwilioTwiML.Response();
            
            TwilioTwiML.Say s = new TwilioTwiML.Say('Start'); //Record your message after beep and press * When you like to stop recording
            res.append(s);
            
            TwilioTwiML.Record rec = new TwilioTwiML.Record();
            Rec.setAction('http://tanumay-developer-edition.ap1.force.com/recordit/storedetails');
            Rec.setMethod('GET');
            Rec.setFinishOnKey('*');
            
            res.append(Rec);
            
            
            
            
            return res.toXML();
        }

}