# frozen_string_literal: true

module MetadataSupport
  extend ActiveSupport::Concern
  LIMIT_SIZE = 1024

  # https://www.postgresql.org/docs/10/functions-json.html#FUNCTIONS-JSONB-OP-TABLE
  #
  AVAILABLE_OPERATORS = ['@>', '<@', '?', '?|', '?&'].freeze

  included do
    scope :by_metadata, lambda { |op, value|
      raise "Operation (#{op}) must be on of #{AVAILABLE_OPERATORS}" unless AVAILABLE_OPERATORS.include? op

      where("metadata #{op} :value", value: value.is_a?(String) ? value : value.to_json)
    }

    before_validation { self.metadata ||= {} }

    validate :validate_metadata
  end

  private

  def validate_metadata
    errors.add :metadata, 'root object of `metadata` must be a Hash' unless metadata.is_a? Hash
    return unless metadata_changed?

    size = Oj.dump(metadata).size
    errors.add :metadata, "`metadata` limit size is reached (#{size}>#{LIMIT_SIZE})" if size > LIMIT_SIZE
  end
end
