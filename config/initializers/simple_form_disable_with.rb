# frozen_string_literal: true

module DisableDoubleClickOnSimpleForms
  def submit(field, options = {})
    if field.is_a?(Hash)
      field[:data] ||= {}
      field[:data][:disable_with] ||= I18n.t('helpers.disable_with')
    else
      options[:data] ||= {}
      options[:data][:disable_with] ||= I18n.t('helpers.disable_with')
    end
    super(field, options)
  end
end

SimpleForm::FormBuilder.prepend(DisableDoubleClickOnSimpleForms)
