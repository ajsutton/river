module Dsl
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'dsl/home_helper'

  $home = HomeDriver.new
end