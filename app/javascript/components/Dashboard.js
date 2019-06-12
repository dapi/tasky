import React from "react"
import PropTypes from "prop-types"
import { useTranslation, I18nextProvider } from 'react-i18next';

import i18n from '../helpers/i18n'

import Board from 'react-trello/src'
import { apiAddCard, apiAddLane, apiDeleteCard } from '../helpers/requestor'

let eventBus = undefined
window.setEventBus = (handle) => {
  eventBus = handle
}

const Dashboard = ({data}) => {
  const { t } = useTranslation()
  const handleLaneAdd = ({title}) => apiAddLane( data.board.id, title )

  return (
    <I18nextProvider i18n={i18n}>
      <Board
        t={t}
        data={data}
        tagStyle={{fontSize: '80%'}}
        onLaneAdd={handleLaneAdd}
        onCardAdd={apiAddCard}
        onCardDelete={apiDeleteCard}
        eventBusHandle={setEventBus}
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
