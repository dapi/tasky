import autosize from 'autosize'

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('[autosize]').forEach( el => autosize(el) )
})

