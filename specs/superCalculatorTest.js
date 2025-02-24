const { $, browser } = require("protractor");
let url = 'https://juliemr.github.io/protractor-demo/';

describe('Super Calculator Test suite', () => {
    it('Verify Adding two Integers', () => {
        browser.get(url);
        browser.sleep(2000);
        element(by.model('first')).sendKeys(2);
        element(by.model('second')).sendKeys(5);
        element(by.id('gobutton')).click();
        browser.sleep(2000);
        expect(element(by.className('ng-binding')).getText()).toEqual('7');
        browser.sleep(2000);
    });
});