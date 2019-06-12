import React from "react"
import PropTypes from "prop-types"
import { useTranslation, I18nextProvider } from 'react-i18next';

import i18n from '../helpers/i18n'

import Board from 'react-trello/src'
import { apiAddCard, apiAddLane, apiDeleteCard, apiDeleteLane, apiMoveCardAcrossLanes } from '../helpers/requestor'

const Dashboard = ({data}) => {
  const { t } = useTranslation()
  const handleLaneAdd = ({title}) => apiAddLane( data.board.id, title )
  const handleLaneDelete = (laneId) => apiDeleteLane( data.board.id, laneId )

  return (
    <I18nextProvider i18n={i18n}>
      <Board
        t={t}
        data={data}
        tagStyle={{fontSize: '80%'}}
        onLaneAdd={handleLaneAdd}
        onLaneDelete={handleLaneDelete}
        onCardAdd={apiAddCard}
        onCardDelete={apiDeleteCard}
        onCardMoveAcrossLanes={apiMoveCardAcrossLanes}
        draggable
        editable
        canAddLanes
        addLaneMode
        leanDraggable
      />
    </I18nextProvider>
  )
}

export default Dashboard
