# frozen_string_literal: true

module InlineEditorHelper
  def inline_card_title(card, tabindex:)
    url = "/cards/#{card.id}"
    attribute = :title
    react_component('TitleEditorController',
                    value: card.send(attribute), attribute: attribute, url: url, tabindex: tabindex, resize: :vertical)
  end

  # used for card#details
  def inline_card_details(card, tabindex:)
    url = card_path(card)
    react_component('CardDetails',
                    card: { id: card.id, details: card.details.to_s.chomp, formatted_details: card.formatted_details },
                    url: url,
                    tabindex: tabindex)
  end
end
