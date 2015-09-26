# -*- encoding : utf-8 -*-
class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.jsonb :attributes

      t.timestamps null: false
    end
    add_index :people, :attributes, using: :gin
  end
end

