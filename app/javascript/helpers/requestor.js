import axios from 'axios'

import ajaxErrorHandler from './ajaxErrorHandler'

const requestor = axios.create({
  withCredentials: true,
  baseURL: 'http://api.3006.brandymint.ru/v1',
  headers: {
    'Content-Type': 'application/vnd.api+json'
  }
})

const request = (method, url, params = {}) => {
  NProgress.start()
  requestor
  .request({method: method, url: url, params: params})
  .catch(ajaxErrorHandler)
  .finally(NProgress.done)
}

export const apiAddCard = (card, laneId) => {
  request('post', `/lanes/${laneId}/tasks`, { title: card.title })
}

export const apiDeleteCard = (cardId, laneId) => {
  request('delete', `/lanes/${laneId}/tasks/${cardId}`)
}

export const apiAddLane = (boardId, title) => {
  request('post', `/boards/${boardId}/lanes`, { title: title })
}

export const apiDeleteLane = (boardId, laneId) => {
  request('delete', `/boards/${boardId}/lanes/${laneId}`)
}
