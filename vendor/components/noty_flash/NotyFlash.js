// Подключаем имено так, иначе в продакешне ошибка с ненайденной переменной `r`
import Noty from 'noty/lib/noty.min'

const TYPES = ['error', 'success', 'info', 'warning']
const TIMEOUT = 5000

const DEFAULT_TYPE = 'info'

const NotyFlash = {
  show: (message, type = DEFAULT_TYPE) => new Noty({
    text: message,
    timeout: TIMEOUT,
    type: type,
    theme: 'mint'
  }).
    show()
}

TYPES.forEach(
 (type) => {
  NotyFlash[type] = (message) => this.show(type, message)
}
)

export default NotyFlash
