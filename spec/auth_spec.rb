require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end 

  it "has a new user page" do
    page.should have_content "Sign Up"
  end

  feature "signing up a user" do
    
    it "shows username on the homepage after signup" do
      sign_up("johnbitch")
      expect(page).to have_content "johnbitch"
    end
  end

end

feature "logging in" do
  before do
    visit "/users/new"
    sign_up("johnbitch")
    visit "/session/new"    
  end 

  it "shows username on the homepage after login" do
    log_in("johnbitch")
    expect(page).to have_content "johnbitch"
  end

end

feature "logging out" do 
  before :each do
    sign_up("johnbitch")
  end

  it "begins with logged out state" do
    log_out
    visit "/users"
    expect(page).to have_content "Log In"
  end

  it "doesn't show username on the homepage after logout" do
    log_out
    visit "/goals"
    expect(page).not_to have_content "johnbitch"
  end

end



