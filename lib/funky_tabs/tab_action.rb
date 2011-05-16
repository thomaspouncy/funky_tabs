require 'funky_tabs'
require 'rails'

module FunkyTabs
  class TabAction
    attr_accessor :name
    attr_accessor :content_path

    def initialize(hash_or_string)
      return set_attrs({:name=>hash_or_string}) if hash_or_string.is_a?(String)
      return set_attrs(hash_or_string) if hash_or_string.is_a?(Hash)
      raise FunkyTabsException.new("invalid action parameters #{hash_or_string.inspect}")
    end

    def set_attrs(attrs_hash)
      raise FunkyTabsException.new("invalid action attrs format #{attrs_hash.inspect}") unless attrs_hash.is_a?(Hash)
      attrs_hash.each do |key,val|
        self.send("#{key}=",val)
      end
      return self
    end
  end
end
