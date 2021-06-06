public class setPaymentBody {
    
    public list<transactions> transactions{get;set;}
    public String note_to_payer{get;set;}
    public payer payer{get;set;}
    public redirect_urls redirect_urls{get;set;}
    public String intent{get;set;}
public class transactions{
    public String invoice_number{get;set;}
    public payment_options payment_options{get;set;}
    public String custom{get;set;}
    public String soft_descriptor{get;set;}
    public String description{get;set;}
    public item_list item_list{get;set;}
    public amount amount{get;set;}
}
public class shipping_address{
    public String line2{get;set;}
    public String postal_code{get;set;}
    public String country_code{get;set;}
    public String phone{get;set;}
    public String city{get;set;}
    public String state{get;set;}
    public String line1{get;set;}
    public String recipient_name{get;set;}
}
public class redirect_urls{
    public String return_url{get;set;}
    public String cancel_url{get;set;}
}
public class payment_options{
    public String allowed_payment_method{get;set;}
}
public class payer{
    public String payment_method{get;set;}
}
public class items{
    public String quantity{get;set;}
    public String description{get;set;}
    public String name{get;set;}
    public String price{get;set;}
    public String currency1{get;set;}
    public String sku{get;set;}
    public String tax{get;set;}
}
public class item_list{
    public list<items> items{get;set;}
    public shipping_address shipping_address{get;set;}
}
public class details{
    public String insurance{get;set;}
    public String shipping{get;set;}
    public String handling_fee{get;set;}
    public String tax{get;set;}
    public String shipping_discount{get;set;}
    public String subtotal{get;set;}
}
public class amount{
    public details details{get;set;}
    public String currency1{get;set;}
    public String total{get;set;}
}
 

public void setBody(){
    this.intent = 'sale'; // sales
    this.note_to_payer = 'Payment received'; // note
    
       this.redirect_urls = new redirect_urls();
       this.redirect_urls.return_url='https://brillio96-dev-ed.lightning.force.com/lightning/page/home';
    
    this.redirect_urls.cancel_url='https://brillio96-dev-ed.lightning.force.com/lightning/page/home';
    
    this.payer = new payer();
    this.payer.payment_method='paypal'; // payment_method
    this.transactions = new list<transactions>(); // xyz
    transactions t1= new transactions();
    // transaction1 amount
        t1.amount = new amount();
           t1.amount.currency1 = 'USD';
        t1.amount.total = '30.11';
    
            t1.amount.details = new details();
    
        t1.amount.details.insurance = '0.01';
        t1.amount.details.shipping='0.03';
        t1.amount.details.handling_fee='1.00';
           t1.amount.details.tax='0.07';
        t1.amount.details.shipping_discount='-1.00';
        t1.amount.details.subtotal='30.00';
    
    // transaction1 strings
        t1.invoice_number = '48787589673kjhga98';
        t1.custom ='EBAY_EMS_90048630024435';
        t1.description = 'The payment transaction description.';
        t1.soft_descriptor ='ECHI5786786';
    
    // transaction1 payment mentod
        t1.payment_options = new payment_options();
          t1.payment_options.allowed_payment_method='INSTANT_FUNDING_SOURCE';
    
    // transaction1 item_lists shipping address
          t1.item_list = new item_list();
        t1.item_list.items = new list< items>();
        
        items i1 = new items();	
        
        i1.name ='hat';
        i1.quantity ='5';
        i1.description ='Brown Hat';
        i1.price ='3';
        i1.currency1 ='USD';
        i1.sku ='1';
        i1.tax ='0.01';
        
        items i2 = new items();
        i2.name ='handbag';
        i2.quantity ='1';
        i2.description ='Brown handbag';
        i2.price ='15';
        i2.currency1 ='USD';
        i2.sku ='product34';
        i2.tax ='0.02';
        
        t1.item_list.items.add(i1);
        t1.item_list.items.add(i2);
    
        t1.item_list.shipping_address = new shipping_address();
        t1.item_list.shipping_address.postal_code='95131';
        t1.item_list.shipping_address.line2='Unit #34';
        t1.item_list.shipping_address.country_code='US';
        t1.item_list.shipping_address.line1='4th Floor';
        t1.item_list.shipping_address.phone='011862212345678';
        t1.item_list.shipping_address.state='CA';
        t1.item_list.shipping_address.city='San Jose';
         t1.item_list.shipping_address.recipient_name='Brian Robinson';
    
    this.transactions.add(t1);
    
   
 
   
}

}