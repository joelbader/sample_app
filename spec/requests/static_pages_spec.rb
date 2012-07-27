require 'spec_helper'

#describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
describe "Static Pages" do

  subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector('title', text: full_title('')) }
  end
  describe "Help page" do
    before { visit help_path }
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end
  describe "About page" do
    it "should have the content 'About'" do
      visit about_path
      page.should have_content('About')
    end
  end
  
  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end
    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', text: 'Sample App | Contact')
    end
    
  end

end
