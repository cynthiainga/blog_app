require 'rails_helper'

RSpec.describe 'Post', type: :system do
  context 'Index page' do
    before(:each) do
      @users = User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio',
                            email: 'test@domain.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Integration test', text: 'Exciting!')
      @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Test Comment')
      Like.create(author_id: @user.id, post_id: @post.id)

      visit user_post_path(@user.id, @post.id)
    end

    it "should display the user's photo" do
      expect(page).to have_css('img')
    end

    it "should display the user's name" do
      expect(page).to have_content(@user.name)
    end

    it 'should show post title' do
      expect(page).to have_content(@post.title)
    end

    it "should show the post's body." do
      expect(page).to have_content(@post.text)
    end

    it 'should show the first comments on a post' do
      expect(page).to have_content('Test Comment')
    end

    it 'should display the number of comments the user has written' do
      expect(page).to have_content('Number of comments:')
      expect(page).to have_content(@user.comments_counter)
    end

    it 'should display how many comments a post has.' do
      expect(page).to have_content('Number of comments:')
      expect(page).to have_content(@post.comments_count)
    end

    it 'should display how many likes a post has.' do
      expect(page).to have_content('Number of likes:')
      expect(page).to have_content(@post.likes_count)
    end

    it 'should show see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('See All Posts')
    end

    it "should redirect to the post's show page when I click on a post" do
      click_link(@post.title)
      expect(current_path).to eql(user_post_path(@user.id, @post.id))
    end
  end
end
