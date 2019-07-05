import  React from 'react';
import Comment from './Comment';

const CommentsList = ({ comments, reactRouter, }) => {
  return (
    <>
      {comments.map(comment => (<Comment key={comment.id} comment={comment} reactRouter={reactRouter}/>))}
    </>
  );
};
export default CommentsList;
