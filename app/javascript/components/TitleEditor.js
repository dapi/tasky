import React from 'react'
import PropTypes from 'prop-types'
import { Textarea } from 'styles/Textarea'
import autosize from 'autosize'

class TitleEditor extends React.Component {
  onFocus = e => e.target.select()

  // This is the way to select all text if mouse clicked
  onMouseDown = (e) => {
    if (document.activeElement != e.target) {
      e.preventDefault()
      this.refInput.focus()
    }
  }

  onBlur = () => this.save()

  onKeyDown = e => {
    if(e.keyCode === 13) {
      this.refInput.blur()
      e.preventDefault()
    }
    if (e.keyCode === 27) {
      this.cancel()
      e.stopPropagation()
      e.preventDefault()
    }

    if (e.keyCode === 9) {
      if (this.getValue().length == 0) {
        this.cancel()
      } else {
        this.refInput.blur()
      }
      e.preventDefault()
    }
  }

  cancel = () => {
    this.setValue(this.props.value)
    this.refInput.blur()
  }

  getValue = () => this.refInput.value
  setValue = value => (this.refInput.value = value)

  save = () => {
    if (this.getValue() != this.props.value) {
      this.props.onSave(this.getValue())
    }
  }

  setRef = ref => this.refInput = ref

  componentDidMount() {
    const callback = () => autosize(this.refInput)
     /*
        the defer is needed to:
          - force "autosize" to activate the scrollbar when this.props.maxRows is passed
          - support StyledComponents (see #71)
      */
    setTimeout( callback, 100 )
  }

  render() {
    return (
      <Textarea
        ref={this.setRef}
        onKeyDown={this.onKeyDown}
        onBlur={this.onBlur}
        onFocus={this.onFocus}
        onMouseDown={this.onMouseDown}
        defaultValue={this.props.value}
        autoComplete="off"
        autoCorrect="off"
        autoCapitalize="off"
        spellCheck="false"
        dataGramm="false"
        rows={5}
        minRows={5}
        maxRows={50}
      />
    )
  }
}

TitleEditor.propTypes = {
  onSave: PropTypes.func.isRequired,
  value: PropTypes.string.isRequired,
  tabindex: PropTypes.number
}

TitleEditor.defaultProps = {
  value: '',
}

export default TitleEditor
