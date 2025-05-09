import {Given, Then} from '@badeball/cypress-cucumber-preprocessor';

const webDocsUrl = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/throw';
Given(/^I visit web docs$/, function () {
    cy.visit(webDocsUrl)
});
Given(/^I click "([^"]*)"$/, function () {
cy.contains('Run').click()
});
Then(/^I get an error in the console$/, function () {
    // Spy on console.error
    cy.spy(console, "error").as("consoleError");

    // Assert that console.error was called at least once
    cy.get("@consoleError").should("have.been.called");
});
Given(/^I visit web docs using javascript$/, function () {
    cy.window().then((win) => {
        win.eval(`window.location.href = "${webDocsUrl}"`)
    })
});
