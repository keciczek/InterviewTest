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

    @IsTest
    static void shouldCreateUniqueId_whenNotPopulatedOnSave() {
        Account acc = TestBuilders.accountBuilder()
            .setName('name')
            .setContactLastName('contact_last_name')
            .setEmail('test@email.com')
            .get();

        System.assertEquals(null, acc.ExternalId__c, 'External id should be empty before inserting');

        Test.startTest();
        insert acc;
        Test.stopTest();

        acc = [SELECT ExternalId__c FROM Account WHERE Id = :acc.Id];

        System.assertEquals('name_test@email.com', acc.ExternalId__c, 'External Id was generated incorrectly.');
    }

    @IsTest
    static void shouldUpdateExternalId_whenNameChanged() {
        Account acc = TestBuilders.accountBuilder()
            .setName('name')
            .setContactLastName('contact_last_name')
            .setEmail('test@email.com')
            .get();
        insert acc;
        acc = [SELECT ExternalId__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('name_test@email.com', acc.ExternalId__c, 'External Id was generated incorrectly.');

        Test.startTest();
        acc.Name = 'name2';
        update acc;
        Test.stopTest();

        acc = [SELECT ExternalId__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('name2_test@email.com', acc.ExternalId__c, 'External Id was updated incorrectly.');
    }

    @IsTest
    static void shouldUpdateExternalId_whenEmailhanged() {
        Account acc = TestBuilders.accountBuilder()
            .setName('name')
            .setContactLastName('contact_last_name')
            .setEmail('test@email.com')
            .get();
        insert acc;
        acc = [SELECT ExternalId__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('name_test@email.com', acc.ExternalId__c, 'External Id was generated incorrectly.');

        Test.startTest();
        acc.Email__c = 'test2@email.com';
        update acc;
        Test.stopTest();

        acc = [SELECT ExternalId__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('name_test2@email.com', acc.ExternalId__c, 'External Id was updated incorrectly.');
    }
}
