const onModalClick = (e) => {
  e.preventDefault()
  const $a = $(e.currentTarget)
  const url = $a.data('url')
  const $modal = $($a.data('target'))
  const $content = $modal
    .find('.modal-content')

  const onSuccess = (evt) => {
    const html = evt.originalEvent.detail[2].responseText

    if (html.includes('Turbolinks.visit')) {
      $modal.modal('hide')
    } else {
      $content.html(html)
    }
  }

  const onLoad = (e) => {
    $('form[data-remote]').
      on("ajax:success", onSuccess)
  }

  $content.load(url, onLoad)
  $modal.modal()
}

const initialHandler = () => {
  $('[data-toggle="remoteModal"]').on('click', onModalClick)
}

document.addEventListener('turbolinks:load', initialHandler)
// $(document).ready(initialHandler)
