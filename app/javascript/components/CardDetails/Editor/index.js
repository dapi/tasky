import Editor from './Editor'
import { connect } from 'react-redux'
import { apiUpdateCard } from 'helpers/requestor'

const stateMapping = ({ details }) => {
  return { value: details }
}

const saveCard = (id, data) => {
  return dispatch => {
    dispatch({ type: 'card/saving' })
    const callback = response => {
      const { data } = response
      dispatch({
        type: 'card/update',
        card: { ...data.data.attributes, id: data.data.id },
      })
      return response
    }
    apiUpdateCard(id, data, callback)
  }
}

const mapDispatchToProps = (dispatch, { id }) => {
  return {
    onSave: value => {
      return dispatch(saveCard(id, { details: value }))
    },
  }
}

export default connect(
  stateMapping,
  mapDispatchToProps
)(Editor)
