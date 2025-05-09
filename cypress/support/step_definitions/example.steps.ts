import { Given, Then } from '@badeball/cypress-cucumber-preprocessor';

Given("I open the homepage", () => {
    cy.visit('https://example.cypress.io');
});

Then("I see the title {string}", (title: string) => {
    cy.contains('h1', title).should('be.visible');
});
Given(/^I throw an error$/, function () {
    cy.window().then((win) => {
        win.eval('throw new Error("This is a custom JavaScript error")')
    })
});
