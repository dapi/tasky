# frozen_string_literal: true

class InviteForm
  include Virtus.model
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations

  attribute :emails, String

  validates :emails, presence: true

  def emails=(value)
    super parse_emails(value).join("\n")
  end

  def persisted?
    false
  end

  def emails_list
    parse_emails emails
  end

  private

  def parse_emails(value)
    value.to_s
         .split(/[\n,\s]/)
         .map(&:squish)
         .select(&:present?)
         .uniq
  end
end
