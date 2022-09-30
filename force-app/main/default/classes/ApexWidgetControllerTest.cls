@IsTest
public with sharing class ApexWidgetControllerTest {

    private static final String SUCCESS_RESPONSE = '{"revenue":100,"ranking":"High"}';
    private static final String ERROR_RESPONSE = '{"error": "true"}';

    @IsTest
    static void testGetAccountDataSuccess() {
        Test.setMock(HttpCalloutMock.class, new SuccessMock());

        Test.startTest();
        String result = AccountWidgetController.getAccountData('test');
        Test.stopTest();

        System.assertEquals(SUCCESS_RESPONSE, result, 'Valid response should be returned on successfull callout');

    }

    @IsTest
    static void testGetAccountDataError() {
        Test.setMock(HttpCalloutMock.class, new FailMock());

        Boolean exceptionThrown = false;

        Test.startTest();
        try {
            String result = AccountWidgetController.getAccountData('test');
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Exception should be thrown when callout fails.');

    }

    @IsTest
    static void testUpdateAccount() {
        Account acc = TestBuilders.accountBuilder()
            .setName('name')
            .setContactLastName('contact_last_name')
            .setEmail('test@email.com')
            .insertAndGet();

        acc = [SELECT Rating__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, acc.Rating__c, 'Rating should be empty at this moment.');

        Test.startTest();
        AccountWidgetController.updateAccount(20, 'High', acc.Id);
        Test.stopTest();

        acc = [SELECT Rating__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('20 - High', acc.Rating__c, 'Invalid rating value.');
    }

    public class SuccessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(SUCCESS_RESPONSE);
            res.setStatusCode(200);
            return res;
        }
    }

    public class FailMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(ERROR_RESPONSE);
            res.setStatusCode(404);
            return res;
        }
    }
}
