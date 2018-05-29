require 'rails_helper'

RSpec.feature "Visitor logs in", type: :feature, js: true do

  # SETUP
  before :each do
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email
    @password = 'password'
    User.create!(
      first_name: @first_name,
      last_name: @last_name,      
      email: @email,
      password: @password,
      password_confirmation: @password
    )
  end
  
  scenario "They sign in" do
    # ACT
    visit root_path
    click_on 'Login'
    sleep 2
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_on 'Sign in'
    sleep 2

    # DEBUG
    # save_screenshot
    
    # VERIFY
    expect(page).to have_text @first_name
  end
end
