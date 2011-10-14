class AddIndextoEventPresenter < ActiveRecord::Migration
  def self.up
    add_index :event_presenters, :event_id
    add_index :event_presenters, :presenter_id
    add_index :event_presenters, [:event_id, :presenter_id], :unique => true
  end

  def self.down
  end
end
