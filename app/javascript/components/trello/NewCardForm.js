import React, { Component } from 'react'
import PropTypes from 'prop-types'
import {
  CardHeader,
  CardRightContent,
  CardTitle,
  CardWrapper,
  Detail,
} from 'styles/Base'
import { AddButton, CancelButton } from 'styles/Elements'
import NewCardTitleEditor from './NewCardTitleEditor'
import ClickOutside from 'react-click-outside'

class NewCard extends Component {
  handleSubmitButton = event => {
    if (this.getValue().length > 0) {
      this.submit()
    } else {
      // TODO flash button
      event.preventDefault()
      this.refInput.focus()
    }
  }

  setRef = ref => this.refInput = ref

  submit = () => this.props.onAdd({ title: this.getValue() })

  getValue = () => this.refInput.getValue()

  onClickOutside = () => {
    if (this.getValue().length > 0) {
      this.submit()
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
            <NewCardTitleEditor
              ref={this.setRef}
              onCancel={this.props.onCancel}
              onSubmit={this.submit}
            />
          </CardTitle>
        </CardWrapper>
        <button
          className="btn btn-primary btn-sm"
          onClick={this.handleSubmitButton}
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
