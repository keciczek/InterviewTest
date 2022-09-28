@isTest
public with sharing class TestBuilders {

    private static final String DEFAULT_ACCOUNT_NAME = 'Test Account';
    private static final String DEFAULT_CONTACT_NAME = 'Test Contact';

    private static Integer accountCount = 0;
    private static Integer contactCount = 0;

    public static AccountBuilder accountBuilder() {
        return new AccountBuilder();
    }

    public static ContactBuilder contactBuilder() {
        return new ContactBuilder();
    }

    public class AccountBuilder {

        private Account record;

        public AccountBuilder() {
            this.record = new Account(
                Name = DEFAULT_ACCOUNT_NAME + ++accountCount
            );
        }

        public AccountBuilder setName(String name) {
            this.record.Name = name;
            return this;
        }

        public AccountBuilder setEmail(String email) {
            this.record.Email__c = email;
            return this;
        }

        public AccountBuilder setContactFirstName(String contactFirstName) {
            this.record.ContactFirstName__c = contactFirstName;
            return this;
        }

        public AccountBuilder setContactLastName(String contactLastName) {
            this.record.ContactLastName__c = contactLastName;
            return this;
        }

        public AccountBuilder setContactPhone(String phone) {
            this.record.ContactPhone__c = phone;
            return this;
        }

        public Account get() {
            return this.record;
        }

        public Account insertAndGet() {
            insert this.record;
            return this.record;
        }
    }

    public class ContactBuilder {

        private Contact record;

        public ContactBuilder() {
            this.record = new Contact(
                LastName = DEFAULT_CONTACT_NAME + ++contactCount
            );
        }

        public ContactBuilder setLastName(String name) {
            this.record.LastName = name;
            return this;
        }

        public ContactBuilder setEmail(String email) {
            this.record.Email = email;
            return this;
        }

        public Contact get() {
            return this.record;
        }

        public Contact insertAndGet() {
            insert this.record;
            return this.record;
        }
    }

}
