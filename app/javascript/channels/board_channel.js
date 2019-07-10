import consumer from "./consumer"
import onlineStatus from 'helpers/onlineStatus'

export const createSubscription = ({boardId, updateBoard}) => {
  const actions = {
    connected: function() {
      onlineStatus('connected')
    },

    disconnected: function() {
      onlineStatus('disconnected')
    },

    received: function(data) {
      updateBoard(data)
    }
  }

  consumer.subscriptions.create( { channel: "BoardChannel", id: boardId }, actions );
}
