class EntityType < KitsSubModel
  set_table_name 'entitytype'

  default_scope :order => 'sortkey ASC'
end
