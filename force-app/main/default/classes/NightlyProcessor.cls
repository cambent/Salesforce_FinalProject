public class NightyProcessor {
    public HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        // Verificar si la solicitud fue exitosa y parsear la respuesta JSON.
        if (response.getStatusCode() == 200) {
            List<Object> legalAccountJSON = (List<Object>)JSON.deserializeUntyped(response.getBody());
            List<Legal_Advisor__c> legalAdvisorToUpsert = new List<Legal_Advisor__c>();
            
            // Iterar sobre la lista de cuentas legales JSON
            for (Object legalAdvisorJSON : legalAdvisorJSON) {
                Map<String, Object> legalAdvisorJSONMap= new (Map<String, Object>) legalAdvisorJSONMap;
                String accountStatus = (String) legalAdvisorJSONMap.get('AccountStatus');

                if (accountStatus != null && accountStatus.equals('Enabled')) {
                    String accountName = (String)legalAdvisorJSON.get('AccountName');
                    String accountNumber = (String)legalAdvisorJSON.get('AccountNumber');
                    Date asOfDate = Date.parse((String)legalAdvisorJSON.get('AsOfDate'));

                    Legal_Advisor__c legalAdvisor = new Legal_Advisor__c(
                        AccountNumber__c = accountNumber,
                        AccountName__c = accountName,
                        AccountStatus__c = accountStatus,
                        AsOfDate__c = asOfDate
                    );

                    legalAdvisorToUpsert.add(legalAdvisor);
                } else if (accountStatus.equals('Disable')) {
                    String accountNumber = (String)legalAdvisorJSON.get('AccountNumber');
                    List<Legal_Advisor__c> legalAdvisors = [SELECT Id FROM Legal_Advisor__c WHERE AccountNumber__c = :accountNumber LIMIT 1];

                    if (!legalAdvisors.isEmpty()) {
                        Legal_Advisor__c legalAdvisor = legalAdvisors[0];
                        legalAdvisor.AccountStatus__c = accountStatus;
                        update legalAdvisor;

                        try{
                            asOfDate = date.paese(asOfDateString);
                        }catch (Exception e)
                        System.debug('Error de fecha: ' + e.getMessage());
                        asOfDate = Date.today();

                    }
                }
            }
            // Realizar la operación de upsert después de la iteración
            if (!legalAdvisorToUpsert.isEmpty()) {
                upsert legalAdvisorToUpsert AccountNumber__c;
            }
        }

        return response;
    }
}

public class ExecuteNightlyProcess implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Legal_Advisor__c> legalAdvisor = [SELECT AccountNumber, AccountName, AccountStatus, asOfDate
            FROM legalAdvisorJSON
            WHERE IsClosed = False AND
            CloseDate < TODAY];
        // Create a task for each opportunity in the list
        TaskUtils.remindOwners(opptys);
    }
}

@isTest
private class TestNightyProcessor {
    @isTest
    static void TestUpdateInsertLegalAdvisorAccount() {
        // Configurar un mock para simular la llamada HTTP
        Test.setMock(HttpCalloutMock.class, new NightyProcessorMock());

        // Iniciar el entorno de prueba
        Test.startTest();

        // Instanciar NightyProcessor
        NightyProcessor processor = new NightyProcessor();

        // Llamar al método makeGetCallout en la instancia
        HttpResponse response = processor.makeGetCallout();

        // Detener el entorno de prueba
        Test.stopTest();

        // Verificar la respuesta HTTP
        System.assertEquals(200, response.getStatusCode(), 'La llamada HTTP no devolvió el código 200 OK');
    }
}