public class ucl_LegalAdvisors {

    public static void migrateLegalAdvisors() {
        // Logic to retrieve JSON data from Heroku
        String herokuJson = HerokuWebService.getJsonData(LegalAccounts.JSON);

        // Parse JSON and insert/update Legal Advisors in Salesforce
        List<ucl_LegalAdvisor__c> legalAdvisors = ucl_JsonParser.parseLegalAdvisors(herokuJson);
        upsert legalAdvisors ucl_LegalAdvisor__c.Account_Number__c;
    }
}
