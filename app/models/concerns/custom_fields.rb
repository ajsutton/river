# -*- encoding : utf-8 -*-
module CustomFields extend ActiveSupport::Concern
    included do
        after_initialize :init
    end

    def get_field(name)
        id = field_schema.id_for_name(name)
        self.fields[id]
    end

    def set_field(name, value)
        id = field_schema.id_for_name(name)
        self.fields[id] = value
    end

    def fields_from_params(params)
        field_definitions.each do |field|
            set_field(field[:name], params[field[:id]])
        end
    end

    def field_definitions
        field_schema.fields
    end

    module ClassMethods
        def schema(church)
            FieldSchema.find_by(church: church, applies_to: self.name.downcase) || FieldSchema.new(church: church, applies_to: self.name.downcase)
        end
    end

    private

    def init
      self.fields = {} if self.fields.nil?
    end

    def field_schema
        @schema ||= FieldSchema.find_by(church: self.church, applies_to: self.class.name.downcase)
        @schema || FieldSchema.new(church: self.church, applies_to: self.class.name.downcase)
    end
end
