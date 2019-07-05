import { css } from 'emotion';
import * as React from 'react';
import { CssBtn } from '../styles/Btn.css';
import { CBContext } from './CommentsBlock';
import Link from './Link';
const CommentSignIn = ({ href, reactRouter, }) => {
    return (<CBContext.Consumer>
      {styles => {
        const btnCn = css(styles.btn(CssBtn));
        return (<React.Fragment>
            <div style={{ marginBottom: '10px', fontSize: '1.15em' }}>
              You should be signed in to write a comment.
            </div>
            <Link href={href} reactRouter={reactRouter} className={btnCn}>
              Sign In
            </Link>
          </React.Fragment>);
    }}
    </CBContext.Consumer>);
};
export default CommentSignIn;
