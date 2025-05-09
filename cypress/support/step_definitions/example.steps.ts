import {Given, When, Then} from '@badeball/cypress-cucumber-preprocessor';

Given("I open Kitchen Sink", () => {
    cy.visit('https://example.cypress.io');
});
Then("I see the title {string}", (title: string) => {
    cy.contains('h1', title).should('be.visible');
});
Given(/^I throw an error$/, function () {
    throwError();
});
Given(/^I change the origin$/, function () {
    cy.visit('https://github.com');
});
Given(/^I throw an error at another origin$/, function () {
    cy.origin('https://github.com', () => {
        cy.window().then((win) => {
            win.eval('throw new Error("This is a custom JavaScript error")')
        })
    })
});

function throwError() {
    cy.window().then((win) => {
        win.eval('throw new Error("This is a custom JavaScript error")')
    })
}

When(/^I click on the GitHub link$/, function () {
    cy.contains('GitHub').click();
});
