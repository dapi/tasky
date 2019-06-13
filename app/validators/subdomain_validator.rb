# frozen_string_literal: true

class SubdomainValidator < ActiveModel::Validator
  REGEXP = /\A[a-z0-9][a-z0-9_\-]*[a-z0-9]\z/i.freeze

  def validate(record)
    fields = options[:attributes]
    fields.each do |field|
      validate_field(record, field)
    end
  end

  private

  def validate_field(record, field_name)
    value = record.send field_name

    return if value.blank? || REGEXP.match(value)

    record.errors[field_name] << I18n.t('errors.messages.invalid_subdomain')
  end
end
