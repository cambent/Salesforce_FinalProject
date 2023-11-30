import { LightningElement, wire } from 'lwc';
import getClients from '@salesforce/apex/ClientController.getClients';

export default class ShowNewClientsList extends LightningElement {
    clients;
    error;

    @wire(getClients)
    wiredClients({ error, data }) {
        if (data) {
            this.clients = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.clients = undefined;
        }
    }
}
