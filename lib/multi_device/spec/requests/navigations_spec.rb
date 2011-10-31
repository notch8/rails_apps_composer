require 'spec_helper'

describe "Navigations" do
  describe "GET navigation links" do
    it "should have a contacts page at /contact" do
      get '/contact'
      response.status.should be(200)
    end
    it "should have an about page at /about" do
      get '/about'
      response.status.should be(200)
    end
  end
end
