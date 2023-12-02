// clientList.js
import { LightningElement, wire } from 'lwc';
import getClients from '@salesforce/apex/ClientController.getClients';

export default class ClientList extends LightningElement {
    @wire(getClients)
    clients;

    // You can add more methods or event handlers here as needed
}
