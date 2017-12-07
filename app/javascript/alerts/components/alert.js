import React, { Component } from 'react'
import TimeAgo from 'react-timeago'
import classNames from 'classnames'

import utils from '../../utils'

export class Alert extends Component {
  renderAssignee () {
    const { assignee } = this.props

    if (!assignee) {
      return null
    }

    return (
      <div className='js-alert-block'>
        <p>
          <img
            className='ui mini avatar image'
            src={assignee.avatar}
          />
          <span className='text-gray'>
            {assignee.name} &bull;
          </span> fue asignado a esta alerta
        </p>
      </div>
    )
  }

  renderAuthor () {
    const { author, id, state, assignee, created_at: createdAt } = this.props
    const alertURL = `/dashboard/alerts/${id}`
    const badgeClass = classNames('ui small circle icon', {
      green: state === 'opened' && assignee === null,
      yellow: state === 'opened' && assignee !== null,
      red: state === 'closed'
    })

    return (
      <div className='js-alert-block'>
        <p>
          <img
            className='ui mini avatar image'
            src={author.avatar}
          />
          <span className='text-gray'>
            {author.name}
          </span>
        </p>

        <p>
          <i className={badgeClass} title={utils.humanizeState(state, assignee)} />
          Envío una alerta <a href={alertURL}>#{id}</a>
          <span className='text-gray text-small'> &bull; </span>
          <TimeAgo
            className='text-gray text-small'
            date={createdAt}
            formatter={utils.timeFormatter}
          />
        </p>

        {
          (state === 'opened' && assignee === null) &&
          <p>
            <button className='ui small basic button'>Asignarme</button>
          </p>
        }
      </div>
    )
  }

  render () {
    return (
      <div className='ui segment js-alert'>
        {this.renderAuthor()}
        {this.renderAssignee()}
      </div>
    )
  }
}

export default Alert
