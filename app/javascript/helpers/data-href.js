const handler = e => {
  const $target = $(e.target)
  if ($target.is('.btn') || $target.is('select')) {
    return
  }
  const href = $(e.currentTarget).attr('data-href')

  if (typeof Turbolinks !== 'undefined') {
    Turbolinks.visit(href)
  } else {
    window.location = href
  }
}

document.addEventListener('turbolinks:load', function() {
  $('[data-href]').on('click', handler)
})
