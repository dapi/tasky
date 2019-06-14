# frozen_string_literal: true

require 'addressable/uri'

class AccountConstraint
  extend CurrentAccount

  def self.matches?(request)
    account = Account.find_by subdomain: request.subdomain

    if account.present?
      self.current_account = account
      return true
    else
      self.current_account = nil
      return false
    end
  end
end
