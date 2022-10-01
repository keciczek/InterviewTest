@RestResource(urlMapping='/Opportunity/*')
global with sharing class OpportunityRestService {

    @TestVisible private static final String COULT_NOT_FIND_ACCOUNT = 'Couldn\'t find an Account.';
    @TestVisible private static final String COULT_NOT_FIND_CONTACT = 'Couldn\'t find a Contact.';
    @TestVisible private static final String EMPTY_ARGUMENTS = 'At least one of the arguments is empty';
    @TestVisible private static final String OPPORTUNITY_CREATED = 'Opportunity created. ';

    @HttpPost
    global static ServiceResponse createOpportunity(String externalId, String name, String status, String contactEmail, String contactName) {

        if (String.isBlank(externalId) || String.isBlank(name) || String.isBlank(status) || String.isBlank(contactEmail) || String.isBlank(contactName)) {
            return new ServiceResponse(EMPTY_ARGUMENTS, 400);
        }

        Opportunity oppty = new Opportunity(
                Name = name,
                StageName = 'Qualification',
                CloseDate = Date.today().addDays(7)
            );

        List<Account> acc = AccountSelectors.getByExternalId(externalId);
        if (acc.isEmpty()) {
            return new ServiceResponse(COULT_NOT_FIND_ACCOUNT, 404);
        }
        oppty.AccountId = acc[0].Id;

        List<Contact> c = ContactSelectors.getByEmailAndName(contactEmail, contactName);
        if (c.isEmpty()) {
            return new ServiceResponse(COULT_NOT_FIND_CONTACT, 404);
        }
        oppty.Contact__c = c[0].Id;

        try {
            insert oppty;
            return new ServiceResponse(OPPORTUNITY_CREATED, 201);
        } catch (DmlException e) {
            return new ServiceResponse('Error creating the opportunity.' + e.getMessage(), 500);
        }
    }

    global class ServiceResponse {
        @TestVisible private String message;
        @TestVisible private Integer status;

        global ServiceResponse(String msg, Integer status) {
            if (!Test.isRunningTest()) {
                RestResponse res = RestContext.response;
                res.statusCode = status;
            }
            this.message = msg;
            this.status = status;
        }
    }

}