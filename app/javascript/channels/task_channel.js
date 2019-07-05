import consumer from "./consumer"

export const createSubscription = ({taskId, updateTask}) => {
  const actions = {
    connected: function() {
      console.log('tasks connected')
    },

    disconnected: function() {
      console.log('tasks disconnected')
    },

    received: function(data) {
      if (data.event === 'update_task') {
        updateTask(data)
      } else {
        console.log('data.event', data)
      }
    }
  }

  consumer.subscriptions.create( { channel: "TaskChannel", id: taskId }, actions );
}
