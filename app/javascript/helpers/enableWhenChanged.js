function enableElement($el, $reset) {
  $el.prop('disabled', false)
  $el.removeClass('btn-default')
  $el.addClass('btn-primary')
  $reset.removeClass('hidden')
}

function disableElement($el, $reset) {
  $el.prop('disabled', true)
  $el.removeClass('btn-primary')
  $el.addClass('btn-default')
  $reset.addClass('hidden')
}

$(document).ready(function() {
  var changeListeners = $('[data-enable-when-changed=true]')
  var presendListeners = $('[data-enable-when-presend]')

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

  presendListeners.each(function(index) {
    const listener = presendListeners[index]
    var $el = $(listener)
    var $form = $el.closest('form')
    var $reset = $form.find(':reset')
    var onChange = function(ev) {
      var target = ev.target

      if (target.type === 'file' || target.type === 'textarea') {
        $form.data('changed', true)
      }

      $form.data('changed')
        ? enableElement($el, $reset)
        : disableElement($el, $reset)
    }

    $form.on('change keyup paste', 'textarea, :input', onChange)
  })
})
