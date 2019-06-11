import axios from 'axios'

import ajaxErrorHandler from './ajaxErrorHandler'

const requestor = axios.create({
  withCredentials: true,
  baseURL: 'http://api.3006.brandymint.ru/v1',
  headers: {
    'Content-Type': 'application/vnd.api+json'
  }
})

export const apiAddCard = (card, laneId) => {
  requestor
  .post( '/cards', { lane_id: laneId, title: card.title })
  .catch(ajaxErrorHandler)
}

export const apiAddLane = (boardId, title) => {
  requestor
  .post( '/lanes', { board_id: boardId, title: title })
  .catch(handlerAjaxError)
}

export default requestor
