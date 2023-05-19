@Smoke @Regression
Feature: Random Account Creation

  Background: Setup Test generated token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    # Call Java class and Method with Karate
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
     And request
  """
  {
  "email": "#(autoEmail)",
  "firstName": "Fardeen",
  "lastName": "Amin",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Software Engineer",
  "dateOfBirth": "1989-01-01",
}
  """
     When method post
  Then status 201
  And print response
  And assert response.email == autoEmail
