trigger AccountTrigger on Account (before insert) {
    new AccountTriggerHandler().run();
}