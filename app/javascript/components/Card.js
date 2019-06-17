import React from "react"
import {CardTitle, Footer } from './styles/Base'

const Card = ({title, description, labe, tags}) => {
  const showFooter = (description || '').length > 0
  return (
    <span>
      <CardTitle>{title}</CardTitle>
      {showFooter && (
        <Footer>
          <i className='ion ion-md-list'/>
          {(tags || []).map(tag => (
            <Tag key={tag.title} {...tag} tagStyle={this.props.tagStyle} />
          ))}
        </Footer>
      )}
    </span>
  )
}

export default Card;
