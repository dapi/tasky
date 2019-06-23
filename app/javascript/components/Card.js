import React from 'react'
import { CardTitle, Footer } from './styles/Base'

import Tag from 'react-trello/src/components/Tag'

const Card = ({ card, tagStyle }) => {
  const { title, description, tags, commentsCount } = card;
  const showDescription = (description || '').length > 0
  const showTags = (tags || []).length > 0
  const showFooter = showDescription || showTags || commentsCount > 0
  return (
    <span>
      <CardTitle>{title}</CardTitle>
      {showFooter &&
        <Footer className="mt-1">
          <ul className="list-inline mb-0">
            {showDescription && <li class="list-inline-item"><i className="ion ion-md-list" /></li>}
            {commentsCount > 0 && <li class="list-inline-item"><i className="ion ion-md-chatboxes" /><small className="ml-1">{commentsCount}</small></li>}
          </ul>
          {showTags &&
            <ul className="list-inline mb-0">
              {tags.map(tag => <li class="list-inline-item"><Tag key={tag.title} {...tag} tagStyle={tag.tagStyle || tagStyle} /></li>)}
            </ul>
          }
        </Footer>
      }
    </span>
  )
}

export default Card
