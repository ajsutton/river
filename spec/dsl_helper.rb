require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'securerandom'

require 'dsl/home_helper'

module DslUtil
  def DslUtil.params(supplied, options = {})
    supplied ||= {}
    result = {}
    options.each {|k,v| result[k] = supplied[k] || v}
    result
  end
  
  class AliasedObjectStore
    def initialize
      @objects = {}
    end
    
    def get_or_create(key, &block)
      @objects[key] ||= yield(SecureRandom.urlsafe_base64(20))
    end
  end
end


module Dsl
  users = DslUtil::AliasedObjectStore.new
  
  @homeDriver = DslUtil::HomeDriver.new(users)
  def Dsl.home
    @homeDriver
  end
end