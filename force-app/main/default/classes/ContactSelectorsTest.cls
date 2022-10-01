@IsTest
public with sharing class ContactSelectorsTest {

    @IsTest
    static void testGetByNameAndEmail() {
        Contact c = TestBuilders.ContactBuilder()
            .setLastName('name')
            .setEmail('test@email.com')
            .insertAndGet();

        Test.startTest();
        List<Contact> cs = ContactSelectors.getByEmailAndName('test@email.com', 'name');
        Test.stopTest();

        System.assertEquals(1, cs.size(), 'Should return one record with this external Id.');
        System.assertEquals(c.Id, cs[0].Id, 'Should return the same record');
    }

    @IsTest
    static void testGetContactsMappedByName() {
        Contact c = TestBuilders.ContactBuilder()
            .setLastName('name')
            .setEmail('test@email.com')
            .insertAndGet();

        c = [SELECT Name FROM Contact WHERE Id = :c.Id];

        Test.startTest();
        Map<String, List<Contact>> cs = ContactSelectors.getContactsMappedByName(new List<Contact> { c });
        Test.stopTest();

        System.assert(cs.containsKey(c.Name));
        System.assertEquals(1, cs.get(c.Name).size());

    }

}
