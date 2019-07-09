# frozen_string_literal: true

class BoardPresenter
  def initialize(board, user = nil)
    @board = board
    @user = user
  end

  def data
    {
      board: {
        id: board.id
      },
      lanes: board.lanes.alive.ordered.map do |lane|
        {
          id: lane.id,
          title: lane.title,
          cards: lane.cards.alive.ordered.map { |t| present_card t }
        }
      end
    }
  end

  private

  attr_reader :board, :user

  def unseen_comments_count_for(card)
    task_user = card.task_users.find_by(user: user)

    return card.comments_count unless task_user

    card.comments.where('created_at > ?', task_user.seen_at).count
  end

  def present_card(card)
    {
      id: card.id,
      title: card.title,
      description: card.details,
      commentsCount: card.comments_count,
      attachmentsCount: card.attachments_count,
      unseenCommentsCount: unseen_comments_count_for(card),
      label: "position: #{card.position}",
      tags: parse_tags(card.title),
      memberships: present_members(card.account_memberships.includes(:member))
    }
  end

  def present_members(memberships)
    memberships.map do |membership|
      { id: membership.id, avatarUrl: membership.member.avatar_url, publicName: membership.member.public_name }
    end
  end

  def parse_tags(title)
    title.scan(/\[[^\]]+\]/).map do |tag|
      title = tag.slice(0, tag.length - 1).slice(-tag.length + 2, tag.length - 2)
      { title: title }
    end
  end
end
