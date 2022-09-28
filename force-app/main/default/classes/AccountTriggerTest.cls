@IsTest
public with sharing class AccountTriggerTest {

    @IsTest
    static void shouldCreateContact_onAccountInsert() {
        Account acc = TestBuilders.accountBuilder()
            .setContactFirstName('First Name')
            .setContactLastName('Last Name')
            .setContactPhone('123456789')
            .setEmail('test@test.pl')
            .get();

        Test.startTest();
        insert acc;
        Test.stopTest();

        List<Contact> contacts = [SELECT FirstName, LastName, Email, Phone FROM Contact];

        System.assertEquals(1, contacts.size(), 'Should create exactly one Contact record.');
        System.assertEquals(acc.ContactFirstName__c, contacts[0].FirstName, 'First names do not match.');
        System.assertEquals(acc.ContactLastName__c, contacts[0].LastName, 'Last names do not match.');
        System.assertEquals(acc.ContactPhone__c, contacts[0].Phone, 'Contact phones do not match.');
        System.assertEquals(acc.Email__c, contacts[0].Email, 'Emails do not match.');
    }
}
