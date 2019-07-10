import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withTranslation } from 'react-i18next'
import '../helpers/i18n'

import Board from 'react-trello/src'
import Card from './Card'
import NewCard from './NewCard'
import NewLane from './NewLane'
import { showCardModal } from 'helpers/cardModal'

import { createSubscription as createBoardSubscription } from 'channels/board_channel'

import {
  apiAddCard,
  apiAddLane,
  apiDeleteCard,
  apiDeleteLane,
  apiMoveCardAcrossLanes,
  apiMoveLane,
  apiUpdateLane,
  apiGetPresentedBoard
} from 'helpers/requestor'

const NOT_FOUND_CARD = {
  attributes: { title: 'CARD NOT FOUND' }
}

const PLUR = {
  card: 'cards',
  lane: 'lanes'
}

const parseIncluded = included => {
  const records = {}
  included.forEach( record => {
    const plur = PLUR[record.type]
    const objects = records[plur] || {}
    objects[record.id] = { id: record.id, ...record}
    records[plur] = objects
  })
  return records
}

const addCards = (cards, newRecords) => {
  (newRecords || []).forEach( ({data}) => {
    cards[data.id] = { id: data.id, ...data }
  })
  return cards
}

class Dashboard extends Component {
  constructor(props) {
    super(props)
    this.state = {...parseIncluded(props.data.included), lanes: props.data.data }
  }

  fetchData = () => apiGetPresentedBoard(this.props.boardId, (data) => this.updateBoard(data.data))

  updateBoard = (data) => {
    const included = parseIncluded(data.included)
    const lanes = data.data.relationships.ordered_alive_lanes.data.map( ({id}) => included.lanes[id])
    this.setState({...this.state, cards: addCards(this.state.cards, data.cards), lanes: lanes})
  }

  updateCard = (data) => {
    console.log('updateCard', data)
  }

  componentDidMount() {
    createBoardSubscription({
      boardId: this.props.boardId,
      updateCard: this.updateCard,
      updateLane: this.updateLane,
      updateBoard: this.updateBoard // update board's title, members and lanes ordering
    })
  }

  componentWillUnmount() {
    // TODO: Unsubscribe
  }

  render () {
    const { t, boardId } = this.props
    const { lanes, cards } = this.state
    const handleLaneAdd = (lane) => apiAddLane({ board_id: boardId, ...lane})
    const handleLaneDelete = laneId => apiDeleteLane(laneId)
    const handleCardClick = (cardId, metadata, laneId) => showCardModal(cardId)
    const handleLaneMove = (removedIndex, addedIndex, lane) => apiMoveLane(lane.id, addedIndex)
    const handleLaneUpdate = (laneId, params) => apiUpdateLane(laneId, params)

    const data = {
      board: { id: boardId },
      lanes: this.state.lanes.map( ({id, attributes, relationships}) => {
        return {
          id,
          title: attributes.title,
          cards: relationships.ordered_alive_cards.data.map( ({id}) => ({id, ...(cards[id] || NOT_FOUND_CARD).attributes}))
        }
      })
    }
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

Dashboard.propTypes = {
  boardId: PropTypes.string.isRequired,
  data: PropTypes.shape({
    data: PropTypes.array.isRequired,
    included: PropTypes.array.isRequired
  })
}

export default withTranslation()(Dashboard)
