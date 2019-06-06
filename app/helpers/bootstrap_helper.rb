# frozen_string_literal: true

module BootstrapHelper
  include Pagy::Frontend

  # https://gist.github.com/fjahr/b3828b9f4e333e74ba1894687d65e055
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(_opts = [])
    return '' unless flash.any?

    flash.each do |msg_type, message|
      next unless !message.nil? && message.to_s.length.positive?

      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: 'alert') do
        concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  # for outputting an objects error messages
  def errors_for(object)
    return '' unless object.errors.any?

    content_tag(:div, class: 'card border-danger') do
      concat(content_tag(:div, class: 'card-header bg-danger text-white') do
        concat "#{pluralize(object.errors.count, 'error')} prohibited this #{object.class.name.downcase} from being saved:"
      end)
      concat(content_tag(:ul, class: 'mb-0 list-group list-group-flush') do
        object.errors.full_messages.each do |msg|
          concat content_tag(:li, msg, class: 'list-group-item')
        end
      end)
    end
  end
end
