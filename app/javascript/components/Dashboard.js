import React from "react"
import PropTypes from "prop-types"
import Board from 'react-trello'
import axios from 'axios'

let eventBus = undefined
window.setEventBus = (handle) => {
	eventBus = handle
}

const handlerAjaxError = (response) => {
	if (error.response) {
		// The request was made and the server responded with a status code
		// that falls out of the range of 2xx
		console.log(error.response.data);
		console.log(error.response.status);
		console.log(error.response.headers);
	} else if (error.request) {
		// The request was made but no response was received
		// `error.request` is an instance of XMLHttpRequest in the browser and an instance of
		// http.ClientRequest in node.js
		console.log(error.request);
	} else {
		// Something happened in setting up the request that triggered an Error
		console.log('Error', error.message);
	}
	console.log(error.config);
	alert(error);
}

const requestor = axios.create({
	withCredentials: true,
	baseURL: 'http://api.3006.brandymint.ru/v1',
	headers: {
		'Content-Type': 'application/vnd.api+json'
	}
})

class Dashboard extends React.Component {
	constructor(props) {
		super(props);
		// this.state = {isToggleOn: true};
		this.handleCardAdd = this.handleCardAdd.bind(this)
		this.handleLaneAdd = this.handleLaneAdd.bind(this)
		this.handleCardDelete = this.handleCardDelete.bind(this)
	}
	handleCardAdd(card, laneId) {
    requestor
    .post(
      '/cards',
      {
        lane_id: laneId,
        title: card.title
      })
    .catch(handlerAjaxError)
	}
  handleCardDelete(cardId, laneId) {
    debugger
	}
	handleLaneAdd(params) {
    requestor
    .post(
      '/lanes',
      {
        board_id: this.props.data.board.id,
        title: params.title
      })
    .catch(handlerAjaxError)
	}
	render () {
    // onCardAdd={this.handleCardAdd}
		return <Board
			data={this.props.data}
			tagStyle={{fontSize: '80%'}}
			onLaneAdd={this.handleLaneAdd}
			onCardDelete={this.handleCardDelete}
			eventBusHandle={setEventBus}
			draggable
			editable
			canAddLanes
			addLaneMode
			leanDraggable
		/>
	}
}

export default Dashboard
