import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Select from 'react-select';

import { apiReplaceCardMemberships } from 'helpers/requestor'

const filterColors = inputValue => {
  return colourOptions.filter(i =>
                              i.label.toLowerCase().includes(inputValue.toLowerCase())
                             );
}

function formatOptionLabel({ avatar_url, label }) {
  return (
    <div style={{ alignItems: 'center', display: 'flex' }}>
      <img style={{ borderRadius: '50%', marginRight: '0.5em' }} width={24} height={24} src={avatar_url}/>
      <span style={{ fontSize: 14 }}>{label}</span>
    </div>
  );
}

class MembersSelector extends Component {
  render() {
    const { boardId, cardId, availableUsers, defaultUsers } = this.props

    const onChange = (options) => {
      const ids = (options || []).map( ({id}) => id )
      apiReplaceCardMemberships(cardId, ids)
    }

    return <Select
      isMulti
      isClearable={false}
      controlShouldRenderValue={true}
      openMenuOnFocus={true}
      getOptionValue={({id}) => id}
      closeMenuOnSelect
      hideSelectedOptions={false}
      backspaceRemovesValue={false}
      formatOptionLabel={formatOptionLabel}
      onChange={onChange}
      defaultValue={defaultUsers}
      options={availableUsers}
    />
    }
}

export default MembersSelector;
