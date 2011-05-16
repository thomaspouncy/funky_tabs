Rails.application.routes.draw do
  scope "funky_tabs", :module=>:funky_tabs, :as => 'funky_tabs' do
    match "update(/:action(/:id(/:format)))", :controller=>:update
  end
end
