require 'test_helper'

class FunkyTabsTest < ActiveSupport::TestCase
  def setup
    FunkyTabs.reset
    FunkyTabs.add_tab("first tab")
    FunkyTabs.add_tab(:name=>"second tab",:default_tab_action=>"edit")
    FunkyTabs.add_tab(:name=>"third tab",:tab_actions=>"edit")
    FunkyTabs.add_tab(:name=>"fourth tab",:tab_actions=>["edit",{:name=>"update",:content_path=>"test_path",:use_regular_content_paths=>false}])
  end

  test "content_path_for_location_hash returns default action path given no action" do
    assert_equal "funky_tabs/first_tab/index",FunkyTabs.content_path_for_location_hash("0")
  end

  test "content_path_for_location_hash returns action path given action" do
    assert_equal "funky_tabs/third_tab/edit",FunkyTabs.content_path_for_location_hash("2-1")
  end

  test "content_path_for_location_hash returns nil given invalid object" do
    assert_nil FunkyTabs.content_path_for_location_hash("bogus hash")
  end
end
