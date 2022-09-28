public with sharing class AccountSelectors {

    public static List<Account> getAccountsWithContacts(List<Account> accounts) {
        return [
            SELECT (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :accounts
        ];
    }

}
