import React, { Component } from 'react'
import PropTypes from 'prop-types'
import {
  CardHeader,
  CardRightContent,
  CardTitle,
  CardWrapper,
  Detail,
} from './styles/Base'
import EditableLabel from 'react-trello/src/components/widgets/EditableLabel'
import { AddButton, CancelButton } from './styles/Elements'
import InlineTextarea from 'react-trello/src/components/widgets/InlineTextarea'
import ClickOutside from 'react-click-outside'

class NewCard extends Component {
  state = {}

  updateField = (field, value) => {
    this.setState({ [field]: value })
  }

  handleSubmit = event => {
    if (this.getValue().length > 0) {
      this.props.onAdd({ title: this.getValue() })
    } else {
      // TODO flash button
      event.preventDefault()
      this.refInput.focus()
    }
  }

  getValue = () => this.refInput.getValue()

  onSave = val => {
    this.updateField('title', val)
    this.props.onAdd({ title: val })
  }

  onClickOutside = () => {
    if (this.getValue().length > 0) {
      this.handleSubmit()
    } else {
      this.props.onCancel()
    }
  }

  render() {
    const { onCancel, t } = this.props

    return (
      <ClickOutside onClickOutside={this.onClickOutside}>
        <CardWrapper>
          <CardTitle>
            <InlineTextarea
              ref={ref => (this.refInput = ref)}
              placeholder={t('placeholder.title')}
              onCancel={this.props.onCancel}
              autoFocus
              autoResize
              resize="vertical"
            />
          </CardTitle>
        </CardWrapper>
        <button
          className="btn btn-primary btn-sm"
          onClick={this.handleSubmit.bind(this)}
        >
          {t('button.Add card')}
        </button>
        <CancelButton onClick={this.props.onCancel}>
          <i className="ion ion-md-close icon-lg" />
        </CancelButton>
      </ClickOutside>
    )
  }
}

NewCard.propTypes = {
  laneId: PropTypes.string.isRequired,
  onCancel: PropTypes.func.isRequired,
  onAdd: PropTypes.func.isRequired,
  t: PropTypes.func.isRequired,
}

export default NewCard
