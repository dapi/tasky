# frozen_string_literal: true

module MetadataSupport
  extend ActiveSupport::Concern

  # https://www.postgresql.org/docs/10/functions-json.html#FUNCTIONS-JSONB-OP-TABLE
  #
  AVAILABLE_OPERATORS = ['@>', '<@', '?', '?|', '?&'].freeze

  included do
    scope :metadata_query, lambda { |op = AVAILABLE_OPERATORS.first, value|
      raise "Operation (#{op}) must be on of #{AVAILABLE_OPERATORS}" unless AVAILABLE_OPERATORS.include? op

      where("metadata #{op} :value", value: value.is_a?(String) ? value : value.to_json)
    }

    before_validation do
      self.metadata ||= {}
    end
    validate :metadata_is_hash
  end

  private

  def metadata_is_hash
    errors.add :metadata, '`metadata` must be a Hash' unless metadata.is_a? Hash
  end
end
