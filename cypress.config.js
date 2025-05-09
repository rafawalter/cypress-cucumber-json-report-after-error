const { defineConfig } = require("cypress");
const createBundler = require("@bahmutov/cypress-esbuild-preprocessor");
const {createEsbuildPlugin} = require("@badeball/cypress-cucumber-preprocessor/esbuild");
const {addCucumberPreprocessorPlugin} = require("@badeball/cypress-cucumber-preprocessor");
const cypressOnFix = require("cypress-on-fix")


module.exports = defineConfig({
  e2e: {
    specPattern: "cypress/e2e/**/{*.cy.ts,*.feature}",
    reporter:
        "@badeball/cypress-cucumber-preprocessor/dist/subpath-entrypoints/pretty-reporter.js",
    async setupNodeEvents(cypressOn, config) {
      const on = cypressOnFix(cypressOn);
      await addCucumberPreprocessorPlugin(on, config);
      on(
          "file:preprocessor",
          createBundler({
            plugins: [createEsbuildPlugin(config)],
          }),
      );
      return config;
    },
  },
});
