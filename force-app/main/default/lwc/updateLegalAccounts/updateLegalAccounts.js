import { LightningElement} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import LEGAL_ADVISOR_OBJECT from '@salesforce/schema/LegalAdvisor';
import ACCOUNT_STATUS_FIELD from '@salesforce/schema/Account.Status';
import ACCOUNT_NUMBER_FIELD  from '@salesforce/schema/Account.Number';
import CLIENT_NUMBER_FIELD from '@salesforce/schema/Client.Number';
export default class LdsCreateRecord extends LightningElement {
    handleButtonClick() {
        const recordInput = {
            apiName: LEGAL_ADVISOR_OBJECT.objectApiName,
            fields: {[ACCOUNT_STATUS_FIELD.fieldApiName] : 'ENABLED'
                     [ACCOUNT_NUMBER_FIELD.fieldApiName] 
                     [CLIENT_NUMBER_FIELD.fieldApiName]  
             }
        };
        createRecord(recordInput)
            .then(account => {
                // code to execute if create operation is successful
            })
            .catch(error => {
                // code to execute if create operation is not successful
            });
    }
}