require 'spec_helper'

describe "pages/contact.html.erb" do
  
  it 'should have text formated as h1' do
    render
    rendered.should have_selector('h1')
  end

end
