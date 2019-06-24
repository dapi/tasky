import consumer from "./consumer"
import onlineStatus from 'helpers/onlineStatus'

export const createSubscription = ({boardId, updateData}) => {
  const actions = {
    connected: function() {
      onlineStatus('connected')
    },

    disconnected: function() {
      onlineStatus('disconnected')
    },

    received: function(data) {
      updateData(data)
    }
  }

  consumer.subscriptions.create( { channel: "BoardChannel", id: boardId }, actions );
}
