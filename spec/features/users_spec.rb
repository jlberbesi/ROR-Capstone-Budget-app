require 'rails_helper'

RSpec.describe 'new users session', type: :feature do
  it 'displays the correct content when registration' do
    visit new_user_registration_path

    expect(page).to have_content('REGISTER')
  end

  it 'displays the correct selector when registration' do
    visit new_user_registration_path

    expect(page).to have_selector('input.new-test')
  end

  it 'displays the correct content when initiating session' do
    visit user_session_path

    expect(page).to have_content('LOGIN')
  end

  it 'displays the correct selector when initiating session' do
    visit user_session_path

    expect(page).to have_selector('input.devise-btn')
  end
end
