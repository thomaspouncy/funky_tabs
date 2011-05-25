require 'funky_tabs'
require 'rails'

module FunkyTabs
  module Renderers
    extend ActiveSupport::Concern

    module InstanceMethods
      def render(*args, &block)
        super(*args, &block) and return if params[:funky_tabs].nil?
        @location_hash = params[:location_hash]
        super(*args, &block) and return if @location_hash.nil?
        @tab_index = FunkyTabs.tab_index_from_location_hash(@location_hash)
        super(*args, &block) and return if @tab_index.nil?
        @render_content = render_to_string(*args, &block)
        super(:template=>"funky_tabs/update/update_tab",:layout=>false)
      end
    end
  end
end
