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
  request('post', `/tasks/${taskId}/comments`, {
    id: commentId,
    content: content,
  })
}

export const apiUpdateLane = (laneId, data) => {
  request('put', `/lanes/${laneId}`, data)
}

export const apiUpdateCard = (cardId, data, callback) => {
  request('put', `/cards/${cardId}`, data, callback)
}

export const apiReplaceCardMemberships = (cardId, accountMembershipIds) => {
  if (accountMembershipIds.length > 0 ) {
    request('put', `/card_memberships/`, { card_id: cardId, account_membership_ids: accountMembershipIds} )
  } else {
    request('put', `/card_memberships/`, { card_id: cardId, 'account_membership_ids[]': ''} )
  }
}

export const apiFetchBoardData = (boardId, callback) => {
  NProgress.start()
  axios({
    method: 'get',
    url: `/boards/${boardId}`,
    headers: {'X-Requested-With': 'XMLHttpRequest'},
    responseType: 'json',
    withCredentials: true
  })
  .then(function (response) {
    callback(response.data)
  })
  .catch(ajaxErrorHandler)
  .finally(NProgress.done)
}

export const apiDeleteTaskAttachment = (taskId, attachmentId) => {
  request('delete', `/tasks/${taskId}/attachments/${attachmentId}`)
}

export const apiCreateTaskAttachment = (taskId, formData, callback) => {
  NProgress.start()
  requestor
    .request({
      method: 'post',
      url: `/tasks/${taskId}/attachments`,
      data: formData,
      headers: { 'content-type': 'multipart/form-data' }
  })
  .catch(ajaxErrorHandler)
  .finally( () => {
    NProgress.done()
    callback()
  })
}
