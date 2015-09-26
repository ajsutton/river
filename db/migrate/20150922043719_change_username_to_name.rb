# -*- encoding : utf-8 -*-
class ChangeUsernameToName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :name
    add_column :users, :email, :string
  end
end

