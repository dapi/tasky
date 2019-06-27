# frozen_string_literal: true

class SwaggerController < ::ApplicationController
  skip_before_action :require_login

  # https://github.com/yunixon/swagger-ui_rails5/blob/master/app/views/swagger_ui/_swagger_ui.html.erb
  def index
    render locals: { discovery_url: discovery_url }
  end

  private

  def discovery_url
    url_for + '/v1/swagger_doc'
  end
end
