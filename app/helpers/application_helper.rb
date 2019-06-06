# frozen_string_literal: true

module ApplicationHelper
  def app_title
    'Tasky'
  end

  def icon(name, text: nil)
    content_tag :i, text, class: "ion ion-#{name}"
  end
end
