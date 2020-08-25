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
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)
      visit posts_path
      expect(page).to  have_content(/Post1|Post2/)
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
      @post = FactoryGirl.create(:post)
    end

    it "can be reached by clicking on the edit button on the index page" do
      visit posts_path

      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it "can be edited" do
      visit edit_post_path(@post)
      
      fill_in "post[date]",	with: Date.today
      fill_in "post[rationale]",	with: "updated text"
      
      click_on "Save"

      expect(page).to have_content('updated text')  

    end
    
  end
  
end