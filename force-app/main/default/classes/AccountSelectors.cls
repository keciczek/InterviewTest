public with sharing class AccountSelectors {

    public static List<Account> getAccountsWithContacts(List<Account> accounts) {
        return [
            SELECT
                (SELECT Id FROM Contacts),
                ContactFirstName__c,
                ContactLastName__c,
                ContactPhone__c,
                Email__c
            FROM Account
            WHERE Id IN :accounts
        ];
    }

}
