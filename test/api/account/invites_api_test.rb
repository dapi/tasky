# frozen_string_literal: true

require 'test_helper'

class InvitesAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    account_host!
  end

  test 'initial checkup' do
    assert @current_account.invites.empty?
  end

  test 'POST /api/v1/invites' do
    email = generate :email
    post '/api/v1/invites', params: { email: email }
    assert response.successful?

    assert @current_account.invites.one?
    assert_not ActionMailer::Base.deliveries.empty?
    # assert_equal metadata, JSON.parse(response.body).dig('data', 'attributes', 'metadata')
  end
end
