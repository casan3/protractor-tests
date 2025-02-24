exports.config = {
    capabilities: {
        browserName: "chrome",
        chromeOptions: {
            args: ["--disable-dev-shm-usage", "--no-sandbox"],
        }
    },
    specs: ['specs/superCalculatorTest.js'],
    onPrepare: function(){ browser.ignoreSynchronization = true; },
};