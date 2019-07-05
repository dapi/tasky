import React, { Component } from 'react'
import CommentsBlock from './TaskComments/components/CommentsBlock'
import uuidv1 from 'uuid/v1'
import { apiAddTaskComment, apiGetTaskComments } from 'helpers/requestor'
import PropTypes from 'prop-types'


const getAuthor = (included, user_id) => {
  return included.find( ({id}) => id === user_id)
}
const prepareComments = ({data, included}) =>
  data.map(comment => {
    const author = getAuthor(included, comment.relationships.author.data.id)
    return {
      id: comment.id,
      createdAt: new Date(comment.attributes.created_at),
      text: comment.attributes.formatted_content || '???',

      // send user instead
      fullName: author.public_nickname,
      authorUrl: '#',
      avatarUrl: author.avatar_url
    }
  }
)

class Comments extends Component {
  constructor(props) {
    super(props)
    this.state = { comments: [], isLoading: true }
  }
  updateComments = ({data}) => {
    this.setState({
      isLoading: false,
      comments: prepareComments(data)
    })
  }
  componentDidMount() {
    const { taskId } = this.props

    // Subscribe on task comments update and fetch all comments on succesful callback
    //
    apiGetTaskComments(taskId, this.updateComments)
  }

  handleSubmit(text) {
    const { currentUser, taskId } = this.props
    if (text.length == 0) { return }

    // const id = uuidv1()
    apiAddTaskComment(taskId, text)
  }

  render() {
    return (
      <CommentsBlock
        isLoggedIn
        comments={this.state.comments}
        onSubmit={this.handleSubmit.bind(this)}
      />
    )
  }
}

Comments.propTypes = {
  currentUser: PropTypes.object.isRequired,
  taskId: PropTypes.string.isRequired
}

export default Comments
