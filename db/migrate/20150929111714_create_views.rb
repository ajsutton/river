# -*- encoding : utf-8 -*-
class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :church, index: true, foreign_key: true, null: false
      t.string :applies_to, null: false
      t.string :name, null: false
      t.string :fields, array: true, null: false

      t.timestamps null: false
    end
    
    add_index :views, [:church_id, :applies_to, :name]
  end
end
