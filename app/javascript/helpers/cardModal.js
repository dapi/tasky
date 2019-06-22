const successHandler = data => {
  $('#cardModalBody').html($(data.body).children())
  ReactRailsUJS.mountComponents('#cardModalBody')
  jQuery('.best_in_place').best_in_place()
}

$('#cardModal').on('hide.bs.modal', (e) => {
  document.location.reload()

   // This variant does not update page every time
   // Turbolinks.visit(window.location, { action: 'replace' })
   // To preserve scroll: https://github.com/turbolinks/turbolinks/issues/329#issuecomment-341699031
})

export const showCardModal = cardId => {
  const $cardModal = $('#cardModal')
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
