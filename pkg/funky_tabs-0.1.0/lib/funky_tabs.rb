module FunkyTabs
  require 'funky_tabs/tab'
  require 'funky_tabs/tab_action'

  class FunkyTabException < Exception; end

  mattr_accessor :tabs
  @@tabs = []

  def self.setup
    yield self
  end

  def self.add_tab(tab_properties)
    @@tabs << FunkyTabs::Tab.new(tab_properties)
  end

  def self.render_tabs
  end

  # make helper version of this for javascript
  def self.go_to(tab=nil,action=nil)
  end
end
