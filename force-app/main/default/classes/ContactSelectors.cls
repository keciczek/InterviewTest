public with sharing class ContactSelectors {

    public static List<Contact> getByEmailAndName(String contactEmail, String contactName) {
        return [SELECT Id FROM Contact WHERE Email = :contactEmail AND Name = :contactName];
    }

    public static Map<String, List<Contact>> getContactsMappedByName(List<Contact> newContacts) {
        Map<String, List<Contact>> res = new Map<String, List<Contact>>();
        Set<String> names = new Set<String>();

        List<Contact> contactsWithFullNames = [SELECT Name FROM Contact WHERE Id IN :newContacts];

        for (Contact c : contactsWithFullNames) {
            names.add(c.Name);
        }

        for (Contact c : [SELECT Name FROM Contact WHERE Name IN :names]) {
            if (!res.containsKey(c.Name)) {
                res.put(c.Name, new List<Contact>());
            }
            res.get(c.Name).add(c);
        }

        return res;
    }
}
