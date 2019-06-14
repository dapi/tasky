# frozen_string_literal: true

if Rails.env.staging?
  LetterOpenerWeb.configure do |config|
    config.letters_location = Rails.root.join('tmp', 'cache', 'letter_opener')
  end
end
