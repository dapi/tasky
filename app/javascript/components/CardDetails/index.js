import React from 'react'
import ReactDOM from 'react-dom'
import 'helpers/i18n'

import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import { configureStore } from 'redux-starter-kit'
import { createSlice } from 'redux-starter-kit'

import CardDetails from './CardDetails'

const CardDetailsApp = props => {
  const slice = createSlice({
    slice: 'card',
    initialState: props.card,
    reducers: {
      init: (state, { card }) => card,
      update: (state, action) => {
        return { ...state, ...action.card }
      },
    },
  })
  const store = createStore(slice.reducer, applyMiddleware(thunk))
  return (
    <Provider store={store}>
      <CardDetails />
    </Provider>
  )
}
export default CardDetailsApp
