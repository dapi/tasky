export const CssComment = {
    "display": 'flex',
    "marginBottom": '25px',
    '&__avatar': {
        display: 'inline-block',
        width: '45px',
        height: '45px',
        borderRadius: '50%',
        marginRight: '10px',
        backgroundSize: 'contain',
    },
    '&__col-right': {
        display: 'flex',
        flexWrap: 'wrap',
        width: 'calc(100% - 45px)',
        alignItems: 'center',
    },
    '&__col-right > a': {
        textDecoration: 'none',
    },
    '&__name': {
        fontSize: '18px',
        color: '#0088ff',
        marginRight: '10px',
    },
    '&__time': {
        fontSize: '14px',
        color: '#a4b8c9',
    },
    '&__content': {
        fontSize: '16px',
        flex: '1 100%',
    },
};
