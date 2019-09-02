// TODO use rails-ujs and move to webpack
export default (el) => {
  $el = $(el.target)
  t = $el.data('remove')
  $(el.target).closest(t).fadeOut()
}
