trigger OneToOneRelationTruckTruckBooking on Truck_Booking__c (before insert, after delete) {
    if (Trigger.isInsert){
    Id CurrentTruckToBookId = Trigger.New[0].Truck__c;
	Truck__c CurrentTruckToBook = [Select Id, Name, Available__c from Truck__c Where Id = :CurrentTruckToBookId Limit 1];
    if (CurrentTruckToBook.Available__c == false){
        Trigger.New[0].addError(CurrentTruckToBook.Name + ' is Not available for Booking.');
    }
    }
    if (Trigger.isDelete){
        Id TruckIdForCurrentBooking = Trigger.Old[0].Truck__c;
        Truck__c TruckAvailableChange = [Select Id, Name, Available__c from Truck__c Where Id = :TruckIdForCurrentBooking Limit 1];
        if (TruckAvailableChange.Available__c == false && Trigger.Old[0].Booking_Status__c != 'Complete'){
            TruckAvailableChange.Available__c = true;
            update TruckAvailableChange;
        }
    }
}