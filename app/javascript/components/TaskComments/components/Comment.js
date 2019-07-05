import { css } from 'emotion';
import * as React from 'react';
import { CssComment } from '../styles/Comment.css';
import { CBContext } from './CommentsBlock';
import Link from './Link';

const Comment = ({ comment, reactRouter, showAsIs }) => {
  const { text, authorUrl, avatarUrl, createdAt, fullName } = comment;
  const textHtml = (<React.Fragment>
    {text.split('\n').map((chunk, inx, arr) => inx !== arr.length - 1 ? (<React.Fragment key={chunk + inx}>
      {chunk}
      <br />
    </React.Fragment>) : (chunk))}
  </React.Fragment>);
  return (<CBContext.Consumer>
    {styles => {
    const cn = css(styles.comment(CssComment));
    return (<div className={cn}>
      <Link reactRouter={reactRouter} href={authorUrl}>
        <div className={`${cn}__avatar`} style={{
          backgroundImage: `url(${avatarUrl})`,
          }}/>
      </Link>
      <div className={`${cn}__col-right`}>
        <Link reactRouter={reactRouter} href={authorUrl}>
          <div className={`${cn}__name`}>{fullName}</div>
        </Link>
        <div className={`${cn}__time`}>
          {createdAt.toLocaleDateString()}
        </div>
        {showAsIs ?
        <div className={`${cn}__content`} dangerouslySetInnerHTML={{ __html: text }}/> :
        <div className={`${cn}__content`}>{textHtml}</div>}
      </div>
    </div>);
    }}
  </CBContext.Consumer>);
};
Comment.defaultProps = {
  showAsIs: true
};
export default Comment;
