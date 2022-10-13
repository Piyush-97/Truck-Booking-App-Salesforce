@isTest
private class TestFetchAllTruck {
	@testSetup
    static void setup(){
        List<Truck__c> listTruck= new List<Truck__c>();
        for (Integer i=0; i<5; i++){
            Truck__c t = new Truck__c();
            t.Name = 'Test Truck '+i;
            t.Maximum_Load__c = 1;
            t.Cost__c = 1000;
            listTruck.add(t);
        }
        insert listTruck;
    }
  	
    @isTest
    static void testFetchTucks(){
        List<Truck__c> listOfTruck = FetchAllTruck.fetchTrucks();
        System.assertEquals(5, listOfTruck.size(), 'Trucks are not fetching correctly.');
    }
}