// Stolen from https://gist.github.com/AshikNesin/e44b1950f6a24cfcd85330ffc1713513

import React from 'react'
import PropTypes from 'prop-types'

import { apiCreateTaskAttachment } from 'helpers/requestor'

const BODY_DRAG_CLASS = 'on-dragging'

function buildFileSelector(){
  const fileSelector = document.createElement('input');
  fileSelector.setAttribute('type', 'file');
  fileSelector.setAttribute('multiple', 'multiple');
  return fileSelector;
}

class FileUpload extends React.Component {
  onChange = e => this.fileUpload(e.target.files)
  onDragEnd = (e) => {
    this.body.className = ''
    console.log('onDragEnd', e)
  }
  onDragStart = (e) => {
    this.body.className = 'on-dragging'
    console.log('onDragStart', e)
  }
  onDragEnter = (e) => {
    this.setState({dragEnter: this.state.dragEnter + 1})
  }
  onDragLeave = (e) => {
    this.setState({dragEnter: this.state.dragEnter - 1})
  }
  state = { isUploading: false, dragEnter: 0 }
  componentDidMount(){
    this.fileSelector = buildFileSelector();
    this.fileSelector.addEventListener('change', this.onChange)

    this.body = document.getElementsByTagName('body')[0]
    this.body.addEventListener('dragenter', this.onDragEnter)
    this.body.addEventListener('dragleave', this.onDragLeave)
    document.addEventListener('drag', this.onDragStart)
    document.addEventListener('dragend', this.onDragEnd)
    document.addEventListener("drag", function(event) {
      console.log('drag')
    })
  }

  handleFileSelect = (e) => {
    e.preventDefault();
    this.fileSelector.click();
  }

  fileUpload = (files) => {
    const { taskId} = this.props
    const url = 'http://example.com/file-upload';
    const formData = new FormData();
    for (var i = 0; i < files.length; i++) {
      formData.append('files[]',files[i])
    }
    this.setState({isUploading: true})
    const callback = () => {
      this.setState({isUploading: false})
    }
    apiCreateTaskAttachment(taskId, formData, callback)
  }

  render() {
    const { dragEnter, isUploading } = this.state
    let classNames = "btn btn-sm btn-wide btn-outline-secondary"
    if (isUploading) {
      classNames = classNames.concat(' disabled')
    }
    if (dragEnter) {
      document.body.classList.add(BODY_DRAG_CLASS);
    } else {
      document.body.classList.remove(BODY_DRAG_CLASS);
    }
    const title = isUploading ? this.props.uploadingTitle : this.props.title
    return (
      <a href='' className={classNames} onClick={this.handleFileSelect}>{title}</a>
    )
  }
}

FileUpload.propTypes = {
  taskId: PropTypes.string.isRequired,
  title: PropTypes.string.isRequired,
  uploadingTitle: PropTypes.string.isRequired
}

FileUpload.defaultProps = {
  title: 'Attach files',
  uploadingTitle: 'Uploading..'
}

export default FileUpload
