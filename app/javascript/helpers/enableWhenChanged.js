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

const initFormOnPresent = ($el) => {
  const $form = $el.closest('form')

  const onChange = function(ev) {
    ev.target.value.length > 0 ? $el.prop('disabled', false) : $el.prop('disabled', true)
  }

  $form.on('change keyup paste', 'textarea, :input', onChange)
}

const initFormOnChange = ($el) => {
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
    find('[data-enableWhenPresent]').
    each( (i, l) => initFormOnPresent($(l)) )
  $scope.
    find('[data-enableWhenChanged]').
    each( (i, l) => initFormOnChange($(l)) )
}

export default initialHandler
