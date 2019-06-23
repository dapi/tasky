# frozen_string_literal: true

require 'kramdown'

module ActionView
  module Template::Handlers
    class Markdown
      class_attribute :default_format
      self.default_format = Mime[:html]

      class << self
        def call(template)
          compiled_source = erb.call(template)
          "#{name}.render(begin;#{compiled_source};end)"
        end

        def render(template)
          Kramdown::Document
            .new(template, input: 'GFM', syntax_highlighter: :coderay, syntax_highlighter_opts: { line_numbers: false })
            .to_html
            .html_safe
        end

        private

        def erb
          @erb ||= ActionView::Template.registered_template_handler(:erb)
        end
      end
    end
  end
end

ActionView::Template.register_template_handler(:md, ActionView::Template::Handlers::Markdown)
