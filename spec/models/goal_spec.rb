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
  let(:goal_a) { FactoryGirl.create(:goal) }
  
  before :each do
    sign_up("ray_charles")
    goal_a.user = User.find_by_username("ray_charles")
    goal_a.save
    visit '/goals'
  end
  
  it "can see own goals" do
    expect(page).to have_content(goal_a.title)
  end
  
  it "cannot see others' private goals" do
    sign_up("stevie_wonder")
    goal_a.restricted = true
    goal_a.save
    expect(page).not_to have_content(goal_a.title)
  end
  
  it "can see its own private goals" do
    goal_a.restricted = true
    goal_a.save
    expect(page).to have_content(goal_a.title)
  end
end

feature "udpating goals" do
  let(:goal_a) { FactoryGirl.create(:goal) }
  
  before :each do
    sign_up("rashida_jones")
    goal_a.user = User.find_by_username("rashida_jones")
    goal_a.save
    visit "/goals/#{goal_a.id}/edit"
  end
  
  it "has an edit goal page" do
    expect(page).to have_content("Edit Goal")
  end 
  
  it "will reject an incomplete form" do
    fill_in "Title", with: ""
    click_button "Submit"
    expect(page).to have_content("can't be blank")
  end
  
  it "will redirect to show page upon successful completion" do
    fill_in "Title", with: "Bobby Flay" 
    fill_in "Body", with: "master chef"
    click_button "Submit"
    expect(page).to have_content("Bobby Flay")
  end
end

feature "delete goals" do
  let(:goal_a) { FactoryGirl.create(:goal) }
  
  before :each do 
    sign_up("calvin_broadus")
    goal_a.user = User.find_by_username("calvin_broadus")
    goal_a.save
    visit "/goals/#{goal_a.id}"
  end
  
  it "has a delete button if the goal belongs to the current user" do
    expect(page).to have_button("Delete Goal")
  end
  
  it "does not allow deleting a goal that isn't yours" do
    sign_up("shawn_carter")
    visit "/goals/#{goal_a.id}"
    expect(page).not_to have_button("Delete Goal")  
  end
  
  it "redirects to the goals index upon successful deletion" do
    click_button "Delete Goal"
    save_and_open_page
    expect(page).to have_content("Index")
  end

end
  
  
  
  
    
    