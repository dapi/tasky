# frozen_string_literal: true

class UserSession
  include Virtus.model
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations

  attribute :login, String
  attribute :password, String

  validates :login, presence: true
  validates :password, presence: true

  def persisted?
    false
  end
end
