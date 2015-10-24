# -*- encoding : utf-8 -*-
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true, null: false
      t.references :church, index: true, foreign_key: true, null: false
      t.references :person, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
