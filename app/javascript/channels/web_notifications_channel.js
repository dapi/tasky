import consumer from "./consumer"


// ActionCable.server.broadcast \
//   "web_notifications_#{current_user.id}", { title: 'New things!', body: 'All the news that is fit to print' }
//
//
consumer.subscriptions.create( "WebNotificationsChannel", {
  received: ({message}) => NotyFlash.show(message)
});
