require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'Index page' do
    before(:each) do
      @users = User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio',
                            email: 'test@domain.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Integration test', text: 'Exciting!')
      Comment.create(author_id: @user.id, post_id: @post.id, text: 'Test Comment')
      Like.create(author_id: @user.id, post_id: @post.id)

      visit user_post_path(@user.id, @post.id)
    end

    it "should display the user's photo" do
      expect(page).to have_css('img')
    end

    it "should display the user's name" do
      expect(page).to have_content(@user.name)
    end

    it 'should display the number of posts the user has written' do
      expect(page).to have_content('Number of posts:')
      expect(page).to have_content(@user.posts_counter)
    end
  end
end
