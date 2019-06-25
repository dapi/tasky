// Usage:
// = f.submit class: 'btn btn-primary', data: { enableWhenChanged: true}

function enableElement($el, $reset) {
  $el.prop('disabled', false)
  $reset.removeClass('invisible')
  $reset.fadeIn('fast')
}

function disableElement($el, $reset) {
  $el.prop('disabled', true)
  $reset.removeClass('invisible')
  $reset.fadeOut('fast')
}

$(document).ready(function() {
  var changeListeners = $('[data-enableWhenChanged=true]')

  changeListeners.each(function(index) {
    const listener = changeListeners[index]
    var $el = $(listener)
    var $form = $el.closest('form')

    var $reset = $form.find(':reset')

    // Например: удаление товара из заказа
    var onRemoved = function(e) {
      enableElement($el, $reset)
    }
    $form.bind('DOMNodeRemoved cocoon:after-remove', onRemoved)

    var onReset = function(e) {
      disableElement($el, $reset)
    }
    $form.on('reset', onReset)

    var onChange = function(ev) {
      var target = ev.target

      if (target.type === 'file' || target.type === 'textarea') {
        $form.data('changed', true)
      }

      $form.data('changed') || $form.data('initialValues') !== $form.serialize()
        ? enableElement($el, $reset)
        : disableElement($el, $reset)
    }

    disableElement($el, $reset)
    $form.data('initialValues', $form.serialize())
    $form.on('change keyup paste', 'textarea, :input', onChange)
  })
})
