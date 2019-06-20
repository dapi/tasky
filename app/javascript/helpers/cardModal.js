$('#cardModal').on('show.bs.modal', function(event) {
  const modal = $(this)
  modal.find('.modal-body').val('aaa')
})

const successHandler = data => {
  $('#cardModalBody').html($(data.body).children())
  ReactRailsUJS.mountComponents()
  jQuery('.best_in_place').best_in_place()
  $('[data-cardModalClose]').on('click', () => $('#cardModal').modal('hide'))
}

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
