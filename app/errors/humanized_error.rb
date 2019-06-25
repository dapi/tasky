# frozen_string_literal: true

# Use this error class in cases you want to interrupt flow and show user some message

class HumanizedError < StandardError
  def initialize(options = {}, opts2 = {})
    if options.is_a? String
      @message = options
      @options = {}
    elsif options.is_a? Symbol
      key = options
      opts2.reverse_merge! default: key.to_s, scope: [:errors, class_key]
      @options = opts2
      @message ||= I18n.t key, opts2
    else
      @options = options
      @message = I18n.t [:errors, class_key].join('.'), @options
    end
  end

  def title
    @title || I18n.t('helpers.warning')
  end

  attr_reader :message

  private

  def class_key
    self.class.name.underscore.tr('/', '.')
  end
end
