import React from 'react'
import {NewLaneSection} from 'rt/styles/Base'
import styled from 'styled-components'

export const Parent = styled.div`
  text-align: center;
  margin-top: 5px;
`
export const AddLaneLink = styled.span`
  width: 200px;
  border-radius: 3px;
  border: none;
  margin: 0 auto;
  height: auto;
  flex-direction: column;
  text-align: center;

  background-color: var(--primary);
  color: #fff;
  transition: background 0.3s ease;
  min-height: 32px;
  padding: 4px 16px;
  line-height: 30px;
  font-size: 13px;
  cursor: pointer;

  display: inline-block;
  vertical-align: middle;
  &:hover {
    background-color: #0068e8;
  }
`

export default ({t, onClick}) => (
  <Parent>
    <AddLaneLink t={t} onClick={onClick}>
      {t('Add another lane')}
    </AddLaneLink>
  </Parent>
)
