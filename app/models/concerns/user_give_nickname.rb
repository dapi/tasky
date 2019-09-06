# frozen_string_literal: true

module UserGiveNickname
  extend ActiveSupport::Concern
  TRIES_COUNT = 3

  included do
    before_create :give_nickname, unless: :nickname
  end

  private

  def give_nickname
    suffix = ''
    TRIES_COUNT.times.each do
      nn = prefix_name + suffix
      if User.where(nickname: nn).empty?
        self.nickname = nn
        break
      end
      suffix = SecureRandom.hex(2)
    end
  end

  def prefix_name
    @prefix_name ||= (name.split.first.presence || email.split('@').first).to_slug.normalize(transliterations: :russian).to_s
  end
end
