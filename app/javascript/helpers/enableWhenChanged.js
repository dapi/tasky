// Usage:
// = f.submit class: 'btn btn-primary', data: { enableWhenChanged: true}

function enableElement($submit, $reset) {
  $submit.prop('disabled', false)
  $reset.removeClass('invisible')
  $reset.fadeIn('fast')
}

function disableElement($submit, $reset) {
  $submit.prop('disabled', true)
  $reset.removeClass('invisible')
  $reset.fadeOut('fast')
}

const initFormOnChange = ($submit) => {
  const $form = $submit.closest('form')

  const $reset = $form.find(':reset')

  // Например: удаление товара из заказа
  const onRemoved = function(e) {
    enableElement($submit, $reset)
  }
  $form.bind('DOMNodeRemoved cocoon:after-remove', onRemoved)

  const onReset = function(e) {
    disableElement($submit, $reset)
  }
  $form.on('reset', onReset)

  const onChange = function(ev) {
    const target = ev.target

    if (target.type === 'file' || target.type === 'textarea') {
      $form.data('changed', true)
    }

    $form.data('changed') || $form.data('initialValues') !== $form.serialize()
    ? enableElement($submit, $reset)
    : disableElement($submit, $reset)
  }

  disableElement($submit, $reset)
  $form.data('initialValues', $form.serialize())
  $form.on('change keyup paste', 'textarea, :input', onChange)
}

const initialHandler = function($scope) {
  $scope.
    find('[data-enableWhenChanged]').
    each( (i, l) => initFormOnChange($(l)) )
}

export default initialHandler
