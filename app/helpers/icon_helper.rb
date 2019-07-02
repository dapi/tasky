# frozen_string_literal: true

module IconHelper
  # Example css_class: 'icon-lg'
  def icon(name, text: nil, css_class: nil)
    content_tag :i, text, class: "ion ion-#{name} #{css_class}"
  end

  def icon_svg(path, html_options = {})
    content_tag :i, html_options.merge(class: "#{html_options[:class]} d-inline-block") do
      inline_svg path, class: 'd-inline-block', width: '100%', height: '100%', preserve_aspect_ratio: 'xMaxYMax meet'
    end
  end
end
