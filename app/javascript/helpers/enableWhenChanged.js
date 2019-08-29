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

const initForm = ($el) => {
  const $form = $el.closest('form')

  const $reset = $form.find(':reset')

  // Например: удаление товара из заказа
  const onRemoved = function(e) {
    enableElement($el, $reset)
  }
  $form.bind('DOMNodeRemoved cocoon:after-remove', onRemoved)

  const onReset = function(e) {
    disableElement($el, $reset)
  }
  $form.on('reset', onReset)

  const onChange = function(ev) {
    const target = ev.target

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
}

const initialHandler = function($scope) {
  $scope.
    find('[data-enableWhenChanged]').
    each( (i, l) => initForm($(l)) )
}

export default initialHandler
