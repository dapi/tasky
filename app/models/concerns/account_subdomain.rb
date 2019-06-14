# frozen_string_literal: true

module AccountSubdomain
  extend ActiveSupport::Concern
  included do
    before_validation on: :create do
      self.subdomain ||= SecureRandom.hex(4)
    end

    before_validation do
      self.subdomain = self.subdomain.downcase
    end

    validates :subdomain,
              presence: true,
              subdomain: true,
              uniqueness: true,
              length: { maximum: 63 }

    validates :subdomain,
              exclusion: { in: Settings.reserved_subdomains },
              if: :subdomain_changed?
  end
end
