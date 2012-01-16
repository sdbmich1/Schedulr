require 'active_record'

class KitsKnnModel < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "kits_knn"
end
