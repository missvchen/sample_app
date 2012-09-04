require 'spec_helper'

describe "StaticPages" do
  subject { page }
	
	shared_examples_for "all static pages" do
	  it { should have_selector('h1',    text: heading) }
	  it { should have_selector('title', text: full_title(page_title)) }
	end
	
	describe "Home page" do
		before { visit root_path }
		let(:heading)     { 'Sample App' }
		let(:page_title)  { '' }
		
		it_should_behave_like "all static pages"
		it { should_not have_selector('title', text: ' | Home') }
		
		describe "for signed-in users" do
	    let(:user) { FactoryGirl.create(:user) }
		  
		  describe "with 0 microposts" do
		    before do
  		    sign_in user
  		    visit root_path
		    end
		    
		    it { should have_content('0 microposts') }
		  end
		  
		  describe "with 1 micropost" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          sign_in user
          visit root_path
        end
        
        it { should have_content('1 micropost') }
		  end
		  
		  describe "with more than 1 micropost" do
  		  before do
  		    FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
  		    FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
  		    sign_in user
  		    visit root_path
  		  end
  		  
  		  it { should have_content('2 microposts') }
  		  
  		  it "should render the user's feed" do
  		    user.feed.each do |item|
  		      page.should have_selector("li##{item.id}", text: item.content)
  		      
  		      if item.user.id == user.id
  		        page.should have_link('delete', href: micropost_path(item.id))
  		        expect { click_link('delete') }.to change(Micropost, :count).by(-1)
  		      else
  		        page.should_not have_link('delete', href: micropost_path(item.id))
  		      end
  		    end
  		  end
  		  
  		  describe "pagination" do
  		    before do
  		      30.times { FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum") }
  		      visit root_path
  		    end
  		    
  		    it { should have_selector('div.pagination') }
  		  end
  		  
  		  describe "follower/following counts" do
  		    let(:other_user) { FactoryGirl.create(:user) }
  		    before do
  		      other_user.follow!(user)
  		      visit root_path
  		    end
  		    
  		    it { should have_link("0 following", href: following_user_path(user)) }
  		    it { should have_link("1 followers", href: followers_user_path(user)) }
  		  end
		  end
		end
	end

	describe "Help page" do
	  before { visit help_path }
	  let(:heading)    { 'Help' }
	  let(:page_title) { 'Help' }
	  
	  it_should_behave_like "all static pages"
	end

	describe "About page" do
	  before { visit about_path }
	  let(:heading)    { 'About Us' }
	  let(:page_title) { 'About Us' }
	  
	  it_should_behave_like "all static pages"
	end

	describe "Contact page" do
	  before { visit contact_path }
	  let(:heading)    { 'Contact' }
	  let(:page_title) { 'Contact' }
	  
	  it_should_behave_like "all static pages"
	end
	
	it "should have the right links on the layout" do
	  visit root_path
	  click_link "About"
	  page.should have_selector('title', text: full_title('About Us'))
    click_link "Help"
    page.should have_selector('title', text: full_title('Help'))
    click_link "Contact"
    page.should have_selector('title', text: full_title('Contact'))
    click_link "Home"
    page.should have_selector('title', text: full_title(''))
    click_link "Sign up now!"
    page.should have_selector('title', text: full_title('Sign up'))
    click_link "sample app"
    page.should have_selector('title', text: full_title(''))
	end
end
