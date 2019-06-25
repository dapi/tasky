# frozen_string_literal: true

class ApiError::Base < StandardError
  include Virtus.model
  DEFAULT_STATUS = 500

  # https://tools.ietf.org/html/rfc6901
  # a JSON Pointer [RFC6901] to the associated entity in the request document
  # [e.g. "/data" for a primary data object, or "/data/attributes/title" for a specific attribute].
  #
  attribute :title, String
  attribute :detail, String
  attribute :code, String

  # attribute :links, Hash

  attribute :source_pointer, String
  attribute :source_parameter, String

  def to_json(*_args)
    as_json.to_json
  end

  def as_json
    data = {
      id: id,
      code: code,
      title: title,
      detail: detail
    }

    data[:source] = source if source.present?

    data.compact
  end

  def source
    @source ||= { pointer: source_pointer, parameter: source_parameter }.compact
  end

  def id
    object_id
  end

  def status
    DEFAULT_STATUS
  end

  def title
    super || I18n.t(:title, scope: i18n_scope, default: self.class.to_s)
  end

  def detail
    super || I18n.t(:detail, scope: i18n_scope, default: nil)
  end

  def code
    super || self.class.name.underscore
  end

  def message
    [title, detail].compact.join(': ')
  end

  private

  def i18n_scope
    [:api_errors, self.class.name.underscore]
  end
end
