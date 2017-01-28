require_relative '../common/common_func.rb'

class HelpCenterPage
  include Capybara::DSL
  include CommonCapy

  def initialize
    visit 'https://zillow.zendesk.com/hc/en-us'
    @login_link = find_by_css("a.login")
    @homes_link = find_by_css_and_text("div.nav-links a", "Homes")
  end
  
  def go_login
    @login_link.click
  end

  def go_homes
    @homes_link.click
  end

end
