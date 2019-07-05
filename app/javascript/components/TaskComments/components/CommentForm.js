import { css } from 'emotion';
import * as React from 'react';
import { CssBtn } from '../styles/Btn.css';
import { CssTextarea } from '../styles/Textarea.css';
import { CssForm } from '../styles/Form.css';
import { CBContext } from './CommentsBlock';
class CommentForm extends React.Component {
    constructor(props) {
        super(props);
        this.onChange = (e) => {
            const { value } = e.target;
            this.setState(state => {
                if (state.enterPressed) {
                    return Object.assign({}, state, { enterPressed: false });
                }
                else {
                    return Object.assign({}, state, { text: value });
                }
            });
        };
        this.onEnter = (e) => {
            e.stopPropagation();
            if (e.key === 'Enter' && !e.shiftKey) {
                this.setState({
                    enterPressed: true,
                }, () => {
                    this.onSubmit();
                });
            }
        };
        this.onSubmit = (e) => {
            if (e) {
                e.preventDefault();
            }
            const text = this.state.text.trim().replace(/\n{3,}/g, '\n\n');
            this.props.onSubmit(text);
            this.setState({ text: '' });
        };
        this.state = {
            enterPressed: false,
            text: '',
        };
    }
    render() {
        const { text } = this.state;
        return (<CBContext.Consumer>
        {styles => {
            const btnCn = css(styles.btn(CssBtn));
            return (<form onSubmit={this.onSubmit} className={css(styles.form(CssForm))}>
              <textarea className={css(styles.textarea(CssTextarea))} name="comment-text" id="comment-text" placeholder="Leave a comment" value={text} onChange={this.onChange} onKeyPress={this.onEnter}/>
              <button className={btnCn}>Comment</button>
            </form>);
        }}
      </CBContext.Consumer>);
    }
}
export default CommentForm;
