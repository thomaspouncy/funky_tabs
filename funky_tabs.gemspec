# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{funky_tabs}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thomas Pouncy"]
  s.date = %q{2011-05-21}
  s.description = %q{Create Ajaxified tabs with simple history through window location hashes for Rails.}
  s.email = %q{thomas.pouncy@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/funky_tabs.rb", "lib/funky_tabs/helpers.rb", "lib/funky_tabs/rails.rb", "lib/funky_tabs/renderers.rb", "lib/funky_tabs/tab.rb", "lib/funky_tabs/tab_action.rb"]
  s.files = ["CHANGELOG", "Manifest", "README.rdoc", "Rakefile", "app/controllers/funky_tabs/update_controller.rb", "app/views/funky_tabs/update/_ajax.js.erb", "app/views/funky_tabs/update/_render_funky_tabs.html.erb", "app/views/funky_tabs/update/missing_tab.html.erb", "app/views/funky_tabs/update/update_tab.html.erb", "config/routes.rb", "funky_tabs.gemspec", "init.rb", "lib/funky_tabs.rb", "lib/funky_tabs/helpers.rb", "lib/funky_tabs/rails.rb", "lib/funky_tabs/renderers.rb", "lib/funky_tabs/tab.rb", "lib/funky_tabs/tab_action.rb", "test/funky_tabs_test.rb"]
  s.homepage = %q{http://github.com/thomaspouncy/funky_tabs}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Funky_tabs", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{funky_tabs}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Create Ajaxified tabs with simple history through window location hashes for Rails.}
  s.test_files = ["test/funky_tabs_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
