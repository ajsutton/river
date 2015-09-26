# -*- encoding : utf-8 -*-
class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :shortname, limit: 16
      t.string :name

      t.timestamps null: false
    end
    add_index :churches, :shortname, unique: true
  end
end

