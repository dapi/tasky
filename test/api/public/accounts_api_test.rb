# frozen_string_literal: true

require 'test_helper'

class AccountsAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    host! 'api.' + Settings.default_url_options[:host]
  end

  test 'POST /v1/accounts' do
    metadata = { 'a' => 1 }
    post '/v1/accounts', params: { name: 'name', metadata: metadata.to_json }
    assert response.successful?
    assert_equal metadata, JSON.parse(response.body).dig('data', 'attributes', 'metadata')
  end
end
