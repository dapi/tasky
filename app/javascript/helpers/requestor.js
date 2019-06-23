import axios from 'axios'

import ajaxErrorHandler from './ajaxErrorHandler'

const requestor = axios.create({
  withCredentials: true,
  baseURL: '/api/v1',
  headers: {
    'Content-Type': 'application/vnd.api+json',
  },
})

const defaultCallback = response => response

export const request = (method, url, params = {}, callback = defaultCallback) => {
  NProgress.start()
  requestor
    .request({ method: method, url: url, params: params })
    .then(callback)
    .catch(ajaxErrorHandler)
    .finally(NProgress.done)
}

export const apiAddCard = (card, laneId) => {
  request('post', `/cards`, {
    id: card.id,
    lane_id: laneId,
    title: card.title,
  })
}

export const apiDeleteCard = (cardId, laneId) => {
  request('delete', `/cards/${cardId}`)
}

export const apiAddLane = (lane) => {
  request('post', `/lanes`, lane)
}

export const apiDeleteLane = (laneId) => {
  request('delete', `/lanes/${laneId}`)
}

export const apiMoveCardAcrossLanes = (
  fromLaneId,
  toLaneId,
  cardId,
  addedIndex
) => {
  request('put', `/cards/${cardId}/move_across`, {
    to_lane_id: toLaneId,
    from_land_id: fromLaneId,
    index: addedIndex,
  })
}

export const apiMoveLane = (laneId, addedIndex) => {
  request('put', `/lanes/${laneId}/move`, { index: addedIndex })
}

export const apiAddTaskComment = (taskId, commentId, content) => {
  request('post', `/task_comments`, {
    id: commentId,
    task_id: taskId,
    content: content,
  })
}

export const apiUpdateLane = (laneId, data) => {
  request('put', `/lanes/${laneId}`, data)
}

export const apiUpdateCard = (cardId, data, callback) => {
  request('put', `/cards/${cardId}`, data, callback)
}
