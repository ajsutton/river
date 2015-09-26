# -*- encoding : utf-8 -*-
class RemovePassword < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
  end
end

