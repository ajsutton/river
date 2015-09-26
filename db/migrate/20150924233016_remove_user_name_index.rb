# -*- encoding : utf-8 -*-
class RemoveUserNameIndex < ActiveRecord::Migration
  def change
    remove_index(:users, column: :name)
  end
end

