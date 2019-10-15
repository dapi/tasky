# frozen_string_literal: true

class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :card

  belongs_to :lane, unless: proc { |_record, params| params && params[:skip_belongs] }
  belongs_to :board, unless: proc { |_record, params| params && params[:skip_belongs] }
  belongs_to :task
  belongs_to :author, record_type: :user, serializer: :User

  attributes :task_id, :lane_id, :board_id, :author_id, :position, :number, :title, :details, :formatted_details, :comments_count, :attachments_count, :tags

  attribute :memberships do |card, _params|
    card.account_memberships.includes(:member).map do |membership|
      {
        id: membership.id,
        avatarUrl: membership.member.avatar_url,
        publicName: membership.member.public_name
      }
    end
  end

  attribute :task_users do |card, _params|
    h = {}
    card.task_users.each do |tu|
      h[tu.user_id] = { unseen_comments_count: tu.unseen_comments_count }
    end
    h
  end

  attribute :tags do |card, _params|
    card.tags.map do |tag|
      { title: tag }
    end
  end
end
