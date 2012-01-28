require 'spec_helper.rb'

feature 'testing oauth' do
  before(:each) do
    @client = double("Twitter::Client")
    @user = double("Twitter::User")
    Twitter.stub!(:configure).and_return true
    Twitter::Client.stub!(:new).and_return(@client)
    @client.stub!(:current_user).and_return(@user)
    @user.stub!(:name).and_return("Tester")
  end

  scenario 'twitter' do    
    visit root_path
    login_with_oauth
    page.should have_content("Pages#home")
  end
end
