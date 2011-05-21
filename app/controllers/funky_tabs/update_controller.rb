class FunkyTabs::UpdateController < ApplicationController
  layout false

  def missing_funky_tab
    render FunkyTabs.missing_tab_action_path,:layout=>false and return
  end
end
