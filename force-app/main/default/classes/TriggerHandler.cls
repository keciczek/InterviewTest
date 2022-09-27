public virtual class TriggerHandler {


    private String testTriggerContext;
    private Context triggerContext;
    private Boolean isInTriggerTest = false;

    @TestVisible
    protected String lastMethodCalled;

    protected virtual void beforeInsert() {}
    protected virtual void afterInsert() {}
    protected virtual void beforeUpdate() {}
    protected virtual void afterUpdate() {}
    protected virtual void beforeDelete() {}
    protected virtual void afterDelete() {}
    protected virtual void afterUndelete() {}

    public void run() {
        this.setTriggerContext();

        switch on this.triggerContext {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    @TestVisible
    private void setTestContext(String ctx) {
        this.testTriggerContext = ctx;
        this.isInTriggerTest = true;
    }

    private void setTriggerContext() {
        if (!this.isInTriggerTest && Trigger.isBefore && Trigger.isInsert
            || this.isInTriggerTest && this.testTriggerContext == 'beforeInsert') {
            this.triggerContext = Context.BEFORE_INSERT;
        } else if (!this.isInTriggerTest && Trigger.isAfter && Trigger.isInsert
                || this.isInTriggerTest && this.testTriggerContext == 'afterInsert') {
            this.triggerContext = Context.AFTER_INSERT;
        } else if (!this.isInTriggerTest && Trigger.isBefore && Trigger.isUpdate
                || this.isInTriggerTest && this.testTriggerContext == 'beforeUpdate') {
            this.triggerContext = Context.BEFORE_UPDATE;
        } else if (!this.isInTriggerTest && Trigger.isAfter && Trigger.isUpdate
                || this.isInTriggerTest && this.testTriggerContext == 'afterUpdate') {
            this.triggerContext = Context.AFTER_UPDATE;
        } else if (!this.isInTriggerTest && Trigger.isBefore && Trigger.isDelete
                || this.isInTriggerTest && this.testTriggerContext == 'beforeDelete') {
            this.triggerContext = Context.BEFORE_DELETE;
        } else if (!this.isInTriggerTest && Trigger.isAfter && Trigger.isDelete
                || this.isInTriggerTest && this.testTriggerContext == 'afterDelete') {
            this.triggerContext = Context.AFTER_DELETE;
        } else if (!this.isInTriggerTest && Trigger.isAfter && Trigger.isUnDelete
                || this.isInTriggerTest && this.testTriggerContext == 'afterUndelete') {
            this.triggerContext = Context.AFTER_UNDELETE;
        }
    }

    @TestVisible
    private enum Context {
        BEFORE_INSERT,
        AFTER_INSERT,
        BEFORE_UPDATE,
        AFTER_UPDATE,
        BEFORE_DELETE,
        AFTER_DELETE,
        AFTER_UNDELETE
    }

}
