module FunkyTabs
  module TabAction
    attr_accessor :name
    attr_accessor :content_source
    def content_source
      @content_source||"tabs/#{name}"
    end

    def initialize(hash_or_string)
      raise FunkyTabException.new("invalid action format #{val.inspect}") unless hash_or_string.is_a?(String)||hash_or_string.is_a?(Hash)
      self.name = hash_or_string and return self if hash_or_string.is_a?(String)
      hash_or_string.each do |key,val|
        self.send("#{key}=",val)
      end
      return self
    end
  end
end
