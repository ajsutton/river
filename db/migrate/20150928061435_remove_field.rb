# -*- encoding : utf-8 -*-
class RemoveField < ActiveRecord::Migration
  def change
    drop_table :fields
  end
end
