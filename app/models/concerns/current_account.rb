# frozen_string_literal: true

module CurrentAccount
  def current_account
    RequestStore.store[:account]
  end

  def current_account=(account)
    RequestStore.store[:account] = account
  end
end
