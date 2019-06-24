# https://github.com/rails/rails/issues/35501
#
namespace :assets do
  desc "Copy action_cable from node_modules to lib/javascripts"
  task :action_cable do
    require "json"
    require "action_cable"

    `cp node_modules/@rails/actioncable/app/assets/javascripts/action_cable.js lib/javascript`
  end
end
