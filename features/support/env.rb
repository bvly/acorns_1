require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'yaml'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
options = {js_errors: false,window_size:[1280,760]}
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

config = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")
$login_email = config['login_email']
$login_password = config['login_password']
