require 'funky_tabs'
require 'rails'
require 'action_controller'

module FunkyTabs
  require 'funky_tabs/helpers'
  require 'funky_tabs/renderers'
  require 'funky_tabs/rails'
  require 'funky_tabs/tab'
  require 'funky_tabs/tab_action'

  class FunkyTabsException < Exception
  end

  ActionController::Base.send :include, FunkyTabs::Helpers
  ActionController::Base.send :include, FunkyTabs::Renderers

  mattr_accessor :tabs
  def self.tabs
    @@tabs ||= []
  end

  # make sure to include / at end of tab controller
  mattr_accessor :default_tab_index
  def self.default_tab_index
    @@default_tab_index ||= 0
  end
  mattr_accessor :default_tabs_controller
  def self.default_tabs_controller
    @@default_tabs_controller ||= "funky_tabs/update"
  end
  mattr_accessor :missing_tab_action_path
  def self.missing_tab_action_path
    @@missing_tab_action_path ||= "/funky_tabs/update/missing_tab"
  end
  mattr_accessor :tab_load_callback
  mattr_accessor :tab_select_callback
  mattr_accessor :loading_html
  def self.loading_html
    @@loading_html ||= "Loading..."
  end

  def self.setup
    yield self
  end

  def self.add_tab(string_or_hash)
    tab_index = find_tab(string_or_hash)
    if tab_index.nil?
      # if the tab doesnt exist, create it
      new_tab = FunkyTabs::Tab.new(string_or_hash)
      tabs << new_tab
      return new_tab
    else
      # if the tab exists, return it
      return tabs[tab_index]
    end
    raise FunkyTabsException.new("Dont know how to add this tab with #{string_or_hash.inspect}")
  end

  def self.add_tabs(array_of_properties)
    raise FunkyTabsException.new("dont know how to create tabs from #{array_of_properties.inspect}") unless array_of_properties.is_a?(Array)
    array_of_properties.each do |tab_properties|
      add_tab(tab_properties)
    end
    return tabs
  end

  def self.tab(sym_or_string)
    tab_index = find_tab(sym_or_string.to_s)
    return tabs[tab_index] unless tab_index.nil?
    return nil
  end

  def self.find_tab(tab_or_string_or_hash)
    return nil if tab_or_string_or_hash.blank? || tabs.blank?
    tab_or_string_or_hash = tab_or_string_or_hash.to_s if tab_or_string_or_hash.is_a?(Symbol)
    return tabs.index {|tab| tab.name.downcase == tab_or_string_or_hash.downcase} if tab_or_string_or_hash.is_a?(String)
    return tabs.index {|action| action.name == tab_or_string_or_hash[:name] } if tab_or_string_or_hash.is_a?(Hash)
    return tabs.index(tab_or_string_or_hash) if tab_or_string_or_hash.is_a?(FunkyTabs::Tab)
    raise FunkyTabsException.new("dont know how to find tab with #{tab_or_string_or_hash.inspect}")
  end

  def self.location_hash_for_tab_action(tab,tab_action=nil,tab_action_id=nil)
    return nil if tab.nil?

    tab_index = find_tab(tab)
    return nil if tab_index.nil?

    tab_action_index = tabs[tab_index].find_tab_action(tab_action)

    return tab_index.to_s if tab_action_index.nil?
    return "#{tab_index}-#{tab_action_index}" if tab_action_id.nil?
    return "#{tab_index}-#{tab_action_index}-#{tab_action_id}"
  end

  def self.location_hash_for_indices(tab_index,tab_action_index=nil)
    tab_index = tab_index.to_i
    tab_action_index = tab_action_index.to_i unless tab_action_index.nil?
    tab = tab_index.nil? ? nil : tabs[tab_index]
    tab_action = nil
    tab_action = tab.tab_actions[tab_action_index] unless tab.nil? || tab_action_index.nil?
    return location_hash_for_tab_action(tab,tab_action)
  end

  def self.content_path_for_tab_and_tab_action(tab,tab_action=nil,tab_action_id=nil)
    tab_index = find_tab(tab)
    return missing_tab_action_path if tab_index.nil?
    tab = tabs[tab_index]
    tab_action_index = tab.find_tab_action(tab_action||tab.default_tab_action)
    return missing_tab_action_path if tab_action_index.nil?
    tab_action = tab.tab_actions[tab_action_index]
    unless tab_action.content_path.blank?
      return tab_action.content_path if tab_action_id.nil?
      return tab_action.content_path+"&id=#{tab_action_id}" if tab_action.content_path.include?("?")
      return tab_action.content_path+"?id=#{tab_action_id}"
    end
    if tab_action.name.downcase == "index"
      content_path = "/#{default_tabs_controller}/#{tab.name.gsub(/\s/,"_").downcase}_index"
    else
      content_path = "/#{default_tabs_controller}/#{tab_action.name.gsub(/\s/,"_").downcase}_#{tab.name.gsub(/\s/,"_").downcase}"
    end
    return content_path if tab_action_id.nil?
    return "#{content_path}/#{tab_action_id}"
  end

  def self.tab_and_tab_action_from_location_hash(location_hash)
    return nil,nil,nil if tabs.blank?
    return tabs[default_tab_index],nil,nil if location_hash.blank?

    indices = location_hash.to_s.split("-")
    return nil,nil,nil if indices.first.nil?
    tab_index = indices.first.to_i
    tab = tabs[tab_index]
    return nil,nil,nil if tab.nil?
    tab_action_index = indices[1].to_i
    return tab,nil,nil if tab_action_index.nil?
    return tab,nil,nil if tab_action_index.to_i >= tab.tab_actions.length
    tab_action = tab.tab_actions[tab_action_index]

    tab_action_id = indices[2]
    return tab,tab_action,tab_action_id
  end

  def self.tab_index_from_location_hash(location_hash)
    return default_tab_index if tabs.blank? || location_hash.blank?
    indices = location_hash.to_s.split("-");
    return default_tab_index if indices.first.nil?
    tab = tabs[indices.first.to_i]
    return default_tab_index if tab.nil?
    return indices.first
  end

  # TODO: Figure out way to reset all mattr_accessors
  def self.reset
    tabs.clear
    tab_root = ""
  end
end
