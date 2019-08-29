const onLoad = (e) => {
}

const onModalClick = (e) => {
  e.preventDefault()
  const $a = $(e.currentTarget)
  const url = $a.data('url')
  const $modal = $($a.data('target'))

  $modal
    .find('.modal-content')
    .load(url, onLoad)

  $modal.modal()
}

$('[data-toggle="remoteModal"]').on('click', onModalClick)
