require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end
  describe 'index' do
    before do
      visit posts_path
    end
    
    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has content' do
      expect(page).to  have_content(/Post/)
    end

    it 'has list of post' do
      post_one = Post.create!(date: Date.today, rationale: "Post1", user_id: @user.id)
      post_two = Post.create!(date: Date.today, rationale: "Post2", user_id: @user.id)
      visit posts_path
      expect(page).to  have_content(/Post1|Post2/)
    end

    it "has a scope so that post creators can only see their posts" do
      post1 = Post.create!(date: Date.today, rationale: "rationale content1", user_id: @user.id)
      post2 = Post.create!(date: Date.today, rationale: "rationale content2", user_id: @user.id)

      other_user = User.create(email: "other_user@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Foo", last_name: "Bar")
      post_from_another_user = Post.create!(date: Date.today, rationale: "other rationale content", user_id: other_user.id)
      
      visit posts_path
      expect(page).to_not have_content(/other rationale content/)  
    end
    
  end
  describe "new" do
    it "can navigate to new from the tabs" do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe "delete" do
    it "can be delete" do
      @post = Post.create!(date: Date.today, rationale: "Post1", user_id: @user.id)
      visit posts_path
      
      click_link("delete_post_#{@post.id}_from_index")
      expect(page.status_code).to eq(200)
      
    end
  end
  
  
  describe 'creation' do
    before do
      visit new_post_path
    end 
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in "post[date]",	with: Date.today
      fill_in "post[rationale]",	with: "sometext"
      
      click_on "Save"

      expect(page).to have_content('sometext')  
    end

    it 'have user associated with' do
      fill_in "post[date]",	with: Date.today
      fill_in "post[rationale]",	with: "user association"
      
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq('user association')  
    end
  end

  describe "edit" do
    before do
      @edit_user = User.create(email: "edit_test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Foo", last_name: "Bar")
      login_as(@edit_user, :scope => :user)
      @edit_post = Post.create!(date: Date.today, rationale: "rationale content", user_id: @edit_user.id)
    end

    it "can be edited" do
      visit edit_post_path(@edit_post)
      
      fill_in "post[date]",	with: Date.today
      fill_in "post[rationale]",	with: "updated text"
      
      click_on "Save"

      expect(page).to have_content('updated text')  

    end

    it "can be edited by a non authorized user" do
      logout(:user)

      non_authorized_user = FactoryGirl.create(:no_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@edit_post)

      expect(page.current_path).to eq(root_path)  
    end
    
  end
  
end