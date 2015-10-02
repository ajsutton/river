# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
  belongs_to :church

  validates :church, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_initialize :init

  def name
    "#{first_name} #{last_name}"
  end

  def get_field(name)
      id = field_schema.id_for_name(name)
      self.fields[id]
  end

  def set_field(name, value)
      id = field_schema.id_for_name(name)
      self.fields[id] = value
  end

  def field_definitions
      field_schema.fields
  end

  private
  def init
    self.fields = {} if self.fields.nil?
  end

  def field_schema
      @schema ||= FieldSchema.find_by(church: self.church, applies_to: 'person')
      @schema || FieldSchema.new(church: church, applies_to: 'person')
  end
end
