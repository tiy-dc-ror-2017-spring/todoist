require "active_record"

class CreateListsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
    end
  end
end
