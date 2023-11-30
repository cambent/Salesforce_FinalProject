public class LegalAdvisorProcessor {

    public static void processLegalAdvisors(List<LegalAdvisor> advisors) {
        List<LegalAdvisor> recordsToUpdate = new List<LegalAdvisor>();
        List<Customer> customersToUpdate = new List<Customer>();

        for (LegalAdvisor advisor : advisors) {
            if (advisor.Status__c == 'Enabled') {
                if (advisor.Id == null) {
                    // Insert new 'Enabled' Legal Advisor
                    insert advisor;
                } else {
                    // Update existing 'Enabled' Legal Advisor
                    recordsToUpdate.add(advisor);
                }
            } else if (advisor.Status__c == 'Disabled' && advisor.Id != null) {
                // Handle existing 'Disabled' Legal Advisor
                advisor.Status__c = 'Disabled';
                recordsToUpdate.add(advisor);
            }

            // Update related customers
            customersToUpdate.addAll(advisor.Related_Customers__r);
        }

        // Update Legal Advisor records
        if (!recordsToUpdate.isEmpty()) {
            update recordsToUpdate;
        }

        // Update related customer records
        if (!customersToUpdate.isEmpty()) {
            update customersToUpdate;
        }
    }
}
