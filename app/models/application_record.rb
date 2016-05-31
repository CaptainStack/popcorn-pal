# Added as part of Rails 5 migration http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
