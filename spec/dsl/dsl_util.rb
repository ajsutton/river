# -*- encoding : utf-8 -*-
require 'securerandom'

module DslUtil

  def parse_params(supplied, options)
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
