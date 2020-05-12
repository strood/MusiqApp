require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Create User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email:', :with => "testy@test.com"
      fill_in 'Password:', :with => "password"
      click_on "Create User"
    end

    scenario "redirects to sign in page after signup, awaiting user authentication" do
      expect(page).to have_content "Log In"
      expect(current_path).to eq("/session/new")
    end

    feature "with an invalid user" do
      before(:each) do
        visit new_user_url
        fill_in "Email:", :with => "testy@test.com"
        click_on "Create User"
      end

      scenario "re-renders the sign up page if signup failed" do
        expect(page).to have_content "Create User"
        expect(current_path).to eq("/users/new")
      end

    end

  end

end
