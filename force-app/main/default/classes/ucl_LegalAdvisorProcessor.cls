public class ucl_LegalAdvisorProcessor{
    public static void processLegalAdvisors(List<LegalAdvisor> advisors) {
        List<LegalAdvisor> recordsToUpdate = new List<LegalAdvisor>();
        List<Customer> clientToUpdate = new List<client>();

        for (LegalAdvisor advisor : advisors) {
            if (advisor.Status__c == 'Enabled') {
                if (advisor.AccountNumber == null) {
                    // Insert new 'Enabled' Legal Advisor
                    insert advisor;
                } else {
                    // Update existing 'Enabled' Legal Advisor
                    recordsToUpdate.add(advisor);
                }
            } else if (advisor.Status__c == 'Disabled' && advisor.AccountNumber != null) {
                // Handle existing 'Disabled' Legal Advisor
                advisor.Status__c = 'Disabled';
                recordsToUpdate.add(advisor);
            }

            // Update related clients
            customersToUpdate.addAll(advisor.Related_Client__r);
        }

        // Update Legal Advisor records
        if (!recordsToUpdate.isEmpty()) {
            update recordsToUpdate;
        }

        // Update related client records
        if (!customersToUpdate.isEmpty()) {
            update customersToUpdate;
        }
    }
}
