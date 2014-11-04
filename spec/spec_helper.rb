ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'factory_girl'
require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

 
  config.mock_with :rspec do |mocks|
  
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods

end


def sign_up(username)
  visit "/users/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

def log_in(username)
  visit "/session/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Log In'
end

def log_out
  click_button 'Log Out'
end