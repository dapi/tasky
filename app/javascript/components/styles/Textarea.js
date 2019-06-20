import styled, { css } from 'styled-components'
import TextareaAutosize from 'react-textarea-autosize'

export const TextArea = styled(TextareaAutosize)`
  overflow-x: hidden; /* for Firefox (issue #5) */
  word-wrap: break-word;
  min-height: 28px;
  max-height: 800px; /* optional, but recommended */
  resize: none;
  width: 100%;
  height: 28px;
  line-height: 20px;
  background-color: transparent;
  box-shadow: none;
  box-sizing: border-box;
  border-radius: 3px;
  border: 0;
  padding: 8px 12px;
  outline: 0;
  &:focus {
    box-shadow: inset 0 0 0 2px #0079bf;
    background-color: white;
  }
`
