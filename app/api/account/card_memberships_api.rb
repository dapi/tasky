# frozen_string_literal: true

class Account::CardMembershipsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def card
      @card = current_user.available_cards.find params[:card_id]
    end
  end

  desc 'Участники карточки'
  params do
    requires :card_id, type: String
  end
  resources :card_memberships do
    desc 'Список участников'
    get do
      present CardMembershipSerializer.new card.memberships.ordered, include: %i[member]
    end

    desc 'Переопределить участников'
    params do
      requires :account_membership_ids, type: Array[String], desc: 'Массив ID пользователей для переустановки'
    end
    put do
      card.account_membership_ids = params[:account_membership_ids].reject(&:empty?)
      card.board.notify
      present CardMembershipSerializer.new card.memberships.ordered, include: %i[member]
    end
  end
end
