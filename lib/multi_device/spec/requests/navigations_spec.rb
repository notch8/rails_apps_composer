require 'spec_helper'

describe "Navigations" do

  describe "GET navigation links" do

    it "should have a home page at /" do
      get '/'
      response.status.should be(200)
      response.should have_selector('title', :content => "Home")
    end

    it "should have an about page at /about" do
      get '/about'
      response.status.should be(200)
      response.should have_selector('title', :content => "About")
    end

    it "should have a contacts page at /contact" do
      get '/contact'
      response.status.should be(200)
      response.should have_selector('title', :content => "Contact")
    end

  end # Get navigation links

end # Navigations
