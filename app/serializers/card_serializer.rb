# frozen_string_literal: true

class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :card

  belongs_to :lane, if: proc { |_card, params| params && params[:expose_belongs] }
  belongs_to :board, if: proc { |_card, params| params && params[:expose_belongs] }
  belongs_to :task

  attributes :task_id, :position, :title, :details, :formatted_details, :comments_count, :attachments_count, :tags

  attribute :memberships do |card, _params|
    card.account_memberships.includes(:member).map do |membership|
      {
        id: membership.id,
        avatarUrl: membership.member.avatar_url,
        publicName: membership.member.public_name
      }
    end
  end

  attribute :tags do |card, _params|
    card.tags.map do |tag|
      { title: tag }
    end
  end
end
