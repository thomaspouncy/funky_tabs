require 'funky_tabs'
require 'rails'

module FunkyTabs
  class Tab
    attr_accessor :name
    attr_accessor :title
    attr_accessor :default_tab_action
    attr_accessor :tab_actions

    #default values for attrs
    def title
      @title ||= name
    end
    def tab_actions
      @tab_actions ||= []
    end
    def default_tab_action
      @default_tab_action ||= add_tab_action("index")
    end

    #tab methods
    def initialize(hash_or_string)
      # initialize default tab action unless the user has provided one of their own
      default_tab_action unless hash_or_string.is_a?(Hash) && hash_or_string.has_key?(:default_tab_action)

      return set_attrs({:name=>hash_or_string}) if hash_or_string.is_a?(String)
      return set_attrs(hash_or_string) if hash_or_string.is_a?(Hash)
      raise FunkyTabsException.new("invalid tab parameters #{hash_or_string.inspect}")
    end

    def set_attrs(attrs_hash)
      raise FunkyTabsException.new("invalid tab attrs format #{attrs_hash.inspect}") unless attrs_hash.is_a?(Hash)
      # in order to make sure that default action gets called after actions have been instantiated, sort hash keys
      attrs_hash.keys.sort.each do |key|
        self.send("#{key.to_s}=",attrs_hash[key])
      end
      return self
    end

    # when setting a default action, create and link to action if doesnt exist
    def default_tab_action=(sym_or_string)
      @default_tab_action = add_tab_action(sym_or_string)
    end

    # Right now this method just appends actions, it doesn't delete them.
    def tab_actions=(array_or_string_or_hash)
      return add_tab_action(array_or_string_or_hash) if array_or_string_or_hash.is_a?(String)||array_or_string_or_hash.is_a?(Hash)
      return add_tab_actions(array_or_string_or_hash) if array_or_string_or_hash.is_a?(Array)
      raise FunkyTabsException.new("invalid actions format #{array_or_string_or_hash.inspect}")
    end

    def find_tab_action(tab_action_or_string_or_hash)
      return nil if tab_action_or_string_or_hash.nil? || tab_actions.blank?
      tab_action_or_string_or_hash = tab_action_or_string_or_hash.to_s if tab_action_or_string_or_hash.is_a?(Symbol)
      return tab_actions.index {|action| action.name.downcase == tab_action_or_string_or_hash.downcase} if tab_action_or_string_or_hash.is_a?(String)
      return tab_actions.index {|action| action.name == tab_action_or_string_or_hash[:name] } if tab_action_or_string_or_hash.is_a?(Hash)
      return tab_actions.index(tab_action_or_string_or_hash) if tab_action_or_string_or_hash.is_a?(FunkyTabs::TabAction)
      raise FunkyTabsException.new("Dont know how to find an action with #{tab_action_or_string_or_hash.inspect}")
    end

    def add_tab_action(string_or_hash)
      tab_action_index = find_tab_action(string_or_hash)
      if tab_action_index.nil?
        new_tab_action = FunkyTabs::TabAction.new(string_or_hash)
        tab_actions << new_tab_action
        return new_tab_action
      else
        return tab_actions[tab_action_index]
      end
    end

    def add_tab_actions(array_of_properties)
      array_of_properties.each do |action_properties|
        add_tab_action(action_properties)
      end
      return tab_actions
    end
  end
end
