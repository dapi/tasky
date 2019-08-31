const $cardModal = $('#cardModal')
const $content = $cardModal.find('.modal-content')

$cardModal.on('hidden.bs.modal', () => $content.html(''))

export const showCardModal = cardId => {
  const successHandler = data => {
    $content.html('<div class="modal-body"/>')
    $content.children().html($(data.body).children())
    ReactRailsUJS.mountComponents($content)
  }

  Rails.ajax({
    url: `/cards/${cardId}`,
    type: 'get',
    success: successHandler,
    error: data => {
      alert(data)
    },
  })
  $cardModal.modal()
}
