export const showCardModal = cardId => {
  const $cardModal = $('#cardModal')
  const $body = $cardModal.find('.modal-body')

  const successHandler = data => {
    $body.html($(data.body).children())
    ReactRailsUJS.mountComponents($body)
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
