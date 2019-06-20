import React from 'react'
import PropTypes from 'prop-types'
import Editor from './Editor'
import { withTranslation } from 'react-i18next'
import { connect } from 'react-redux'

class CardDetails extends React.Component {
  state = {
    isEditing: false,
  }

  onClose = () => {
    this.setState({ isEditing: false })
  }

  onOpen = e => {
    this.setState({ isEditing: true })
    e.preventDefault()
  }

  renderPreview() {
    const { formatted_details, placeholder } = this.props

    if (formatted_details.length > 0) {
      return (
        <div
          onClick={this.onOpen}
          className="card-edit-details"
          dangerouslySetInnerHTML={{ __html: formatted_details }}
        />
      )
    } else {
      return (
        <div
          onClick={this.onOpen}
          className="card-edit-details card-details-placeholder"
        >
          {placeholder}
        </div>
      )
    }
  }

  renderEditor() {
    const { value, id } = this.props
    return <Editor id={id} onClose={this.onClose} value={value} />
  }

  render() {
    const { isEditing } = this.state
    if (isEditing) {
      return this.renderEditor()
    } else {
      return this.renderPreview()
    }
  }
}

CardDetails.propTypes = {
  url: PropTypes.string,
  value: PropTypes.string,
  formatted_details: PropTypes.string,
}

CardDetails.defaultProps = {
  placeholder: 'Кликните чтобы изменить',
  value: '',
  formatted_details: '',
}

export default connect(state => state)(withTranslation()(CardDetails))
