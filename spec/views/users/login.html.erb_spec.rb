require 'rails_helper'

RSpec.describe 'login page', type: :system do
  describe 'login page' do
    it 'I can see the username and password inputs and the Submit button.' do
      visit new_user_session_path
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_button(type: 'submit')
    end
  end
end
