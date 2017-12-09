import React, { Component } from 'react'
import TimeAgo from 'react-timeago'
import classNames from 'classnames'

import utils from '../../utils'
import Octicon from '../../octicon'

export class Alert extends Component {
  renderAuthor () {
    const { author } = this.props

    return (
      <p className='mb-1'>
        <img
          className='rounded img-mini-avatar mr-2'
          src={author.avatar}
        />
        <span className='align-middle'>{author.name}</span>
      </p>
    )
  }

  renderAction () {
    const { id, state, assignee, created_at: createdAt } = this.props
    const alertURL = `/dashboard/alerts/${id}`
    const iconClass = classNames('mr-2', {
      'text-success': state === 'opened' && assignee === null,
      'text-warning': state === 'opened' && assignee !== null,
      'text-red': state === 'closed'
    })

    return (
      <p className='mb-2'>
        <Octicon icon='issue-opened' class={iconClass} />
        <span className='align-middle'>
          Envío una alerta <a href={alertURL}>#{id}</a>
          <small className='text-secondary'>
            &nbsp;&bull;&nbsp;
            <TimeAgo
              className='text-secondary'
              date={createdAt}
              formatter={utils.timeFormatter}
            />
          </small>
        </span>
      </p>
    )
  }

  renderAssigneeButton () {
    const { state, assignee } = this.props

    if (state === 'opened' && assignee === null) {
      return (
        <p className='mb-1'>
          <button className='btn btn-outline-primary btn-sm'>Asignarme</button>
        </p>
      )
    }
  }

  renderAssignee () {
    const { assignee } = this.props

    if (!assignee) {
      return null
    }

    return (
      <div className='js-alert-block'>
        <p>
          <img
            className='ui mini avatar image mr-0-5'
            src={assignee.avatar}
          />
          <span className='text-gray'>
            {assignee.name} &bull;
          </span> fue asignado a esta alerta
        </p>
      </div>
    )
  }

  render () {
    return (
      <li className='list-group-item js-alert'>
        {this.renderAuthor()}
        {this.renderAction()}
        {this.renderAssigneeButton()}
        {this.renderAssignee()}
      </li>
    )
  }
}

export default Alert
