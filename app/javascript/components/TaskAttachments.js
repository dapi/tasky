import React from 'react'
import PropTypes from 'prop-types'
import prettyBytes from 'pretty-bytes'

import { createSubscription } from 'channels/task_channel'
import { apiDeleteTaskAttachment } from 'helpers/requestor'

class TaskAttachments extends React.Component {
  constructor({attachments}) {
    super()
    this.state = { attachments, removedAttachments: [] }
  }
  componentDidMount() {
    const { taskId } = this.props
    createSubscription( taskId, 'update_task', this.updateTask)
  }
  componentWillUnmount() {
    // TODO: Unsubscribe
  }

  updateTask = (task) => {
    const { taskId } = this.props

    const attachments = task.included.filter( a => a.type === 'task_attachment' )
    this.setState({attachments})
  }

  render () {
    const { title } = this.props
    const { attachments } = this.state
    if (attachments.length == 0) {
      return null
    }

    const removeAttachment = (e, attachmentId) => {
      e.preventDefault()
      this.setState({removedAttachments: [ ...this.state.removedAttachments, attachmentId ]})
      apiDeleteTaskAttachment(this.props.taskId, attachmentId)
    }

    const attachmentsToShow = attachments.filter( a => !this.state.removedAttachments.includes(a.id) )
    return (
      <div className='row mt-4'>
        <div className='col-md-1'>
          <div className='text-muted' style={ {fontSize: '24px'}}>
            <i className="ion ion-md-attach"/>
          </div>
        </div>
        <div className='col-md-9'>
          <h4 className='text-muted card-dialog-subtitle'>{title} ({attachments.length})</h4>
          <ul className='list-unstyled'>
            {attachmentsToShow.map(
              ({id, attributes}) =>
              <li key={id} className='mb-2'>
                <a target="_blank" href={attributes.url} title={attributes.original_filename}>
                  <span className="attachment-original">{attributes.original_filename}</span></a>
                {prettyBytes(attributes.file_size)}
                <a href='' className='float-right text-danger' onClick={(e) => removeAttachment(e,id)}><i className='ion ion-md-remove-circle'/></a>
              </li>
              )}
            </ul>
        </div>
    </div>
    )
  }
}

TaskAttachments.propTypes = {
  taskId: PropTypes.string.isRequired,
  attachments: PropTypes.array.isRequired,
  title: PropTypes.string.isRequired
}

TaskAttachments.defaultProps = {
  title: 'Attachments'
}

export default TaskAttachments;
