public with sharing class AccountTriggerHelper {

    private static final String EXTERNAL_ID_TEMPLATE = '{0}_{1}';

    public static void populateExternalId(List<Account> accounts) {
        for (Account acc : accounts) {
            if (String.isBlank(acc.ExternalId__c)) {
                acc.ExternalId__c = getExternalId(acc);
            }
        }
    }

    public static void createRelatedContacts(List<Account> accounts) {
        List<Contact> contacts = new List<Contact>();

        for (Account acc : accounts) {
            contacts.add(createContactFromAccount(acc));
        }

        insert contacts;
    }

    private static String getExternalId(Account acc) {
        return String.format(EXTERNAL_ID_TEMPLATE, new List<String> { acc.Name, acc.Email__c });
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
