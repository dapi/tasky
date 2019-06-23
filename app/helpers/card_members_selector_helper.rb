# frozen_string_literal: true

module CardMembersSelectorHelper
  def card_members_selector(card)
    react_component 'MembersSelector',
                    boardId: card.board_id,
                    cardId: card.id,
                    defaultUsers: card.account_memberships.includes(:member).map { |acc_membership| present_account_membership acc_membership },
                    availableUsers: current_account.memberships.includes(:member).map { |acc_membership| present_account_membership acc_membership }
  end

  private

  def present_account_membership(acc_membership)
    { id: acc_membership.id, label: acc_membership.member.public_name, avatar_url: acc_membership.member.avatar_url(size: 24) }
  end
end
