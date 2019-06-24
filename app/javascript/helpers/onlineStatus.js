// Available statuses:
// process, connected, disconnected
//
export default (status) => {
  const e = $('[data-online-status-badge]')
  e.data('status', status)
  e.attr('data-status', status)
  e.attr('title', status)
}
