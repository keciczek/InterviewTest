@IsTest
public with sharing class OpportunityRestServiceTest {

    private static final String TEST_EXTERNAL_ID = 'test_email@test.pl';
    private static final String TEST_NAME = 'test_email@test.pl';
    private static final String STATUS = 'status';
    private static final String CONTACT_EMAIL = 'contact@email.com';
    private static final String CONTACT_NAME = 'first name last name';

    @IsTest
    static void shouldReturnError_whenArgumentEmpty() {

        Test.startTest();
        OpportunityRestService.ServiceResponse response = OpportunityRestService.createOpportunity(null, TEST_NAME, STATUS, CONTACT_EMAIL, CONTACT_NAME);
        Test.stopTest();

        System.assertEquals(400, response.status, 'Invalid response code.');
        System.assertEquals(OpportunityRestService.EMPTY_ARGUMENTS, response.message, 'Invalid response message.');
    }

    @IsTest
    static void shouldReturnAccountError_whenExternalIdAccDoesntExist() {

        Test.startTest();
        OpportunityRestService.ServiceResponse response = OpportunityRestService.createOpportunity(TEST_EXTERNAL_ID, TEST_NAME, STATUS, CONTACT_EMAIL, CONTACT_NAME);
        Test.stopTest();

        System.assertEquals(404, response.status, 'Invalid response code.');
        System.assertEquals(OpportunityRestService.COULT_NOT_FIND_ACCOUNT, response.message, 'Invalid response message.');
    }

    @IsTest
    static void shouldReturnContactError_whenContactDoesntExist() {

        TestBuilders.AccountBuilder()
            .setName('test')
            .setEmail('email@test.pl')
            .setContactLastName('contact_last_name')
            .insertAndGet();

        Test.startTest();
        OpportunityRestService.ServiceResponse response = OpportunityRestService.createOpportunity(TEST_EXTERNAL_ID, TEST_NAME, STATUS, CONTACT_EMAIL, CONTACT_NAME);
        Test.stopTest();

        System.assertEquals(404, response.status, 'Invalid response code.');
        System.assertEquals(OpportunityRestService.COULT_NOT_FIND_CONTACT, response.message, 'Invalid response message.');
    }

    @IsTest
    static void shouldReturnSuccessMessage_whenOpptyCreated() {

        TestBuilders.AccountBuilder()
            .setName('test')
            .setEmail('email@test.pl')
            .setContactLastName('contact_last_name')
            .insertAndGet();

        TestBuilders.contactBuilder()
            .setEmail(CONTACT_EMAIL)
            .setLastName('last name')
            .setFirstName('first name')
            .insertAndGet();

        Test.startTest();
        OpportunityRestService.ServiceResponse response = OpportunityRestService.createOpportunity(TEST_EXTERNAL_ID, TEST_NAME, STATUS, CONTACT_EMAIL, CONTACT_NAME);
        Test.stopTest();

        System.assertEquals(201, response.status, 'Invalid response code.');
        System.assertEquals(OpportunityRestService.OPPORTUNITY_CREATED, response.message, 'Invalid response message.');
    }
}
