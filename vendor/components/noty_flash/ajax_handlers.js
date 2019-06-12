import NotyFlash from './NotyFlash'

// Хендлеры имеет смысл отдавать в AJAX-запросы следующим образом
//
//  xhr = $.ajax
//    fail: window.notyAjaxFailHanlder
//    error: window.notyAjaxErrorHandler response, message


export function notyAjaxErrorHandler(response) {

  // readyState Holds the status of the XMLHttpRequest.
  // 0: request not initialized
  // 1: server connection established
  // 2: request received
  // 3: processing request
  // 4: request finished and response is ready

	if (response.readyState == 0) { return }
  message = response.responseText || response.statusText
  // console.error?("Ошибка загрузки #{message}")
  NotyFlash.error(message)
}

export function notyAjaxFailHanlder(response) {
  if (response.readyState == 0) { return }
  // console.error?("Fail загрузки #{response}")
  NotyFlash.error(response)
}
