require 'rails_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
  
  it 'displays a login button when not logged in' do
    visit('/')
    expect(find('.jumbotron')).to have_css('.login')
    expect(find('.navbar')).to have_css('.login')
  end
  
  it 'displays a logout button when not logged in' do
    login
    expect(find('.navbar')).to have_css('.logout')
  end
  
  def login
    visit('/')
    find('.navbar .login').click
    fill_in 'name', :with => 'John Doe'
    fill_in 'email', :with => 'john@doe.com'
    click_button 'Sign In'
  end
end