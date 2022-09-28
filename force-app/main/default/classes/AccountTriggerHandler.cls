public with sharing class AccountTriggerHandler extends TriggerHandler {

    private List<Account> newAccounts = Trigger.new;
    private Map<Id, Account> oldAccountsMap = (Map<Id, Account>) Trigger.oldMap;

    public override void beforeInsert() {
        AccountTriggerHelper.populateExternalId(newAccounts);
    }

    public override void afterInsert() {
        AccountTriggerHelper.createRelatedContacts(newAccounts);
    }

    public override void afterUpdate() {
        AccountTriggerHelper.updateExternalId(newAccounts, oldAccountsMap);
        AccountTriggerHelper.createMissingContacts(newAccounts);
    }

}
