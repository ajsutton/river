class AddChurchToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :church, index: true, foreign_key: true
  end
end
