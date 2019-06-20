import React from 'react'
import PropTypes from 'prop-types'
import InlineInput from 'react-trello/src/components/widgets/InlineInput'
import { request } from 'helpers/requestor'

class InlineEditor extends React.Component {
  onSave = value => {
    const { url, attribute } = this.props
    request('put', url, {[attribute]: value})
  }
  render() {
    const { value, resize, type } = this.props

    return (
      <InlineInput
        border
        onSave={this.onSave}
        placeholder="Заголовок"
        value={value}
        resize={resize}
      />
    )
  }
}

InlineEditor.propTypes = {
  url: PropTypes.string,
  placeholder: PropTypes.string,
  attribute: PropTypes.string,
  value: PropTypes.string,
  resize: PropTypes.oneOf(['none', 'vertical', 'horizontal']),
}

InlineEditor.defaultProps = {
  placeholder: 'Кликните чтобы изменить',
  value: '',
  resize: 'none',
}

export default InlineEditor
