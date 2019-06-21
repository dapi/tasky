import styled, { css } from 'styled-components'

// import TextareaAutosize from 'react-autosize-textarea'

//
// Этот компонент меньше по размеру и не имеет зависимостей, но имеет проблемы при переподключении после обновления через turbolinks
// приходилось решат так:
// = link_to board_path(card.board), class: 'icon-link icon-lg dialog-close-button', data: { turbolinks: false, 'card-modal-close': true }, title: 'Закрыть' do
//
// import TextareaAutosize from 'react-textarea-autosize'

export const Textarea = styled.textarea`
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
    background-color: white;
  }
`

