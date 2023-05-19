@Smoke @Regression
Feature: Get Account API

  #Scenarion 9:
  #Endpoint = /api/accounts/get-account
  #For primaryPersonId = One of your accounts already created
  #Make sure email address is correct
  # And header authorization = "Bearer"  + response.token
  # Make sure email address is correct
  # Note: * def is used for all (Givne, When and then) and we are defining variable for future usage
  Background: API Setup steps
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get Acount API call with existing account
    Given path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 6726
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 6726
    And assert response.primaryPerson.email == "fardeenqazizada@gmail.com"
    
    
    
