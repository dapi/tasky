import React, { Component } from 'react';
import CommentsBlock from 'simple-react-comments/src/components/CommentsBlock';
import uuidv1 from 'uuid/v1';
import {
  apiAddTaskComment
} from '../helpers/requestor'

const prepareComments = comments =>
  comments.map( comment => { return { ...comment, createdAt: new Date(comment.createdAt) } } )

class TaskComments extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: prepareComments(props.comments)
    };
  }
  handleSubmit(text) {
    const { user, task, account } = this.props;
    if (text.length == 0) { return }

    const id = uuidv1();
    this.setState({
      comments: [
        {
          id: id,
          avatarUrl: user.avatarUrl,
          createdAt: new Date(),
          fullName: user.fullName,
          text,
        },
        ...this.state.comments
      ],
    })
    apiAddTaskComment(task.id, id, text);
  }

  render() {
    return (
      <CommentsBlock
        comments={this.state.comments}
        isLoggedIn
        onSubmit={this.handleSubmit.bind(this)}
      />
    );
  }
}

export default TaskComments;
