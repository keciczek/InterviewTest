public with sharing class ContactTriggerHelper {

    private static final String CONTACT_UNIQUE_ID_TEMPLATE = '{0}_{1}';

    public static void validateUnique(List<Contact> newContacts) {
        Map<String, List<Contact>> contacts = ContactSelectors.getContactsMappedByName(newContacts);
        Map<Id, Contact> withLastNames = new Map<Id, Contact>([SELECT Name FROM Contact WHERE Id IN : newContacts]);

        for (Contact c : newContacts) {
            Contact withName = withLastNames.get(c.Id);
            if (contacts.containsKey(withName.Name) && contacts.get(withName.Name).size() > 1) {
                c.addError('Duplicated');
            }
        }
    }

}
