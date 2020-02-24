require 'rails_helper'

describe 'As a user logged in with spotify' do
  describe 'when I enter mood and cuisine' do
    it 'returns recommendation results' do
      user = create(:user, token: ENV['JOMAH_TOKEN'], refresh_token: ENV['JOMAH_REFRESH'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/recommendations/new'

      select "Italian", from: :cuisine
      select "Party", from: :mood

      click_button 'Harvest Your Beets!'

      expect(current_path).to eq('/recommendations')

      expect(page).to have_selector '#mood'
      expect(page).to have_selector '#cuisine'
      expect(page).to have_selector '#combo'
    end
  end
end