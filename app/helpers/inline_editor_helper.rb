# frozen_string_literal: true

module InlineEditorHelper
  # example:
  #
  # = inline_input card, :title, url: card_path(card), tabindex: 1
  #
  def inline_input(object, attribute, url:, tabindex: nil, resize: :none)
    react_component('InlineEditor',
                    value: object.send(attribute), attribute: attribute, url: url, tabindex: tabindex, resize: resize)
  end

  # used for card#details
  def inline_details(card, url:, tabindex: nil)
    react_component('CardDetails',
                    card: { id: card.id, details: card.details.to_s.chomp, formatted_details: card.formatted_details },
                    url: url,
                    tabindex: tabindex)
  end
end
