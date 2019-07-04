// Stolen from https://gist.github.com/AshikNesin/e44b1950f6a24cfcd85330ffc1713513

import React from 'react'
import PropTypes from 'prop-types'
import {fromEvent} from 'file-selector'
import { apiCreateTaskAttachment } from 'helpers/requestor'

const BODY_DRAG_CLASS = 'on-dragging'

function buildFileSelector(){
  const fileSelector = document.createElement('input');
  fileSelector.setAttribute('type', 'file');
  fileSelector.setAttribute('multiple', 'multiple');
  return fileSelector;
}

class FileUpload extends React.Component {
  state = { isUploading: false, dragEnter: 0 }
  onChange = async e => this.fileUpload(await fromEvent(e))
  onDragEnter = e => this.setState({dragEnter: this.state.dragEnter + 1})
  onDragLeave = e => this.setState({dragEnter: this.state.dragEnter - 1})
  onDrop = (e) => {
    e.preventDefault()
    let dt = e.dataTransfer
    let files = dt.files
    console.log(files);

    ([...files]).forEach( file => this.fileUpload([file]))
  }
  componentDidMount(){
    this.fileSelector = buildFileSelector();
    this.fileSelector.addEventListener('change', this.onChange)

    this.body = document.getElementsByTagName('body')[0]
    this.body.addEventListener('dragenter', this.onDragEnter)
    this.body.addEventListener('dragleave', this.onDragLeave)

    // By default, data/elements cannot be dropped in other elements. To allow a drop, we must prevent the default handling of the element
    document.addEventListener("dragover", e => e.preventDefault())
    // document.addEventListener('drop', this.onDrop)

    document.addEventListener('drop', async evt => {
      evt.preventDefault()
      this.onDragLeave()
      const files = await fromEvent(evt)
      this.fileUpload(files)
    })
  }

  handleFileSelect = (e) => {
    e.preventDefault();
    this.fileSelector.click();
  }

  fileUpload = (files) => {
    const { taskId} = this.props
    this.setState({isUploading: true})
    const formData = new FormData();

    files.forEach( file => formData.append('files[]',file))
    console.log('fileUpload', files, formData)

    for(var pair of formData.entries()) {
      console.log(pair[0]+ ', '+ pair[1]);
    }
    for (var value of formData.values()) {
      console.log(value);
    }
    const callback = () => this.setState({isUploading: false})
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
