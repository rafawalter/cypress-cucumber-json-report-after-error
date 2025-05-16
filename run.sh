#!/bin/bash

yarn cypress run
cat ./target/cucumber-reports/cucumber-report.json