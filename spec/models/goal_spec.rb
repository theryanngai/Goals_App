require 'rails_helper'

feature "create goal" do
  before :each do
    sign_up("elton_john")
    visit '/goals/new'
  end
  
  it "has a new goal page" do
    expect(page).to have_content "New Goals!"
  end
  
  it "does not allow empty fields" do
    fill_in "Title", with: "a hot goal"
    click_button "Submit"
    expect(page).to have_content "can't be blank"
  end
  
  it "takes users to goal#show page after submission" do
    fill_in "Title", with: "a hot goal"
    fill_in "Body", with: "a hot body"
    click_button "Submit"
    expect(page).to have_content "a hot goal"
  end
end

feature "seeing goals" do
  before :each do
    sign_up("elton_john")
    goal = FactoryGirl.create(:goal)
    goal.user = User.find_by_username("elton_john")
    visit '/goals'
  end
  
  it "can see own goals" do
    expect(page).to have_content(goal.title)
  end
  
end
    
    