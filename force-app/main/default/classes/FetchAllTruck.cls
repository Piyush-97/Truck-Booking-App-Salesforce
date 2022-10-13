public with sharing class FetchAllTruck {
    @AuraEnabled(Cacheable=true)
    public static List<Truck__c> fetchTrucks(){
        return [SELECT Name, Truck_Image__c, Maximum_Load__c, Cost__c, Available__c FROM Truck__c WITH SECURITY_ENFORCED];
    }
}