# frozen_string_literal: true

class CardMembershipsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def card
      @card = current_user.available_cards.find params[:card_id]
    end
  end

  params do
    requires :card_id, type: String
  end
  resources :card_memberships do
    get do
      present CardMembershipSerializer.new card.memberships.ordered, include: %i[member]
    end

    desc 'Replace members'
    params do
      requires :account_membership_ids, type: Array[String], desc: 'Array of new ID'
    end
    put do
      card.account_membership_ids = params[:account_membership_ids].reject(&:empty?)
      BoardChannel.update_with_card card.board, card
      present CardMembershipSerializer.new card.memberships.ordered, include: %i[member]
    end
  end
end
