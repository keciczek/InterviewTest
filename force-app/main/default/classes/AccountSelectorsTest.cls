@IsTest
public with sharing class AccountSelectorsTest {

    @IsTest
    static void testGetAccountsWithContacts() {

        Account acc = TestBuilders.accountBuilder()
            .setName('name')
            .setContactLastName('contact_last_name')
            .setEmail('test@email.com')
            .insertAndGet();

        List<Account> accountOnlyId = [SELECT Id FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, accountOnlyId.size(), 'Should create only one record.');
        System.assertEquals(0, accountOnlyId[0].Contacts.size(), 'Account should not have contacts at this point');

        Test.startTest();
        List<Account> accountsWithContacts = AccountSelectors.getAccountsWithContacts(accountOnlyId);
        Test.stopTest();

        System.assertEquals(1, accountsWithContacts.size(), 'Should return only one record.');
        System.assertEquals(1, accountsWithContacts[0].Contacts.size(), 'Account should contain related Contacts');
    }

}
