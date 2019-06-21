import React from 'react'
import { CardTitle, Footer } from './styles/Base'

import Tag from 'react-trello/src/components/Tag'

const Card = ({ card, tagStyle }) => {
  const { title, description, tags } = card;
  const showFooter = (description || '').length > 0 || (tags || []).length > 0
  return (
    <span>
      <CardTitle>{title}</CardTitle>
      {showFooter && (
        <Footer>
          <i className="ion ion-md-list" />
          {(tags || []).map(tag => (
            <Tag key={tag.title} {...tag} tagStyle={tag.tagStyle || tagStyle} />
          ))}
        </Footer>
      )}
    </span>
  )
}

export default Card
