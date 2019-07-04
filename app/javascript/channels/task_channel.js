import consumer from "./consumer"

export const createSubscription = ({taskId, updateData}) => {
  const actions = {
    connected: function() {
      console.log('tasks connected')
    },

    disconnected: function() {
      console.log('tasks disconnected')
    },

    received: function(data) {
      updateData(data)
    }
  }

  consumer.subscriptions.create( { channel: "TaskChannel", id: taskId }, actions );
}
