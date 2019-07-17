import React from 'react'
import {NewLaneSection} from 'rt/styles/Base'
import styled from 'styled-components'

export const AddLaneLink = styled.button`
  width: 200px;
  border-radius: 3px;
  border: none;
  margin: 5px 0 0 0;
  position: relative;
  display: inline-flex;
  height: auto;
  flex-direction: column;

  background-color: var(--primary);
  color: #fff;
  transition: background 0.3s ease;
  min-height: 32px;
  padding: 4px 16px;
  vertical-align: middle;
  line-height: 30px;
  font-size: 13px;
  cursor: pointer;
  &:hover {
    background-color: #0068e8;
  }
  `

export default ({t, onClick}) => (
  <AddLaneLink t={t} onClick={onClick}>{t('Add another lane')}</AddLaneLink>
)
