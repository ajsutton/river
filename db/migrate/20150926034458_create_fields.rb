# -*- encoding : utf-8 -*-
class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :church, index: true, foreign_key: true
      t.string :applies_to
      t.string :type
      t.boolean :required

      t.timestamps null: false
    end
    
    add_index :fields, [ :church_id, :applies_to ]
  end
end

