require 'rails_helper'

describe 'As a visitor' do
  it 'creates a new user when logging in with Spotify for the first time', :vcr do
    
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      :provider => 'spotify',
      :uid => '1235996540',
      :extra => {:raw_info => {display_name: 'Linda Le'}},
      :credentials => {token: ENV['LINDA_TOKEN'], refresh_token: ENV['LINDA_REFRESH_TOKEN']}
    })

    visit '/'

    click_button "Lettuce Begin (Log in with Spotify)"

    user = User.last

    expect(current_path).to eq('/recommendations/new')
    expect(page).to have_content("Welcome, #{user.display_name}!")
    expect(user.token).to eq(ENV['LINDA_TOKEN']) 
  end
end
