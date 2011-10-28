require 'spec_helper'

describe 'pages/home.html.erb' do

  it 'should have text formated as h1' do
    render 
    rendered.should have_selector('h1')
  end

  it 'should have text formated as h2' do
    render 
    rendered.should have_selector('h2')
  end

  it 'should have text formated as h3' do
    render 
    rendered.should have_selector('h3')
  end

end
