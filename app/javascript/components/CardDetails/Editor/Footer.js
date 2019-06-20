import React from 'react'
import PropTypes from 'prop-types'
import { withTranslation } from 'react-i18next'

class Footer extends React.Component {
  render() {
    const { onSubmit, onCancel, t } = this.props
    return (
      <div>
        <button className="btn btn-primary btn-sm" onClick={onSubmit}>
          Сохранить
        </button>
        <button onClick={onCancel} className="btn btn-sm ml-2">
          <i className="ion ion-md-close icon-lg" />
        </button>
      </div>
    )
  }
}

Footer.propTypes = {
  onCancel: PropTypes.func.isRequired,
  t: PropTypes.func.isRequired,
}

Footer.defaultProps = {
  onSubmit: () => {},
}

export default withTranslation()(Footer)
