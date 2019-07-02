import React from 'react'
import PropTypes from 'prop-types'
import TitleEditor from './TitleEditor'

import { request } from 'helpers/requestor'

// Used from Rails helpers to allow inline edit with ajax
// Replacement for best_in_edit gem
//
class TitleEditorController extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: props.value
    }
  }
  onSave = (value) => {
    const { url, attribute } = this.props
    const success = () => this.setState({value: value})
    request('put', url, {[attribute]: value}, success)
  }
  render() {
    const { tabindex } = this.props
    const { value } = this.state
    return <TitleEditor value={value} onSave={this.onSave} tabindex={tabindex} />
  }
}

TitleEditorController.propTypes = {
  value: PropTypes.string.isRequired,
  attribute: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
  tabindex: PropTypes.number,
}

export default TitleEditorController
