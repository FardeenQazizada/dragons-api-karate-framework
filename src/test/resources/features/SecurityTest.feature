@Smoke @Regression
Feature: API Test Security Section

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Create token with valid username and valid password
    # Prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    # Send request
    When method post
    # Validating response
    Then status 200
    And print response

  Scenario: Validate Token with Invalid username
    And request {"username": "WrongUser","password": "tek_supervisor"}
    # Send request
    When method post
    # Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: 
    And request {"username": "supervisor","password": "tek_somthing"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
