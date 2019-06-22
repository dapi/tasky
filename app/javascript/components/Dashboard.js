import React from 'react'
import PropTypes from 'prop-types'
import { withTranslation } from 'react-i18next'
import '../helpers/i18n'

import Board from 'react-trello/src'
import Card from './Card'
import NewCard from './NewCard'
import NewLane from './NewLane'
import { showCardModal } from 'helpers/cardModal'

import {
  apiAddCard,
  apiAddLane,
  apiDeleteCard,
  apiDeleteLane,
  apiMoveCardAcrossLanes,
  apiMoveLane,
  apiUpdateLane,
} from 'helpers/requestor'

const Dashboard = ({ t, data }) => {
  const handleLaneAdd = (lane) => apiAddLane(data.board.id, lane)
  const handleLaneDelete = laneId => apiDeleteLane(data.board.id, laneId)
  const handleCardClick = (cardId, metadata, laneId) => showCardModal(cardId)
  const handleLaneMove = (removedIndex, addedIndex, lane) => apiMoveLane(lane.id, addedIndex)
  const handleLaneUpdate = (laneId, params) => apiUpdateLane(laneId, params)

  return (
    <Board
      data={data}
      style={{ backgroundColor: 'white' }}
      t={t}
      tagStyle={{ fontSize: '80%' }}
      onLaneAdd={handleLaneAdd}
      onLaneDelete={handleLaneDelete}
      onLaneUpdate={handleLaneUpdate}
      onCardClick={handleCardClick}
      onCardAdd={apiAddCard}
      onCardDelete={apiDeleteCard}
      onCardMoveAcrossLanes={apiMoveCardAcrossLanes}
      handleLaneDragEnd={handleLaneMove}
      NewCard={NewCard}
      NewLane={NewLane}
      Card={Card}
      inlineEditLaneTitle
      customCardLayout
      cardDeletable={false}
      draggable
      editable
      canAddLanes
      addLaneMode
      leanDraggable
    />
  )
}

export default withTranslation()(Dashboard)
