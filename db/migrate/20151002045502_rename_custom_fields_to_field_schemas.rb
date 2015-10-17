# -*- encoding : utf-8 -*-
class RenameCustomFieldsToFieldSchemas < ActiveRecord::Migration
  def change
      rename_table :custom_fields, :field_schemas
  end
end
