import consumer from "./consumer"

export const createSubscription = (taskId, event, callback) => {
  const actions = {
    received: function(data) {
      if (data.event === event) {
        callback(data)
      }
    }
  }

  consumer.subscriptions.create( { channel: "TaskChannel", id: taskId }, actions );
}
