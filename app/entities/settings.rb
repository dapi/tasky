# frozen_string_literal: true

require 'settingslogic'
if defined? Rails
  class Settings < Settingslogic
    source Rails.root.join('config', 'settings.yml')
    namespace Rails.env
    suppress_errors Rails.env.production?
  end
else
  class Settings < Settingslogic
    source './config/settings.yml'
    namespace 'development'
  end
end
