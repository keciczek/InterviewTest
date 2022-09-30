public with sharing class AccountWidgetService {

    private static final String BASE_URL = 'https://mockup-sf-api-call.herokuapp.com/company-data?param={0}';
    private static final Integer STATUS_CODE_OK = 200;

    public static String getAccountData(String query) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(String.format(BASE_URL, new List<String> { query }));
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('status code ' + res.getStatusCode());
        if (res.getStatusCode() == 200) {
            return res.getBody();
        } else {
            throw new CalloutException('Error! : ' + res.getStatusCode());
        }
    }

    public static void updateAccount(Decimal revenue, String ranking, Id accountId) {
        update new Account(
            Id = accountId,
            Rating__c = String.format('{0} - {1}', new List<String> { String.valueOf(revenue), ranking })
        );
    }

    private class CalloutException extends Exception { }
}
