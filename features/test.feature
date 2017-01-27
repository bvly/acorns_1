Feature: Zillow assignment for Acorns
 
Scenario: Sign in to Zillow, search for houses with 3 filters, verify results
 Given I am on the Zillow Help Center page
 Then I will click the Sign In link
 Then I will fill in valid credentials and submit
 Then I will go to the Homes section
 Then I should see "My Zillow" to verify I am logged in
 Given I am on the Homes section and see the search bar
 When I search for a house in "Irvine, CA" with three filters
 Given I have search results
 Then each house should verify search criteria
