# Scenario 10:
#Endpoint = /api/accounts/add-primary-account.
#This Endpoint is to create new account and data will store in primary_person table.
#Status Code = 201
#Notes:
#duplicate email not accepted
#For Gender and maritalStatus You have to use the Predefined values.
#Once you create Account validate database and take screenshot.
#FirstName and LastName should be your name.
#In Request body we don't need id and isNew field (you can remove them).
@Regression
Feature: Create Account Test

  Background: API Test setup
    #callonce read is karate step to execute and read another feature file.
    #the result of callonce can be stored in to new Variable using def step
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "Alex@yahoo.com",
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
    And assert response.email == "Alex@yahoo.com"
    #delete created account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
