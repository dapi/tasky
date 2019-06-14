# frozen_string_literal: true

module ApplicationHelper
  def app_title
    'Tasky'
  end

  def humanized_time(time)
    content_tag :span, title: time.to_s do
      l Time.zone.at(time), format: :short
    end
  end

  def title_with_counter(title, count, hide_zero: true, css_class: nil)
    buffer = ''
    buffer += title

    buffer += ' '
    text = hide_zero && count.to_i.zero? ? '' : count.to_s
    # if type == :badge
    # css_class = 'badge-info' if css_class.nil?
    # buffer += content_tag(:span,
    # text,
    # class: ['badge', css_class].compact.join(' '),
    # data: { title_counter: true, count: count.to_i })
    # else
    buffer += content_tag(:span, "(#{text})", class: css_class, data: { title_counter: true, count: count.to_i })

    buffer.html_safe # rubocop:disable Rails/OutputSafety
  end
end
