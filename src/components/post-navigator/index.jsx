import React from 'react'
import { Link } from 'gatsby'

import './index.scss'

export const PostNavigator = ({ pageContext }) => {
  const { previous, next } = pageContext

  return (
    <ul className="navigator">
      <li>
        {previous && (
          <Link to={previous.slug} rel="prev">
            ← {previous.title}
          </Link>
        )}
      </li>
      <li>
        {next && (
          <Link to={next.slug} rel="next">
            {next.title} →
          </Link>
        )}
      </li>
    </ul>
  )
}
