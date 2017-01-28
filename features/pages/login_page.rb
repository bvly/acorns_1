require_relative '../common/common_func.rb'

class LoginPage
  include Capybara::DSL
  include CommonCapy
  
  def initialize
    @email_field = find_by_css("input#email")
    @password_field = find_by_css("input#password")
    @submit_button = find_by_css("input[type='submit']")
  end
  
  def fill_email_field(email)
    @email_field.set(email)
  end

  def fill_password_field(password)
    @password_field.set(password)
  end
  
  def submit_form
    @submit_button.click
  end

end
