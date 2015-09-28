# -*- encoding : utf-8 -*-
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
require 'securerandom'
require 'require_all'
require_all 'spec/dsl'

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
      @objects[key] ||= yield(SecureRandom.hex(8))
    end
    
    def get(key)
      @objects[key]
    end
  end
end



module Dsl
  def home
    @homeDriver ||= DslUtil::HomeDriver.new(DslUtil::AliasedObjectStore.new)
  end

  def setup
    @setupDriver ||= DslUtil::SetupDriver.new(DslUtil::AliasedObjectStore.new, home)
  end

  def people
    @peopleDriver ||= DslUtil::PeopleDriver.new(DslUtil::AliasedObjectStore.new)
  end
  
  def admin
    @adminDriver ||= DslUtil::AdminDriver.new
  end
end
