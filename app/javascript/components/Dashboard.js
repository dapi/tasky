import React, { Component } from 'react'
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
  apiFetchBoardData
} from 'helpers/requestor'

const UPDATE_BOARD_EVENT = 'board:update'

export const updateBoardData = () => {
  console.log('updateBoardData')
  var event = new CustomEvent(UPDATE_BOARD_EVENT)
  document.dispatchEvent(event)
}

class Dashboard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      data: props.data
    }
  }

  fetchData = () => {
    apiFetchBoardData(this.props.data.board.id, (data) => this.setState({data: data}))
  }

  componentDidMount() {
    document.addEventListener(UPDATE_BOARD_EVENT, () => this.fetchData())
  }

  componentWillUnmount() {
    document.removeEventListener(UPDATE_BOARD_EVENT, () => this.fetchData())
  }

  render () {
    const { t } = this.props
    const { data } = this.state
    const handleLaneAdd = (lane) => apiAddLane({ board_id: data.board.id, ...lane})
    const handleLaneDelete = laneId => apiDeleteLane(laneId)
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
}

export default withTranslation()(Dashboard)
