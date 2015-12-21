public class AthurizenetRequestBuilder
{
  
  /*
  * Method to generate the payload of the API call
  * Parameter : Order ID : string
  */
  
  public static string buildrequestforCC(string orderID,string ccCardNo,String expDate,string cardCode)
  {
    string apilogin;string transId;
    
        try{
            AuthorizeNet__c athnet = AuthorizeNet__c.getvalues('AuthNetCredentials');
            apilogin = athnet.APILoginID__c;
            transId = athnet.TransactionKey__c; 
            }
            catch(exception e){}
    
    Dom.Document doc = new Dom.Document();        
    Dom.Xmlnode rootNode = doc.createRootElement('createTransactionRequest',null, null);
    rootNode.setAttribute('xmlns','AnetApi/xml/v1/schema/AnetApiSchema.xsd');
    
    Dom.Xmlnode merAuth= rootNode.addChildElement('merchantAuthentication', null, null);
    merAuth.addChildElement('name', null, null).addTextNode(apilogin);
    merAuth.addChildElement('transactionKey', null, null).addTextNode(transId);
    
    rootNode.addChildElement('refId', null, null).addTextNode('frte4356');
    
    Dom.Xmlnode transRq =rootNode.addChildElement('transactionRequest', null, null);
    transRq.addChildElement('transactionType', null, null).addTextNode('authCaptureTransaction');
    transRq.addChildElement('amount', null, null).addTextNode(gettotalAmmount(orderID));
    
    Dom.Xmlnode cccard= transRq.addChildElement('payment', null, null).addChildElement('creditCard', null, null);
    cccard.addChildElement('cardNumber', null, null).addTextNode(ccCardNo);
    cccard.addChildElement('expirationDate', null, null).addTextNode(expDate);
    cccard.addChildElement('cardCode', null, null).addTextNode(cardCode);
    
    Dom.Xmlnode order= transRq.addChildElement('order', null, null);
    order.addChildElement('invoiceNumber', null, null).addTextNode('testinvoice');
    order.addChildElement('description', null, null).addTextNode(getdescription(OrderID));
    
    Dom.Xmlnode lineitems = transRq.addChildElement('lineItems', null, null);
    
      for(Orderitem each: getLIneitems(orderID))
      {
        Dom.Xmlnode lineitem = lineitems.addChildElement('lineItem', null, null);
        lineitem.addChildElement('itemId', null, null).addTextNode(each.id);
        lineitem.addChildElement('name', null, null).addTextNode('test');
        lineitem.addChildElement('description', null, null).addTextNode(each.description);
        lineitem.addChildElement('quantity', null, null).addTextNode(string.valueOf(each.quantity));
        lineitem.addChildElement('unitPrice', null, null).addTextNode(string.valueOf(each.unitPrice));
      }
    
    if(calculateTax(decimal.valueOf(gettotalAmmount(OrderID)))>0.00)
    {
      Dom.Xmlnode tax = transRq.addChildElement('tax', null, null);
      tax.addChildElement('amount', null, null).addTextNode(string.valueOf(calculateTax(decimal.valueOf(gettotalAmmount(OrderID)))));
      tax.addChildElement('name', null, null).addTextNode('test Tax');
      tax.addChildElement('description', null, null).addTextNode('Test Tax Description');
    
    }
    
    if(calculateDuty(orderID)>0.00)
    {
      Dom.Xmlnode duty = transRq.addChildElement('duty', null, null);
      duty.addChildElement('amount', null, null).addTextNode(string.valueOf(calculateDuty(OrderID)));
      duty.addChildElement('name', null, null).addTextNode('test duty');
      duty.addChildElement('description', null, null).addTextNode('Test duty Description');
    
    }
    
    if(shippingCost(orderID)>0.00)
    {
      Dom.Xmlnode shipping = transRq.addChildElement('shipping', null, null);
      shipping.addChildElement('amount', null, null).addTextNode(string.valueOf(shippingCost(OrderID)));
      shipping.addChildElement('name', null, null).addTextNode('test shipping');
      shipping.addChildElement('description', null, null).addTextNode('Test shipping Description');
    
    }
    
    Dom.Xmlnode customer = transRq.addChildElement('customer', null, null).addChildElement('id', null, null).addTextNode(getcustid(OrderID));
    
    if(getbillandshippingdetail(orderId) != null)
    {
       order o = getbillandshippingdetail(orderId);
       Dom.Xmlnode billto = transRq.addChildElement('billTo', null, null);
       billto.addChildElement('firstName', null, null).addTextNode( o.BillToContact.firstname);
       billto.addChildElement('lastName', null, null).addTextNode( o.BillToContact.lastname);
       billto.addChildElement('address', null, null).addTextNode( o.BillingAddress.getStreet());
       billto.addChildElement('city', null, null).addTextNode( o.BillingAddress.getcity());
       billto.addChildElement('state', null, null).addTextNode( o.BillingAddress.getstate());
       billto.addChildElement('zip', null, null).addTextNode( o.BillingAddress.getpostalcode());
       billto.addChildElement('country', null, null).addTextNode( o.BillingAddress.getcountry());
       
       Dom.Xmlnode shipto = transRq.addChildElement('shipTo', null, null);
       //shipto.addChildElement('firstName', null, null).addTextNode( o.BillToContact.firstname);
       //shipto.addChildElement('lastName', null, null).addTextNode( o.BillToContact.lastname);
       shipto.addChildElement('address', null, null).addTextNode( o.ShippingAddress.getStreet());
       shipto.addChildElement('city', null, null).addTextNode( o.ShippingAddress.getcity());
       shipto.addChildElement('state', null, null).addTextNode( o.ShippingAddress.getstate());
       shipto.addChildElement('zip', null, null).addTextNode( o.ShippingAddress.getpostalcode());
       shipto.addChildElement('country', null, null).addTextNode( o.ShippingAddress.getcountry());
    
    }
    
    Dom.Xmlnode settings = transRq.addChildElement('transactionSettings', null, null).addChildElement('setting', null, null);
    settings.addChildElement('settingName', null, null).addTextNode('testRequest');
    settings.addChildElement('settingValue', null, null).addTextNode('false');
    
    
    
    system.debug(doc.toXmlString());
    return doc.toXmlString();
  
  }
  
  
  /*
  * Method to generate the total price of an order
  * Parameter : Order ID : string
  */
  
  public static string gettotalAmmount(string OrderID)
      {
         decimal totalprice=0.00;
         list<OrderItem> orderlineitems = [select id,Quantity,UnitPrice from OrderItem where orderid=:OrderID];
         for(OrderItem each : orderlineitems )
         {
            if(each.Quantity != null && each.UnitPrice != null)
              totalprice+=each.Quantity*each.UnitPrice;
         }
         system.debug('totalprice before taxation====>'+totalprice);
         return string.valueOf(totalprice+calculateTax(totalprice));
      
      }
  
  /*
  * Method to generate the tax ammount on the price
  * Parameter : total price : decimal
  */
  
  public static decimal calculateTax(decimal totalprice)
      {
         // do calculation on total price
         return 10.00;
      
      }
  
  /*
  * Method to generate the shipping cost ammount on the order
  * Parameter : Order ID : string
  */
  
  
  public static decimal shippingCost(string OrderID)
      {
         // do calculation on total price
         return 10.00;
      
      }
  
  /*
  * Method to generate the duty ammount on the order
  * Parameter : Order ID : string
  */
    
  public static decimal calculateDuty(string OrderID)
      {
         // do calculation on total price
         return 10.00;
      
      }
  
  
  /*
  * Method to get the description of the order
  * Parameter : Order ID : string
  */
  
  public static string getdescription(string OrderID)
      {
          
          order o = [select Description from order where id=:OrderID limit 1];
          if(o.Description != null)
          return o.Description;
          else
          return 'N/A';
      
      }
  
  
  /*
  * Method to generate the list the orderproducts of the order
  * Parameter : Order ID : string
  */
  
  public static list<Orderitem> getLIneitems(string OrderId)
      {
           return [select id,Quantity,UnitPrice,Description from Orderitem where orderid=:orderid];
      }
 
 /*
  * Method to get the customer id related to the order
  * Parameter : Order ID : string
  */
  
 public static string getcustid(string OrderID)
      {
       order o = [select accountid from order where id=:OrderID limit 1];
       if(o.accountid != null)
          return o.accountid;
       else
          return 'N/A';
     
      }
     
 
 /*
  * Method to get the billing and shipping details of the order
  * Parameter : Order ID : string
  */
  
 public static order getbillandshippingdetail(string orderID)
     {
         order o = [select BillingAddress,ShippingAddress,BillToContact.firstname,BillToContact.lastname from order where id=:orderID limit 1];
         return o;
     
     } 
 
}