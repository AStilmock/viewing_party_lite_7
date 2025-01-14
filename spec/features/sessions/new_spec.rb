require "rails_helper"

RSpec.describe "User Registration Page" do
  describe "Register new User Form" do
    it "page has form for a new user" do
      visit "/"
      click_button "Create New User"
      expect(current_path).to eq new_session_path
      expect(page).to have_field("email")
      expect(page).to have_field("name")
      expect(page).to have_field("password")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_button("Register")
    end

    it "user created successfully" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :name, with: "Email"
      fill_in :password, with: "secretpassword"
      fill_in :password_confirmation, with: "secretpassword"
      click_button "Register"
      
      user = User.last
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content("#{user.name}'s Dashboard")
    end

    it "not matching passwords" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :name, with: "Email"
      fill_in :password, with: "secretpassword"
      fill_in :password_confirmation, with: "notsecretpassword"
      click_button "Register"
      
      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Invalid email or password")
    end

    it "missing password_confirmation" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :name, with: "Email"
      fill_in :password, with: "secretpassword"
      click_button "Register"
      
      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Invalid email or password")
    end

    it "missing password" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :name, with: "Email"
      fill_in :password_confirmation, with: "secretpassword"
      click_button "Register"
      
      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Invalid email or password")
    end

    it "missing name" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :password, with: "secretpassword"
      fill_in :password_confirmation, with: "secretpassword"
      click_button "Register"

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Invalid email or password")
    end

    it "missing email" do
      visit new_session_path
      fill_in :name, with: "Email"
      fill_in :password, with: "secretpassword"
      fill_in :password_confirmation, with: "secretpassword"
      click_button "Register"

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Invalid email or password")
    end

    it "user is remembered in session after registering" do
      visit new_session_path
      fill_in :email, with: "email@email.com"
      fill_in :name, with: "Email"
      fill_in :password, with: "secretpassword"
      fill_in :password_confirmation, with: "secretpassword"
      click_button "Register"

      @user = User.last
      expect(current_path).to eq user_path(@user.id)
      expect(page).to have_link "Return to Movie Viewing Party Landing Page"
      click_link "Return to Movie Viewing Party Landing Page"
      expect(current_path).to eq root_path
      
      within "#title" do
        expect(page).to have_button "Logout"
        expect(page).to_not have_button "I already have an account"
      end
    end
  end
end