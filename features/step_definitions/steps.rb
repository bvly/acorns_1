Given(/^I am on the Zillow Help Center page$/) do
  @start_page = HelpCenterPage.new
end

Then(/^I will click the Sign In link$/) do
  @start_page.go_login
end

Then(/^I will fill in valid credentials and submit$/) do
  @login_page = LoginPage.new
  @login_page.fill_email_field($login_email)
  @login_page.fill_password_field($login_password)
  @login_page.submit_form
end

Then(/^I will go to the Homes section$/) do
  @start_page.go_homes
  @homes_page = HomesPage.new
end

Then(/^I should see "([^"]*)" to verify I am logged in$/) do |expected_text|
  @homes_page.verify_contains_text(expected_text)
end

Given(/^I am on the Homes section and see the search bar$/) do
  @homes_page.check_searchbar_exists
end

When(/^I search for a house in "([^"]*)" with three filters$/) do |search_text|
  $bedrooms_min = 4
  $bathrooms_min = 3

  @homes_page.fill_search_field(search_text)
  # Show foreclosures only
  @homes_page.choose_foreclosures_only

  # Filter by bedrooms min
  @homes_page.filter_bedrooms_min($bedrooms_min)

  # Unselect Houses and Lots/Land from selection
  @homes_page.unselect_houses_lots

  # Filter by bathrooms min
  @homes_page.filter_bathrooms_min($bathrooms_min)
  @homes_page.more_filter_done

  @homes_page.click_search_submit
end

Given(/^I have search results$/) do
  @homes_page.verify_results_exist
end

Then(/^each house should verify search criteria$/) do
  @homes_page.verify_results_foreclosures($bedrooms_min, $bathrooms_min)
end
