require 'active_record'

class KitsModel < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "kits_development"
end
