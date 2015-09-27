class RenameFieldType < ActiveRecord::Migration
  def change
    rename_column :fields, :type, :data_type
  end
end
