import { css } from 'emotion';
import  React from 'react';
import { CssComment } from '../styles/Comment.css';
import { CBContext } from './CommentsBlock';
import Link from './Link';

const Comment = ({ comment, reactRouter, showAsIs }) => {
  const { text, authorUrl, avatarUrl, createdAt, fullName } = comment;
  return (<CBContext.Consumer>
    {styles => {
    const cn = css(styles.comment(CssComment));
    return (
      <div className={cn}>
        <div className={`${cn}__avatar`} style={{
          backgroundImage: `url(${avatarUrl})`,
          }}/>
        <div className={`${cn}__col-right`}>
          <div className={`${cn}__name`}>{fullName}</div>
          <div className={`${cn}__time`}>{createdAt.toLocaleDateString()}</div>
          <div className={`${cn}__content`} dangerouslySetInnerHTML={{ __html: text }}/>
        </div>
      </div>);
    }}
  </CBContext.Consumer>);
};

Comment.defaultProps = {
  showAsIs: true
};

export default Comment;
