public with sharing class ContactTriggerHelper {

    private static final String CONTACT_UNIQUE_ID_TEMPLATE = '{0}_{1}';

    public static void populateUniqueField(List<Contact> contacts) {
        for(Contact c : contacts) {
            c.ContactUniqueId__c = getContactUniqueId(c);
        }
    }

    private static String getContactUniqueId(Contact c) {
        return String.format(CONTACT_UNIQUE_ID_TEMPLATE, new List<String> { c.LastName, c.Email });
    }

}
