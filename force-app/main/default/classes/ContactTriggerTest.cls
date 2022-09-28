@IsTest
public with sharing class ContactTriggerTest {

    @IsTest
    static void shouldCreateUniqueId_whenContactInserted() {
        Contact c = TestBuilders.contactBuilder()
            .setLastName('last_name')
            .setEmail('test@email.com')
            .get();

        Test.startTest();
        insert c;
        Test.stopTest();

        c = [SELECT ContactUniqueId__c FROM Contact WHERE Id = :c.Id];
        System.assertEquals('last_name_test@email.com', c.ContactUniqueId__c, 'Unique id was created incorrectyl.');
    }

    @IsTest
    static void shouldNotCreateContact_ifIdUniqueDuplicates() {

        Contact c = TestBuilders.contactBuilder()
            .setLastName('last_name')
            .setEmail('test@email.com')
            .get();

        insert c;

        c = TestBuilders.contactBuilder()
            .setLastName('last_name')
            .setEmail('test@email.com')
            .get();

        Boolean exceptionThrown = false;

        Test.startTest();
            try {
                insert c;
            } catch (Exception e) {
                exceptionThrown = true;
            }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Exception should be thrown because Contact is not unique.');

    }

}
