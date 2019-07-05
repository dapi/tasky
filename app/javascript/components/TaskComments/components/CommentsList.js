import * as React from 'react';
import Comment from './Comment';
const CommentsList = ({ comments, reactRouter, }) => {
    function renderComments() {
        return comments.map((comment, index) => (<Comment key={comment.fullName + comment.createdAt.getTime() + index} comment={comment} reactRouter={reactRouter}/>));
    }
    return <div>{renderComments()}</div>;
};
export default CommentsList;
