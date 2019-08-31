# frozen_string_literal: true

require 'test_helper'

class InvitesAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @current_account = create :account, owner: @current_user
  end

  test 'initial checkup' do
    assert @current_account.invites.empty?
  end

  test 'POST /api/v1/invites' do
    email = generate :email
    post '/api/v1/invites', params: { email: email, account_id: @current_account.id }
    assert response.successful?

    assert @current_account.invites.one?
    assert_not ActionMailer::Base.deliveries.empty?
  end
end
