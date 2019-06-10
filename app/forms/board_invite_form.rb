# frozen_string_literal: true

class BoardInviteForm
  include Virtus.model
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations

  attribute :email, String

  validates :email, presence: true, email: true
end
