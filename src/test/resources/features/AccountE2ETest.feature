#End 2 End Account Testing
#Create an Account
# Add Address
# Add Phone
# Add Car
# Get Account
Feature: End To End Account Testing
  
   

  Scenario: Verify User can create an account and adding some properties to it
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    And path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      
      {
      
      "email": "#(autoEmail)",
      
      "firstName": "Fardeen",
      
      "lastName": "Qazizada",
      
      "title": "Mr.",
      
      "gender": "MALE",
      
      "maritalStatus": "SINGLE",
      
      "employmentStatus": "Software Developer",
      
      "dateOfBirth": "1988-01-01",
      
      "new": true
      
      }

      """
    When method post
    Then status 201
    And print response
    * assert response.email == autoEmail
    * def id = response.id
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      
      {
      
      "addressType": "Home",
      
      "addressLine1": "123 something",
      
      "city": "Woodbridge",
      
      "state": "Virginia",
      
      "postalCode": "22191",
      
      "countryCode": "+1",
      
      "current": true
      
      }

      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      
      {
      
      "phoneNumber": "12345",
      
      "phoneExtension": "2255",
      
      "phoneTime": "Any Time",
      
      "phoneType": "Home"
      
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == "12345"
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    And request
      """
      
      {
      
      "make": "Ford",
      
      "model": "Mustang",
      
      "year": "2023",
      
      "licensePlate": "VA"
      
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.make == "Ford"
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = id
    When method get
    Then status 200
    And print response
