public class ContactstoreurlController {
 
 
 Public String Fromno;
 Public String RecordingUrl;
 public boolean activatepoll {get;set;}

 public ContactstoreurlController(){
   activatepoll = false;
   Fromno = System.currentPageReference().getParameters().get('From').replace('client:','');
   RecordingUrl = System.currentPageReference().getParameters().get('RecordingUrl')+'.mp3';
   system.debug(Fromno +'<======>'+ RecordingUrl );
   if(Fromno != null && Fromno.length()>2)
     activatepoll = true;
  


}

public void inserturl()
{
 Contact con = [SELECT Name FROM Contact WHERE ID =:Fromno LIMIT 1];
 Recorded_Message__c a = new Recorded_Message__c(Contact__c =con.id , record_message_url__c=RecordingUrl);
 insert a;
   
}



}