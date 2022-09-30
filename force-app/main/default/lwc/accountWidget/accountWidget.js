import { api, LightningElement, track } from 'lwc';
import { callApex } from "c/callApex";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccountData from '@salesforce/apex/AccountWidgetController.getAccountData';
import updateAccount from '@salesforce/apex/AccountWidgetController.updateAccount';

export default class AccountWidget extends LightningElement {

    @api recordId;

    @api btnColor;
    @api successMsg;

    revenue;
    ranking;
    isLoading = false;
    error;

    query = '';

    @track
    state = {
        isError: false,
        dataFound: false
    }

    onchange(evt) {
        if (evt.target.dataset.name === 'query') {
            this.query = evt.target.value;
        }
    }

    get buttonClasses() {
        return `slds-button slds-button_brand ${this.btnColor}`;
    }

    onClick(evt) {
        switch (evt.target.dataset.name) {
            case 'search':
                this.search();
                break;
            case 'cancel':
                this.cancel();
                break;
            case 'submit':
                console.log('submitting');
                this.submit();
                break;
        }
    }

    cancel() {
        this.state.dataFound = false;
        this.state.isError = false;
    }

    async submit() {
        this.isLoading = true;
        const [resp, err] = await callApex(updateAccount, {
            revenue: this.revenue,
            ranking: this.ranking,
            accountId: this.recordId
        });
        if (err) {
            this.state.isError = true;
            this.error = err;
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    variant: 'success',
                    message: this.successMsg,
                })
            );
            this.cancel();
        }
        this.isLoading = false;
    }

    async search() {
        const [resp, err] = await callApex(getAccountData, {
            query: this.query
        });
        if (resp) {
            console.log(resp);
            const res = JSON.parse(resp);
            this.revenue = res.revenue;
            this.ranking = res.ranking;
            this.state.isError = false;
            this.state.dataFound = true;
        } else if (err) {
            this.state.isError = true;
            this.state.dataFound = false;
            this.error = err;
            console.log(err);
        }
        this.isLoading = false;
    }
}