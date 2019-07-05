import * as React from 'react';
import { Link as RouterLink } from 'react-router-dom';
const Link = ({ reactRouter, href, children, className, }) => {
    if (reactRouter) {
        return (<RouterLink className={className} to={href}>
        {children}
      </RouterLink>);
    }
    else {
        return (<a className={className} href={href}>
        {children}
      </a>);
    }
};
Link.defaultProps = {
    className: '',
    reactRouter: false,
};
export default Link;
