require 'funky_tabs'
require 'rails'

module FunkyTabs
  module Helpers
    def self.included(base)
      base.class_eval do
        def render_funky_tabs
          @path_from_hash_arr = FunkyTabs.javascript_key_array
          return render_to_string :partial=>"funky_tabs/update/render_funky_tabs"
        end

        def location_hash_for_funky_tab(tab,tab_action=nil,tab_action_id=nil)
          return FunkyTabs.location_hash_for_tab_action(tab,tab_action,tab_action_id)
        end

        def js_to_funky_tab(tab,tab_action=nil,tab_action_id=nil)
          @location_hash_for_ajax = FunkyTabs.location_hash_for_tab_action(tab,tab_action,tab_action_id)
          return render_to_string :partial=>"funky_tabs/update/ajax.js"
        end
        helper_method :render_funky_tabs, :js_to_funky_tab, :location_hash_for_funky_tab
      end
    end
  end
end
