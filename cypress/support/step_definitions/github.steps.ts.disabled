import {Then} from "@badeball/cypress-cucumber-preprocessor";

Then(/^I see the GitHub icon$/, function () {
    cy.origin('https://github.com', () => {
        cy.get('.octicon ')
    })
});
