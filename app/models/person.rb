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

  def custom_field(name)
      @schema.id_for_name(name)
  end

  private
  def init
    self.fields = {} if self.fields.nil?
    type = 'person'
    @schema = FieldSchema.find_by(church: church, applies_to: type) || FieldSchema.new(church: church, applies_to: type)
  end
end
