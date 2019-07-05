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

function preventDefaults (e) {
  e.preventDefault()
  e.stopPropagation()
}

function highlight(e) {
  document.body.classList.add(BODY_DRAG_CLASS);
}
function unhighlight(e) {
  document.body.classList.remove(BODY_DRAG_CLASS);
}
class FileUpload extends React.Component {
  state = { isUploading: false }
  onChange = async e => this.fileUpload(await fromEvent(e))
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

    const dropArea = this.body;

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach( eventName => dropArea.addEventListener(eventName, preventDefaults, false));
    ['dragenter', 'dragover'].forEach( eventName => dropArea.addEventListener(eventName, highlight, false));
    ['dragleave', 'drop'].forEach(eventName => dropArea.addEventListener(eventName, unhighlight, false));

    dropArea.addEventListener('drop', async evt => {
      evt.preventDefault()
      this.fileUpload( await fromEvent(evt))
    })
  }

  handleFileSelect = (e) => {
    e.preventDefault();
    this.fileSelector.click();
  }

  // TODO Support multiple ansychonous performs
  //
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
    const { isUploading } = this.state
    let classNames = "btn btn-sm btn-wide btn-outline-secondary"
    if (isUploading) {
      classNames = classNames.concat(' disabled')
    }
    const title = isUploading ? this.props.uploadingTitle : this.props.title
    return (
      <a href='' className={classNames} onClick={this.handleFileSelect}>{title}</a>
    )
  }
}

FileUpload.propTypes = {
  taskId: PropTypes.string.isRequired,
  welcomeTitle: PropTypes.string,
  title: PropTypes.string,
  uploadingTitle: PropTypes.string
}

FileUpload.defaultProps = {
  welcomeTitle: 'Drop here..',
  title: 'Attach files',
  uploadingTitle: 'Uploading..'
}

export default FileUpload
