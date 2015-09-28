# -*- encoding : utf-8 -*-
class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.references :church, index: true, foreign_key: true
      t.string :applies_to
      t.jsonb :fields

      t.timestamps null: false
    end
    
    add_index :custom_fields, [:church_id, :applies_to]
  end
end
