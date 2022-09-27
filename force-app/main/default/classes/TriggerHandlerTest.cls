@IsTest
public with sharing class TriggerHandlerTest {

    @IsTest
    static void testBeforeInsert() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('beforeInsert');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'beforeInsert');

    }

    @IsTest
    static void testAfterInsert() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('afterInsert');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'afterInsert');

    }

    @IsTest
    static void testBeforeUpdate() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('beforeUpdate');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'beforeUpdate');
    }

    @IsTest
    static void testAfterUpdate() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('afterUpdate');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'afterUpdate');

    }

    @IsTest
    static void testBeforeDelete() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('beforeDelete');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'beforeDelete');

    }

    @IsTest
    static void testAfterDelete() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('afterDelete');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'afterDelete');

    }

    @IsTest
    static void testAfterUndelete() {

        TriggerHandlerInstance handler = new TriggerHandlerInstance();
        handler.setTestContext('afterUndelete');
        handler.run();

        System.assertEquals(handler.lastMethodCalled, 'afterUndelete');

    }

    private class TriggerHandlerInstance extends TriggerHandler {

        public override void beforeInsert() { this.lastMethodCalled = 'beforeInsert'; }
        public override void afterInsert() { this.lastMethodCalled = 'afterInsert'; }
        public override void beforeUpdate() { this.lastMethodCalled = 'beforeUpdate'; }
        public override void afterUpdate() { this.lastMethodCalled = 'afterUpdate'; }
        public override void beforeDelete() { this.lastMethodCalled = 'beforeDelete'; }
        public override void afterDelete() { this.lastMethodCalled = 'afterDelete'; }
        public override void afterUndelete() { this.lastMethodCalled = 'afterUndelete'; }

    }

}
