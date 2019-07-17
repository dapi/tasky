import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { LaneTitle, NewLaneButtons, Section } from 'styles/Base'
import { AddButton, CancelButton } from 'styles/Elements'
import InlineTextarea from 'widgets/InlineTextarea'
import ClickOutside from 'react-click-outside'

class NewLane extends Component {
  handleSubmit = () => {
    this.props.onAdd({ title: this.getValue() })
  }

  getValue = () => this.refInput.getValue()

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
        <Section>
          <LaneTitle>
            <InlineTextarea
              ref={ref => (this.refInput = ref)}
              placeholder={t('placeholder.title')}
              onCancel={this.props.onCancel}
              onSave={this.handleSubmit}
              border
              autoFocus
            />
          </LaneTitle>
          <NewLaneButtons>
            <button
              className="btn btn-primary btn-sm"
              onClick={this.handleSubmit.bind(this)}
            >
              {t('button.Add lane')}
            </button>
            <CancelButton onClick={onCancel}>
              <i className="ion ion-md-close icon-lg" />
            </CancelButton>
          </NewLaneButtons>
        </Section>
      </ClickOutside>
    )
  }
}

NewLane.propTypes = {
  onCancel: PropTypes.func.isRequired,
  onAdd: PropTypes.func.isRequired,
  t: PropTypes.func.isRequired,
}

NewLane.defaultProps = {}

export default NewLane
