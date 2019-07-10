import React from 'react'
import { CardTitle, Footer } from './styles/Base'

import Tag from 'react-trello/src/components/Tag'

const Card = ({ card, tagStyle }) => {
  const { id, title, details, tags, comments_count, unseen_comments_count, attachments_count, memberships } = card;
  const showDescription = (details || '').length > 0
  const showTags = (tags || []).length > 0
  const showFooter = showDescription || showTags || unseen_comments_count > 0 || comments_count > 0 || attachments_count > 0 || (memberships || []).length > 0
  return (
    <span>
      <CardTitle>{title}</CardTitle>
      {showFooter &&
        <Footer className="mt-1">
          <ul className="list-inline mb-0 mr-2">
            {showDescription && <li className="list-inline-item mr-2"><i className="ion ion-md-list" /></li>}
            {attachments_count > 0 && <li className="list-inline-item"><i className="ion ion-md-attach" /><small className="ml-1">{attachments_count}</small></li>}
            {comments_count > 0 && <li className="list-inline-item"><i className="ion ion-md-chatboxes" /><small className="ml-1">{comments_count}</small></li>}
            {unseen_comments_count > 0 && <li className="list-inline-item text-danger"><i className="ion ion-md-notifications" /><small className="ml-1">{unseen_comments_count}</small></li>}
            {(tags || []).map(tag => <li className="list-inline-item" key={tag.title}><Tag {...tag} tagStyle={tag.tagStyle || tagStyle} /></li>)}
            {(memberships || []).map(membership =>
            <li className="list-inline-item" key={membership.id}>
              <img src={membership.avatarUrl} style={{borderRadius:'50%', marginRight: '2px'}} width={24} height={24} title={membership.publicName} alt={membership.publicName} />
            </li>
            )}
          </ul>
        </Footer>
      }
    </span>
  )
}

export default Card
