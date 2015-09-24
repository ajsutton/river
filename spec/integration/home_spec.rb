require 'rails_helper'
require 'dsl_helper'

describe 'home page' do
  it 'displays a login button when not logged in' do
    $home.verify_login_present
  end
  
  it 'displays a logout button when not logged in' do
    $home.login
    $home.verify_logout_present
  end
end