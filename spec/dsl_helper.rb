require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

require 'dsl/home_helper'

module Dsl
  def Dsl.params(supplied, options = {})
    supplied ||= {}
    result = {}
    options.each {|k,v| result[k] = supplied[k] || v}
    result
  end

  $home = HomeDriver.new
end