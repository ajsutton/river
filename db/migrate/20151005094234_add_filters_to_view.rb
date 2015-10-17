# -*- encoding : utf-8 -*-
class AddFiltersToView < ActiveRecord::Migration
  def change
    add_column :views, :filters, :jsonb
  end
end
