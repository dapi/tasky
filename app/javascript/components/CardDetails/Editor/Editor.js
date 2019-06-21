import React from 'react'
import PropTypes from 'prop-types'
import { Textarea } from 'components/styles/Textarea'
import Footer from './Footer'
import autosize from 'autosize'

class CardDetailsEditor extends React.Component {
  onBlur = event => {
    this.save()
  }

  onFocus = e => e.target.select()

  onKeyDown = e => {
    if (e.keyCode == 27) {
      this.cancel()
      e.preventDefault()
    }

    if (e.keyCode == 9) {
      if (this.getValue().length == 0) {
        this.cancel()
      } else {
        this.save()
      }
      e.preventDefault()
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

  render() {
    const { value, onSave, onClose } = this.props

    return (
      <div>
        <Textarea
          ref={this.setRef}
          onKeyDown={this.onKeyDown}
          onBlur={this.onSave}
          onFocus={this.onFocus}
          defaultValue={value}
          rows={5}
          minRows={5}
          maxRows={50}
          async
          autoFocus
        />
        <Footer onSubmit={this.onSubmit} onCancel={onClose} />
      </div>
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
