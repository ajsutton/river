# -*- encoding : utf-8 -*-
class View < ActiveRecord::Base
  belongs_to :church

  validates :name, presence: true, uniqueness: { scope: [ :church, :applies_to ] }
  validates :fields, presence: true
  validates :church, presence: true
  validates :applies_to, inclusion: { in: %w(person) }

  def load_fields
      if self.fields && !self.fields.empty?
          FieldSchema.find_by(church: self.church, applies_to: self.applies_to).fields.find_all { |field| self.fields.include? field[:id] }
      else
          []
      end
  end
end
