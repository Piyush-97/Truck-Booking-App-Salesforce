import { LightningElement, wire } from "lwc";
import fetchTrucks from "@salesforce/apex/FetchAllTruck.fetchTrucks";

const columns = [
    { label: 'Truck Type', fieldName: 'Name' },
    { label: 'Truck Image', fieldName: 'Image', type: 'image' },
    { label: 'Maximum Load (in Ton)', fieldName: 'Maximum_Load__c', type: 'number' },
    { label: 'Cost (in Rupees)', fieldName: 'Cost__c', type: 'number' },
    { label: 'Available For Booking', fieldName: 'Available__c', type: 'checkbox' },
];

export default class TruckListLWC extends LightningElement {
    truckColumns = columns;
    truckRecords = [];
    wiredTrucksErrors;

    @wire(fetchTrucks)
    wiredTrucks({ error, data }) {
        if (data) {
            let tempRecords = [];
            console.table(data);
            data.forEach(element => {
                let tempElement = {...element };
                let parser = new DOMParser();
                let htmlDoc = parser.parseFromString(element.Truck_Image__c, 'text/html');
                console.log(htmlDoc.getElementsByTagName('img')[0].src)
                tempElement.Image = htmlDoc.getElementsByTagName('img')[0].src;
                tempRecords.push(tempElement);
            });
            this.truckRecords = tempRecords;
            this.wiredTrucksErrors = undefined;
        } else if (error) {
            this.wiredTrucksErrors = error;
            this.truckRecords = undefined;
        }
    }
}