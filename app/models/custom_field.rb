# -*- encoding : utf-8 -*-
class CustomField < ActiveRecord::Base
  belongs_to :church
  
  validates :church, presence: true
  validates :applies_to, inclusion: { in: %w(person) }
  
  validate :valid_fields
  
  after_initialize :init
  
  private
  
  def valid_fields
    if !self.fields.is_a?(Array)
      self.errors.add :fields, 'Invalid value for fields'
    elsif self.fields.nil?
      self.errors.add :fields, 'Fields must be specified'
    else
      self.fields.each do |field|
        self.errors.add :base, 'Name must be specified' if field['name'].blank?
        self.errors.add :base, 'Type must be specified' unless %w(string boolean integer date).include? field['type']
        
        required = field['required']
        self.errors.add :base, 'Required must be true or false' unless required.is_a?(TrueClass) || required.is_a?(FalseClass) || required.nil?
      end
    end
  end
  
  def init
    self.fields = [] if self.fields.nil?
  end
end
