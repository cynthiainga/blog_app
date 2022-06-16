require 'rails_helper'

RSpec.describe 'Post', type: :system do
  context 'show page' do
    before(:each) do
      @users = [User.create!(name: 'Candy', photo: '#photo_candy', bio: 'bio', email: 'test@domain.com')]
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Integration test', text: 'Exciting!')
      @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Test Comment')
      Like.create(author_id: @user.id, post_id: @post.id)

      visit user_post_path(@user.id, @post.id)
    end

    it "should show post's title" do
      expect(page).to have_content(@post.title)
    end

    it "should show post's author" do
      expect(page).to have_content(@post.author.name)
    end

    it 'should show the number of comments' do
      expect(page).to have_content('Comments 1')
    end

    it 'should show the number of likes' do
      expect(page).to have_content('Likes 0')
    end

    it 'should show the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'should show the username of each commentor' do
      expect(page).to have_content(@comment.author.name)
    end

    it 'should show the text comment each commentor' do
      expect(page).to have_content(@comment.text)
    end
  end
end
