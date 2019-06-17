# frozen_string_literal: true

require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test 'should get edit' do
    card = create :card
    card.account.members << @current_user
    get edit_card_url(card, subdomain: card.account.subdomain)
    assert_response :success
  end
end
