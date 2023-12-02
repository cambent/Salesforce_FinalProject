public class HerokuProcessor {
    public HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        // If the request is successful, parse the JSON response. 
        if(response.getStatusCode() == 200) {
            List<Object> LegalAccountJSON = (List<Object>)JSON.deserializeUntyped(response.getBody());
            List<Legal_Advisor__c> legaladvisorToUpsert = new List<Legal_Advisor__c>();
            List<Client__c> clientToUpsert = new List<Client__c>();
            
            for(Object LegalAccountJSON : legalAdvisorJSON) {

                String accountStatus = (String)legalAdvisorJSON.get('AccountStatus');
                if(accountStatus != null && accountStatus.equals('Enabled')){
                   String accountName = (String)legalAdvisorJSON.get('AccountName');
                   String accountNumber = (String)legalAdvisorJSON.get('AccountNumber');
                  Date asOfDate = Date.parse((String)legalAdvisorJSON.get('AsOfDate'));


                    Legal_Advisor__c legalAdvisor = new Legal_Advisor__c(accountNumber, accountName, accountStatus, asOfDate);

               upsert legalAdvisor;
                } else if (accountStatus.equals('Disable')) { 
                    String accountNumber = (String)legalAdvisorJSON.get('AccountNumber');
                    List<ucl_LegalAdvisor> legalAdvisor = ucl_LegalAdvisor.getLegalAdvisorByAccountNumber(accountNumber);

                    if(!legalAdvisor.isEmpty()) {
                        String accountName = (String)legalAdvisorJSON.get('AccountName');
                        String accountNumber = (String)legalAdvisorJSON.get('AccountNumber');
                        Date asOfDate = Date.parse((String)legalAdvisorJSON.get('AsOfDate'));

                        Legal_Advisor__c legalAdvisor = new Legal_Advisor__c(accountNumber, accountName, accountStatus, asOfDate);
                        update legalAdvisor;
                    }

                }
            
            }
        }
        return response;
    }
}


