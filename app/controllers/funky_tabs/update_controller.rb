class FunkyTabs::UpdateController < ApplicationController
  layout false

  def funky_tab_action
    tab,tab_action,tab_action_id = FunkyTabs.tab_and_tab_action_from_location_hash(params[:location_hash])
    action_to_call = FunkyTabs.content_path_for_tab_and_tab_action(tab,tab_action,tab_action_id)
    redirect_to action_to_call+"?funky_tabs=true&location_hash=#{params[:location_hash]}" and return unless action_to_call.include?("?")
    redirect_to action_to_call+"&funky_tabs=true&location_hash=#{params[:location_hash]}" and return
  end

  def missing_funky_tab
    render FunkyTabs.missing_tab_action_path,:layout=>false and return
  end
end
