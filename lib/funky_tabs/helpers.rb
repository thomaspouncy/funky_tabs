require 'funky_tabs'
require 'rails'

module FunkyTabs
  module Helpers
    def self.included(base)
      base.class_eval do
        def render_funky_tabs
          #@tab_data = FunkyTabs
          return render_to_string :partial=>"funky_tabs/update/render_funky_tabs"
        end

        def location_hash_for_funky_tab(tab,tab_action=nil,tab_action_id=nil)
          return FunkyTabs.location_hash_for_tab_action(tab,tab_action,tab_action_id)
        end

        def redirect_to_funky_tab(tab,tab_action=nil,tab_action_id=nil)
          params[:location_hash] = FunkyTabs.location_hash_for_tab_action(tab,tab_action,tab_action_id)
          action_to_call = FunkyTabs.content_path_for_tab_and_tab_action(tab,tab_action)
          redirect_to action_to_call+"?funky_tabs=true&location_hash=#{params[:location_hash]}" and return unless action_to_call.include?("?")
          redirect_to action_to_call+"&funky_tabs=true&location_hash=#{params[:location_hash]}" and return
        end

        def js_to_funky_tab(tab,tab_action=nil,tab_action_id=nil)
          @location_hash_for_ajax = FunkyTabs.location_hash_for_tab_action(tab,tab_action,tab_action_id)
          return render_to_string :partial=>"funky_tabs/update/ajax.js"
        end
        helper_method :render_funky_tabs, :redirect_to_funky_tab, :js_to_funky_tab
      end
    end
  end
end
