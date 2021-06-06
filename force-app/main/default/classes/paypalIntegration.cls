public class paypalIntegration{
    
		
    public static String generateTokenID(){
        string clientId='AfTNq_PWpdVPEybZGD0dNKuKC3oM9O2xqQkm6RmNjR10Dgjtevgt1HoRkoLzHfClXVdqyRxIljjzrFMA'; //Use your Client ID credential here
        string clientSecret='ECg3oxQcykakiPJ7V48_M39C8syFqVc3P4H82qvsgc2OveQKPnBZDxe54NZBgeZMF0sgrA9wOhatgxAe'; //Use your Client Secret key credential here
        string endpoint = 'https://api.sandbox.paypal.com/v1/oauth2/token'; // URL for sandbox will be https://api.sandbox.paypal.com
        string body='grant_type=client_credentials';
        
        
        Blob headerValue = Blob.valueOf(clientId +':' +clientSecret);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        //system.debug('Encoder Value' + EncodingUtil.base64Encode(headerValue));
                
        http http = new http();
        httpRequest req = new httpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorizationHeader);
        req.setBody(body);
        httpResponse res = http.send(req);
      //  system.debug('tokenID'+res.getStatus());

		System.debug(res.getStatusCode());
		if ( res.getStatusCode() == 200) {
   			 Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
		
    
    		string url11=(string)results.get('access_token');
    			
        	return url11;
    
	   	
    
		}
		else{
        	string s='error123';
        	return s;       
		}

    }
    @AuraEnabled    
    public static list<String> doDirectPayment()
    {

   		// data 
        setPaymentBody obj =new setPaymentBody();  
        obj.setBody();
        string tokenID = generateTokenID(); // tokenId
      
        
        String body = json.serialize(obj);  
        string body1=body.replace('currency1','currency');
        system.debug('body1 ' + body1);
        string url='https://api-m.sandbox.paypal.com/v1/payments/payment';
        Http h = new Http();    
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + tokenID);
        req.setBody(body1); 
        req.setHeader('Content-Type', 'application/json'); 
        
    
       
        HttpResponse response = h.send(req);
        system.debug('response body ' + response.getBody());
        System.debug(response.getStatusCode());
        list<string> info = new list<string>();
        if (response.getStatusCode() == 201) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                
            
                List<Object> links=(List<Object>)results.get('links');
            	string id=(string)results.get('id');
                Map<string,Object >ma=(Map<string,Object >)links[1];
                Http h1 = new Http();
                system.debug(ma.get('href'));
                
                string url11=(string)ma.get('href');
                HttpRequest req1 = new HttpRequest();
                req1.setEndpoint(url11);
                req1.setMethod('GET');
                
                HttpResponse res = h1.send(req1);
                String s = EncodingUtil.urlEncode(res.getBody(), 'UTF-8');
               
            	info.add(id);
            	info.add(url11);
            	info.add(tokenID);
              
            
                
            
        }
        return info;
       
	}
 	@AuraEnabled    
    public static Map<String, Object> showTransaction(String ID,string tokenID)
    {

   		// data 
        //JsonParser obj =new JsonParser();  
       // string tokenID = generateTokenID(); // tokenId
      
       
        
       // String body = json.serialize(obj);  
       // string body1=body.replace('currency1','currency');
       // system.debug('body1 ' + body1);
        string url='https://api-m.sandbox.paypal.com/v1/payments/payment/'+ID;
        Http h = new Http();    
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + tokenID);
        //req.setBody(body1); // Problem
        req.setHeader('Content-Type', 'application/json'); 
        
    
       
        HttpResponse response = h.send(req);
       // system.debug('response body ' + response.getBody());
        System.debug(response.getStatusCode());
        //list<string> info = new list<string>();
        Map<string,string>toSend = new Map<string,string>();
        List<string>info = new List<string>();
        Map<String, Object> results1 = new Map<String, Object>();
        transactionDetails ob1 = new transactionDetails();
        if (response.getStatusCode() == 200) {
   				
            	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            	string intent=(string)results.get('intent');
            	string state=(string)results.get('state');
            	string cart=(string)results.get('cart');
            	Map<string,Object> payer = (Map<String ,object>)results.get('payer');
            	string method=(string)payer.get('payment_method');
            	string status=(string)payer.get('status');
            	//Map<string,Object>transactions = (Map<String ,object>)results.get('transactions');
            	//Map<string,Object>amount = (Map<String ,object>)transactions.get('amount');
            	//string totalAmount = (string)amount.get('total');
            	
            	//Map<string,Object>itemList = (Map<String ,object>)transactions.get('item_lists');
            	//Map<string,Object>items = (Map<String ,object>)itemList.get('items');
            	info.add(intent);
            	info.add(state);
                info.add(cart);
                info.add(method);
                info.add(status);
            	
            	toSend.put('intent',intent);
                toSend.put('state',state);
                toSend.put('cart',cart);
                toSend.put('method',method);
                toSend.put('status',status);
            	
            	transactionDetails ob = new transactionDetails(toSend);
            // 	return ob;
            	
               // toSend.put('totalAmount',totalAmount);
            	
            
                
            	
    		
            	
            	
            	
            	//system.debug('res '+results.get('create_time'));
            	
                return results;            	
            	
        }
        return results1;
       
       
       
	}
   
    
}