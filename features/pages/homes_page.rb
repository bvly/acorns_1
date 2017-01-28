require 'rspec/expectations'
require_relative '../common/common_func.rb'

class HomesPage
  include Capybara::DSL
  include RSpec::Matchers
  include CommonCapy
  def initialize()
    @search_field = find_by_css("input#citystatezip")
    @search_submit = find_by_css("button[class*='zsg-search-button'][type='submit']")
    @listing_type_menu = find_by_css("div#listings-menu-label")
    @beds_menu = find_by_css("a#beds-menu-label")
    @home_type_menu = find_by_css("a#type-menu-label")
    @more_menu = find_by_css("fieldset[class*='more-menu'] a.menu-label")
    
    @for_sale_checkbox_css = "input#fs-listings-input"
    @mmm_checkbox_css = "input#pm-mmm-input"
    @baths_menu_css = "span#baths-readout"
    @bedcount_options_css = "ul#bed-options li[data-value='%s,']"
    @bathcount_options_css = "ul#bath-options li[data-value='%s.0,']"
    @houses_checkbox_css = "input#hometype-sf-top-filters-input"
    @lotsland_checkbox_css = "input#hometype-land-top-filters-input"
    
    @apply_more_css = "a#filterSearchButton"
  end

  def verify_contains_text(text)
    expect(page).to have_content(text)
  end  

  def check_searchbar_exists
    expect(@search_field).not_to be_nil
  end

  def fill_search_field(text)
    @search_field.set(text)
  end

  def choose_foreclosures_only
    trigger_click(@listing_type_menu)
    trigger_click(find_by_css(@for_sale_checkbox_css))
    trigger_click(find_by_css(@mmm_checkbox_css))
  end

  def filter_bedrooms_min(min)
    trigger_click(@beds_menu)
    trigger_click(find_by_css(@bedcount_options_css % min))
  end

  def filter_bathrooms_min(min)
    trigger_click(@more_menu)
    trigger_click(find_by_css(@baths_menu_css))
    trigger_click(find_by_css(@bathcount_options_css % min))
  end

  def unselect_houses_lots
    trigger_click(@home_type_menu)
    trigger_click(find_by_css(@houses_checkbox_css))
    trigger_click(find_by_css(@lotsland_checkbox_css))
  end

  def more_filter_done
    trigger_click(find_by_css(@apply_more_css))
  end

  def click_search_submit
    trigger_click(@search_submit)
  end

  def verify_results_exist
    expect(page).to have_selector(:css, "div#map-result-count-message h2")
  end

  def verify_results_foreclosures(bed_min,bath_min)
    page.all(:css, "ul:first-of-type.photo-cards div.zsg-photo-card-caption").each do |listing|
      within listing do
        expect(page.find(:css, "span.zsg-photo-card-info").text).to match(/Foreclosure.*? [#{bed_min}-9][0-9]* bds.*? [#{bath_min}-9][0-9]* ba/)
      end
    end
  end

end
