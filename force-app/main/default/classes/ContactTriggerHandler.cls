public with sharing class ContactTriggerHandler extends TriggerHandler {

    private List<Contact> newContacts = Trigger.new;

    public override void afterInsert() {
        ContactTriggerHelper.validateUnique(newContacts);
    }

}
