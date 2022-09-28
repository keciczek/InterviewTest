public with sharing class AccountTriggerHelper {

    public static void createRelatedContacts(List<Account> accounts) {
        List<Contact> contacts = new List<Contact>();

        for (Account acc : accounts) {
            contacts.add(createContactFromAccount(acc));
        }

        insert contacts;
    }

    private static Contact createContactFromAccount(Account acc) {
        return new Contact(
            FirstName = acc.ContactFirstName__c,
            LastName = acc.ContactLastName__c,
            Email = acc.Email__c,
            Phone = acc.ContactPhone__c
        );
    }

}
