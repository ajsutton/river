# -*- encoding : utf-8 -*-
class RenameAttributesToFields < ActiveRecord::Migration
  def change
    rename_column :people, :attributes, :fields
  end
end

