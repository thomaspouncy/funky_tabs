require 'funky_tabs'
require 'rails'

module FunkyTabs
  module Renderers
    extend ActiveSupport::Concern

    module InstanceMethods
      def render(*args, &block)
        super(*args, &block) and return if params[:funky_tabs].nil?
        logger.debug "full path is #{request.fullpath}"
        if FunkyTabs.correct_path_for_location_hash?(request.fullpath,params[:location_hash])
          @location_hash = params[:location_hash]
        else
          @location_hash = FunkyTabs.location_hash_for_content_path(request.fullpath)
        end
        super(*args, &block) and return if @location_hash.nil?
        @tab_index = FunkyTabs.tab_index_from_location_hash(@location_hash)
        super(*args, &block) and return if @tab_index.nil?
        @render_content = render_to_string(*args, &block)
        super(:template=>"funky_tabs/update/update_tab",:layout=>false)
      end
    end
  end
end
