# -*- encoding : utf-8 -*-
class AddNameToFields < ActiveRecord::Migration
  def change
    add_column :fields, :name, :string
    

    remove_index(:fields, column: [:church_id, :applies_to])
    add_index :fields, [ :church_id, :applies_to, :name ], unique: true
  end
end

