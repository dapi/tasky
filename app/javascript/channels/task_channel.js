import consumer from "./consumer"

export const createSubscription = (taskId, event, callback) => {
  const actions = {
    connected: function() {
      console.log('tasks connected')
    },

    disconnected: function() {
      console.log('tasks disconnected')
    },

    received: function(data) {
      if (data.event === event) {
        callback(data)
      }
    }
  }

  consumer.subscriptions.create( { channel: "TaskChannel", id: taskId }, actions );
}
