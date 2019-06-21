import React from 'react'
import PropTypes from 'prop-types'
import { Textarea } from 'components/styles/TextareaWithoutBorder'
import autosize from 'autosize'

class NewCardTitleEditor extends React.Component {
  onKeyDown = e => {
    if (e.keyCode == 27) {
      this.props.onCancel()
      e.preventDefault()
    }

    if (e.keyCode == 13) {
      if (this.getValue().length > 0 ) {
        this.props.onSubmit(this.getValue())
      }
      e.preventDefault()
    }

    if (e.keyCode == 9) {
      if (this.getValue().length == 0) {
        this.props.onCancel()
      } else {
        this.props.onSubmit(this.getValue())
      }
      e.preventDefault()
    }
  }

  getValue = () => this.refInput.value
  setValue = value => (this.refInput.value = value)

  setRef = ref => this.refInput = ref

  componentDidMount() {
    autosize(this.refInput)
  }

  render() {
    const { value, onSubmit, onCancel } = this.props

    return (
      <Textarea
        ref={this.setRef}
        onKeyDown={this.onKeyDown}
        defaultValue={value}
        rows={5}
        minRows={5}
        maxRows={50}
        autoFocus
      />
    )
  }
}

NewCardTitleEditor.propTypes = {
  onCancel: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  value: PropTypes.string.isRequired,
}

NewCardTitleEditor.defaultProps = {
  value: '',
}

export default NewCardTitleEditor
