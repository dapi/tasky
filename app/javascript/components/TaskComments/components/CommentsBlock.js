import * as React from 'react';
import CommentForm from './CommentForm';
import CommentSignIn from './CommentSignIn';
import CommentsList from './CommentsList';
const defaultStyles = {
    btn: base => (Object.assign({}, base)),
    comment: base => (Object.assign({}, base)),
    textarea: base => (Object.assign({}, base)),
    form: base => (Object.assign({}, base))
};
export const CBContext = React.createContext(defaultStyles);
class CommentsBlock extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            styles: defaultStyles,
        };
    }
    static getDerivedStateFromProps(props, state) {
        return {
            styles: Object.assign({}, state.styles, props.styles),
        };
    }
    render() {
        const { comments, isLoggedIn, signinUrl, onSubmit, reactRouter, } = this.props;
        return (<CBContext.Provider value={this.state.styles}>
        <div>
          {isLoggedIn ? (<CommentForm onSubmit={onSubmit}/>) : (<CommentSignIn href={signinUrl} reactRouter={reactRouter}/>)}
          <CommentsList comments={comments} reactRouter={reactRouter}/>
        </div>
      </CBContext.Provider>);
    }
}
CommentsBlock.defaultProps = {
    isLoggedIn: false,
    reactRouter: false,
    styles: defaultStyles,
};
export default CommentsBlock;
