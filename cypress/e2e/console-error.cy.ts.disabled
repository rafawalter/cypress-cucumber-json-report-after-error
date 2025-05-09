describe('console error', () => {
  it('Visit the homepage', () => {
    cy.visit('https://example.cypress.io')
  })
  it('throws an error', () => {
    cy.visit('https://example.cypress.io')

    cy.window().then((win) => {
      win.eval('throw new Error("This is a custom JavaScript error")')
    })
  })
})
