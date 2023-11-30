trigger LegalAdvisorIntegrationTrigger on LegalAdvisor__c (after insert, after update, after delete) {
    LegalAdvisorIntegrationHandler.handleIntegration(Trigger.new, Trigger.isDelete);
}
