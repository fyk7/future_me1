require 'rails_helper'

RSpec.feature "Homes", type: :feature do

  scenario "homeへページ遷移できるか" do
    visit root_path
    click_link "Home"

    expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
  end

  scenario "aboutへページ遷移できるか" do
    visit root_path
    click_link "About"

    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end

  scenario "helpへページ遷移できるか" do
    visit root_path
    click_link "Help"

    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end

  scenario "Sign upへページ遷移できるか" do
    visit root_path
    click_on "Sign up now!"

    expect(page).to have_content("Sign up")
  end
end
