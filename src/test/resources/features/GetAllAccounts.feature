@Regression
Feature: Get All Accounts

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    * def generatedToken = result.response.token

  Scenario: Get all the accounts
    Given path "/api/accounts/get-all-accounts"
    Then header Authorization = "Bearer " + generatedToken
    Then method get
    And status 200
    And print response
