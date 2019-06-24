import { updateBoardData } from 'components/Dashboard'

const successHandler = data => {
  $('#cardModalBody').html($(data.body).children())
  ReactRailsUJS.mountComponents('#cardModalBody')
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
