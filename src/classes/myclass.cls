public class myclass
{
public static void incrspay(Position__c[] p)
{

for(Position__c rec : p )
    {
    rec.Max_Pay__c = rec.Max_Pay__c-5000;
    rec.Min_Pay__c = rec.Min_Pay__c-5000;
    }

}
}