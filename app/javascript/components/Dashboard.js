import React from "react"
import PropTypes from "prop-types"
import { withTranslation } from 'react-i18next'

import Board from 'react-trello/src'

import i18n from '../helpers/i18n'
import { apiAddCard, apiAddLane, apiDeleteCard, apiDeleteLane, apiMoveCardAcrossLanes } from '../helpers/requestor'

const Dashboard = ({t, data}) => {
  const handleLaneAdd = ({title}) => apiAddLane( data.board.id, title )
  const handleLaneDelete = (laneId) => apiDeleteLane( data.board.id, laneId )
  const handleCardClick = (cardId, metadata, laneId) => Turbolinks.visit(`/tasks/${cardId}/edit`)

  return (
      <Board
        data={data}
        t={t}
        tagStyle={{fontSize: '80%'}}
        onLaneAdd={handleLaneAdd}
        onLaneDelete={handleLaneDelete}
        onCardClick={handleCardClick}
        onCardAdd={apiAddCard}
        onCardDelete={apiDeleteCard}
        onCardMoveAcrossLanes={apiMoveCardAcrossLanes}
        draggable
        editable
        canAddLanes
        addLaneMode
        leanDraggable
      />
  )
}

export default withTranslation()(Dashboard)
