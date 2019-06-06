# frozen_string_literal: true

class UserWithPassword < User
  authenticates_with_sorcery!
  validates :password, presence: true, confirmation: true

  def self.model_name
    User.model_name
  end
end
