trigger AccountTrigger on Account (before insert, after insert, after update) {
    new AccountTriggerHandler().run();
}