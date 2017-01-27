Given(/^I am on the Zillow Help Center page$/) do
  visit 'https://zillow.zendesk.com/hc/en-us'
end

Then(/^I will click the Sign In link$/) do
  page.find(:css, "a.login").click
end

Then(/^I will fill in valid credentials and submit$/) do
  email_field = page.find(:css, "input#email")
  password_field = page.find(:css, "input#password")
  email_field.set($login_email)
  password_field.set($login_password)
  page.find(:css, "input[type='submit']").click
end

Then(/^I will go to the Homes section$/) do
  page.find("div.nav-links a", :text => "Homes").click
end

Then(/^I should see "([^"]*)" to verify I am logged in$/) do |expectedText|
  expect(page).to have_content(expectedText)
end

Given(/^I am on the Homes section and see the search bar$/) do
  expect(page).to have_selector(:css, "input#citystatezip")
end

When(/^I search for a house in "([^"]*)" with three filters$/) do |search_text|
  $bedrooms_min = 4
  $bathrooms_min = 3

  search_field = page.find(:css, "input#citystatezip")
  search_field.set(search_text)
  # Show foreclosures only
  page.find(:css, "div#listings-menu-label").trigger('click')
  page.find(:css, "input#fs-listings-input").trigger('click')
  page.find(:css, "a#beds-menu-label").trigger('click')
  # Filter by bedrooms min
  page.find(:css, "ul#bed-options li[data-value='%s,']" % $bedrooms_min).trigger('click')
  page.find(:css, "a#type-menu-label").trigger('click')
  # Unselect Houses and Lots/Land from selection
  page.find(:css, "input#hometype-sf-top-filters-input").trigger('click')
  page.find(:css, "input#hometype-land-top-filters-input").trigger('click')
  # Filter by bathrooms min
  page.find(:css, "fieldset[class*='more-menu'] a.menu-label").trigger('click')
  page.find(:css, "span#baths-readout").trigger('click')
  page.find(:css, "ul#bath-options li[data-value='%s.0,']" % $bathrooms_min).trigger('click')
  page.find(:css, "a#filterSearchButton").trigger('click')
  page.find(:css, "button[class*='zsg-search-button'][type='submit']").trigger('click')
end

Given(/^I have search results$/) do
  expect(page).to have_selector(:css, "div#map-result-count-message h2")
end

Then(/^each house should verify search criteria$/) do
  page.all(:css, "ul:first-of-type.photo-cards div.zsg-photo-card-caption").each do |listing|
    within listing do
      expect(page.find(:css, "span.zsg-photo-card-info").text).to match(/Foreclosure.*? [#{$bedrooms_min}-9][0-9]* bds.*? [#{$bathrooms_min}-9][0-9]* ba/)
    end
  end
end
