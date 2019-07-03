import React from 'react'
import PropTypes from 'prop-types'
import prettyBytes from 'pretty-bytes'

class TaskAttachments extends React.Component {
  render () {
    const { taskId, attachments, title } = this.props
    return (
      <div className='row mt-4'>
        <div className='col-md-1'>
          <div className='text-muted' style={ {fontSize: '24px'}}>
            <i className="ion ion-md-document"/>
          </div>
        </div>
        <div className='col-md-8'>
          <h4 className='text-muted card-dialog-subtitle'>{title} ({attachments.length})</h4>
          <ul className='list-unstyled'>
            {attachments.map(
              ({id, attributes}) =>
              <li key={id} className='mb-2'>
                <a target="_blank" href={attributes.url} title={attributes.original_filename}>
                  <span className="attachment-original">{attributes.original_filename}</span></a>
                {prettyBytes(attributes.file_size)}
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
