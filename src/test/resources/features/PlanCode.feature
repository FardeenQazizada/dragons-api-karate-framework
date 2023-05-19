@Regression
Feature: Plan Code Feature
  
  Backgroung: Setup api tests and get token
  * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get all plan code api
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert reponse[0].planExpired == false
    And assert reponse[1].planExpired == false
    And assert reponse[2].planExpired == false
    And assert reponse[3].planExpired == false
