import Rails from '@rails/ujs'
class CardModal {
  mount = () => {
    this.$cardModal = $('#cardModal')
    this.$content = this.$cardModal.find('.modal-content')
    this.$cardModal.on('hidden.bs.modal', () => this.$content.html(''))
  }

  umount = () => { }

  successHandler = (data) => {
    this.$content.html('<div class="modal-body"/>')
    this.$content.children().html($(data.body).children())
    ReactRailsUJS.mountComponents(this.$content)
  }

  show = (cardId) => {
    Rails.ajax({
      url: `/cards/${cardId}`,
      type: 'get',
      success: this.successHandler,
      error: data => {
        alert(data)
      },
    })
    this.$cardModal.modal()
  }
}

const cardModal = new CardModal

export default cardModal
