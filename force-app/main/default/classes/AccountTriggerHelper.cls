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

    public static void updateExternalId(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        List<Account> accountsToConsider = new List<Account>();

        for (Account acc : newAccounts) {
            if (nameOrEmailChanged(acc, oldAccounts.get(acc.Id))) {
                accountsToConsider.add(acc);
            }
        }

        if (accountsToConsider.isEmpty()) {
            return;
        }

        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : accountsToConsider) {
            accountsToUpdate.add(new Account(
                Id = acc.Id,
                ExternalId__c = getExternalId(acc)
            ));
        }

        update accountsToUpdate;
    }

    public static void createMissingContacts(List<Account> accounts) {
        List<Account> accountsWithContacts = AccountSelectors.getAccountsWithContacts(accounts);
        List<Account> accountsToCreateContacts = new List<Account>();

        for (Account acc : accountsWithContacts) {
            if (acc.Contacts.isEmpty()) {
                accountsToCreateContacts.add(acc);
            }
        }

        if (!accountsToCreateContacts.isEmpty()) {
            createRelatedContacts(accountsToCreateContacts);
        }
    }

    private static String getExternalId(Account acc) {
        return String.format(EXTERNAL_ID_TEMPLATE, new List<String> { acc.Name, acc.Email__c });
    }

    private static Contact createContactFromAccount(Account acc) {
        return new Contact(
            FirstName = acc.ContactFirstName__c,
            LastName = acc.ContactLastName__c,
            Email = acc.Email__c,
            Phone = acc.ContactPhone__c,
            AccountId = acc.Id
        );
    }

    private static Boolean nameOrEmailChanged(Account newAccount, Account oldAccount) {
        return newAccount.Name != oldAccount.Name || newAccount.Email__c != oldAccount.Email__c;
    }

}
