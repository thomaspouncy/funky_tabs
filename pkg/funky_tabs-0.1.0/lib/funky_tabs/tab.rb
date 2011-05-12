module FunkyTabs
  module Tab
    attr_accessor :name
    attr_accessor :title
    def title
      @title||@name
    end
    attr_accessor :default_action
    def default_action
      @default_action||0
    end
    attr_accessor :actions

    def initialize(prop_hash={})
      raise FunkyTabException.new("invalid tab format #{prop_hash.inspect}") unless prop_hash.is_a?(Hash)
      raise FunkyTabException.new("missing name parameter for tab with props: #{prop_hash.inspect}") unless prop_hash.has_key?(:name)

      @actions = [FunkyTabs::TabAction.new(prop_hash[:name])]
      prop_hash.each do |key,val|
        self.send("#{key}=",val)
      end
      return self
    end

    def actions=(val)
      return @actions if val.nil?
      @actions << FunkyTabs::TabAction.new(val) and return @actions if val.is_a?(String)||val.is_a?(Hash)
      add_actions_from_array(val) and return @actions if val.is_a?(Array)
      raise FunkyTabException.new("invalid action format #{val.inspect}")
    end

    def add_actions_from_array(vals_array)
      vals_array.each do |val|
        @actions << FunkyTabs::TabAction.new(val)
      end
    end
  end
end
