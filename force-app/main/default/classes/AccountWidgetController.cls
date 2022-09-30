public with sharing class AccountWidgetController {

    @AuraEnabled
    public static String getAccountData(String query) {
        try {
            return AccountWidgetService.getAccountData(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }

    @AuraEnabled
    public static void updateAccount(Decimal revenue, String ranking, Id accountId) {
        try {
            AccountWidgetService.updateAccount(revenue, ranking, accountId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}