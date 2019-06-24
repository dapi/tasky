import React from 'react'
import PropTypes from 'prop-types'
import { Textarea } from 'components/styles/Textarea'
import autosize from 'autosize'
import ClickOutside from 'react-click-outside'

import Footer from './Footer'

class CardDetailsEditor extends React.Component {
  onBlur = event => {
    this.save()
  }

  onFocus = e => e.target.select()

  onKeyDown = e => {
    if (e.keyCode == 27) {
      e.preventDefault()
      e.stopPropagation()
      this.cancel()
    }
  }

  cancel = () => {
    this.setValue('')
    this.props.onCancel()
    this.refInput.blur()
  }

  getValue = () => this.refInput.value
  setValue = value => (this.refInput.value = value)

  save = () => {
    if (this.getValue() != this.props.value) {
      this.props.onSave(this.getValue())
    }
  }

  focus = () => this.refInput.focus()

  setRef = ref => this.refInput = ref

  onSubmit = () => {
    this.save()
    this.props.onClose()
  }

  componentDidMount() {
    autosize(this.refInput)
  }

  onClickOutside = () => {
    this.save()
    this.props.onClose()
  }

  render() {
    const { value, onClose } = this.props

    return (
      <ClickOutside onClickOutside={this.onClickOutside}>
        <Textarea
          ref={this.setRef}
          onKeyDown={this.onKeyDown}
          onFocus={this.onFocus}
          defaultValue={value}
          rows={5}
          minRows={5}
          maxRows={50}
          async
          autoFocus
        />
        <Footer onSubmit={this.onSubmit} onCancel={onClose} />
      </ClickOutside>
    )
  }
}

CardDetailsEditor.propTypes = {
  onClose: PropTypes.func.isRequired,
  onSave: PropTypes.func.isRequired,
  value: PropTypes.string.isRequired,
}

CardDetailsEditor.defaultProps = {
  value: '',
}

export default CardDetailsEditor
