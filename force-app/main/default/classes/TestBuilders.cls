@isTest
public with sharing class TestBuilders {

    private static final String DEFAULT_ACCOUNT_NAME = 'Test Account';

    private static Integer accountCount = 0;

    public static AccountBuilder accountBuilder() {
        return new AccountBuilder();
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

}
