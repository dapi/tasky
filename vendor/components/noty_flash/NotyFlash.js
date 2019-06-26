// Подключаем имено так, иначе в продакешне ошибка с ненайденной переменной `r`
import Noty from 'noty/lib/noty.min'
import 'animate.css'

const TYPES = ['error', 'success', 'info', 'warning']
const TIMEOUT = 5000

const DEFAULT_TYPE = 'info'

const NotyFlash = {
  show: (message, type = DEFAULT_TYPE) => new Noty({
    text: message,
    timeout: TIMEOUT,
    type: type,
    theme: 'mint',
    animation: {
        open: 'animated bounceInDown', // Animate.css class names
        close: 'animated bounceOutUp' // Animate.css class names
    }
  }).
    show()
}

TYPES.forEach(
 (type) => {
  NotyFlash[type] = (message) => this.show(type, message)
}
)

export default NotyFlash
