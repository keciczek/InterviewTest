public with sharing class AccountTriggerHandler extends TriggerHandler {

    private List<Account> newAccounts = Trigger.new;

    public override void afterInsert() {
        AccountTriggerHelper.createRelatedContacts(newAccounts);
    }

}
